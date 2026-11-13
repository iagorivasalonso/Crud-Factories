
import crypto from "crypto";
import bcrypt from "bcrypt";
import { getPool } from "../repositories/database.pool.js";
import { sendMailUser } from "../services/mail.service.js";
import { decrypt } from "../services/crypto.service.js";

const MAX_ATTEMPTS = 5;
const RESET_MINUTES = 10;

// Obtener conexión a la base de datos
const getConnection = async (config) => {

  const { pool, error } = await getPool({
    host: config.host,
    port: Number(config.port),
    user: config.dbUser,
    password: config.dbPassword,
    database: config.database
  });

  if (error || !pool) {
    throw new Error(error?.message || "Error de conexión");
  }

  return pool.getConnection();
};

// Generar hash del token
const hashToken = (token) =>
  crypto.createHash("sha256").update(token).digest("hex");


// =====================================================
// SOLICITAR RECUPERACIÓN
// =====================================================
export const requestPasswordReset = async (req, res) => {

  let connection;

  try {

    const { username, mail } = req.body;

    if (!username || !mail) {
      return res.status(400).json({
        ok: false,
        message: "Usuario y correo son obligatorios"
      });
    }

    connection = await getConnection(req.body);

    const [users] = await connection.query(
      `
      SELECT id, username, mail
      FROM users
      WHERE username = ? AND mail = ? AND active = 1
      LIMIT 1
      `,
      [username, mail]
    );

    // Respuesta genérica para no revelar si existe el usuario
    if (users.length === 0) {
      return res.json({
        ok: true,
        message: "Si los datos son correctos, recibirás un correo"
      });
    }

    const user = users[0];

    // Buscar cuentas SMTP de administradores activos
    const [adminMails] = await connection.query(
      `
      SELECT m.mail, m.host, m.port, m.secure, m.password
      FROM mails m
      INNER JOIN users u ON u.id = m.user_id
      WHERE u.role = 'admin'
        AND u.active = 1
      ORDER BY m.id
      `
    );

    if (adminMails.length === 0) {
      throw new Error("No hay cuentas SMTP de administradores");
    }

    // Token aleatorio seguro
    const token = crypto.randomBytes(32).toString("hex");
    const tokenHash = hashToken(token);

    const createdAt = new Date();
    const expiresAt = new Date(
      createdAt.getTime() + RESET_MINUTES * 60 * 1000
    );

    // Invalidar solicitudes anteriores
    await connection.query(
      `
      UPDATE password_resets
      SET used = 1
      WHERE user_id = ? AND used = 0
      `,
      [user.id]
    );

    // Guardar el hash, nunca el token original
    await connection.query(
      `
      INSERT INTO password_resets
        (user_id, token_hash, expires_at, used, attempts)
      VALUES (?, ?, ?, 0, 0)
      `,
      [user.id, tokenHash, expiresAt]
    );

    // Intentar enviar utilizando las cuentas SMTP de administradores
    let sent = false;

    for (const account of adminMails) {

      const results = await sendMailUser({
        host: account.host,
        port: Number(account.port),
        secure: Boolean(account.secure),
        username: account.mail,
        password: decrypt(account.password),
        mail: user.mail,
        subject: "Recuperación de contraseña",
        message:
          `Hola ${user.username}.\n\n` +
          `Tu código de recuperación es:\n\n${token}\n\n` +
          `Caduca en ${RESET_MINUTES} minutos.\n\n` +
          "Si no has solicitado este cambio, ignora este correo."
      });

      if (results.some(result => result.status === "sent")) {
        sent = true;
        break;
      }
    }

    if (!sent) {

      await connection.query(
        `
        UPDATE password_resets
        SET used = 1
        WHERE token_hash = ?
        `,
        [tokenHash]
      );

      throw new Error("No se pudo enviar el correo de recuperación");
    }

    return res.json({
      ok: true,
      message: "Si los datos son correctos, recibirás un correo"
    });

  } catch (err) {

    console.error("Error solicitando recuperación:", err);

    return res.status(500).json({
      ok: false,
      message: err.message
    });

  } finally {

    if (connection) connection.release();

  }
};


// =====================================================
// VALIDAR CÓDIGO
// =====================================================
export const verifyPasswordReset = async (req, res) => {

  let connection;

  try {

    const { username, mail, token } = req.body;

    if (!username || !mail || !token) {
      return res.status(400).json({
        ok: false,
        message: "Faltan datos para validar el código"
      });
    }

    connection = await getConnection(req.body);

    const [rows] = await connection.query(
      `
      SELECT pr.id, pr.token_hash, pr.expires_at,
             pr.used, pr.attempts
      FROM password_resets pr
      INNER JOIN users u ON u.id = pr.user_id
      WHERE u.username = ? AND u.mail = ?
      ORDER BY pr.id DESC
      LIMIT 1
      `,
      [username, mail]
    );

    if (rows.length === 0) {
      return res.status(400).json({
        ok: false,
        message: "Código no válido"
      });
    }

    const reset = rows[0];

    if (reset.used || reset.attempts >= MAX_ATTEMPTS) {
      return res.status(400).json({
        ok: false,
        message: "Código no válido o agotado"
      });
    }

    if (new Date(reset.expires_at) <= new Date()) {

      await connection.query(
        "UPDATE password_resets SET used = 1 WHERE id = ?",
        [reset.id]
      );

      return res.status(400).json({
        ok: false,
        message: "El código ha caducado"
      });
    }

    if (hashToken(token) !== reset.token_hash) {

      const attempts = reset.attempts + 1;

      await connection.query(
        `
        UPDATE password_resets
        SET attempts = ?, used = ?
        WHERE id = ?
        `,
        [
          attempts,
          attempts >= MAX_ATTEMPTS ? 1 : 0,
          reset.id
        ]
      );

      return res.status(400).json({
        ok: false,
        message: "Código incorrecto",
        attemptsRemaining: Math.max(0, MAX_ATTEMPTS - attempts)
      });
    }

    return res.json({
      ok: true,
      valid: true,
      message: "Código correcto"
    });

  } catch (err) {

    console.error("Error validando recuperación:", err);

    return res.status(500).json({
      ok: false,
      message: err.message
    });

  } finally {

    if (connection) connection.release();

  }
};


// =====================================================
// CAMBIAR CONTRASEÑA
// =====================================================
export const resetPassword = async (req, res) => {

  let connection;

  try {

    const { username, mail, token, newPassword } = req.body;

    if (!username || !mail || !token || !newPassword) {
      return res.status(400).json({
        ok: false,
        message: "Faltan datos para cambiar la contraseña"
      });
    }



    connection = await getConnection(req.body);

    const [rows] = await connection.query(
      `
      SELECT pr.id, pr.token_hash, pr.expires_at,
             pr.used, pr.attempts, pr.user_id
      FROM password_resets pr
      INNER JOIN users u ON u.id = pr.user_id
      WHERE u.username = ? AND u.mail = ?
      ORDER BY pr.id DESC
      LIMIT 1
      `,
      [username, mail]
    );

    if (rows.length === 0) {
      return res.status(400).json({
        ok: false,
        message: "Código no válido"
      });
    }

    const reset = rows[0];

    if (
      reset.used ||
      reset.attempts >= MAX_ATTEMPTS ||
      new Date(reset.expires_at) <= new Date() ||
      hashToken(token) !== reset.token_hash
    ) {
      return res.status(400).json({
        ok: false,
        message: "Código no válido o caducado"
      });
    }

    const passwordHash = await bcrypt.hash(newPassword, 10);

    await connection.beginTransaction();

    await connection.query(
      `
      UPDATE users
      SET password_hash = ?
      WHERE id = ?
      `,
      [passwordHash, reset.user_id]
    );

    await connection.query(
      `
      UPDATE password_resets
      SET used = 1
      WHERE id = ?
      `,
      [reset.id]
    );

    await connection.commit();

    return res.json({
      ok: true,
      message: "Contraseña actualizada correctamente"
    });

  } catch (err) {

    if (connection) {
      await connection.rollback().catch(() => {});
    }

    console.error("Error cambiando contraseña:", err);

    return res.status(500).json({
      ok: false,
      message: err.message
    });

  } finally {

    if (connection) connection.release();

  }
};
