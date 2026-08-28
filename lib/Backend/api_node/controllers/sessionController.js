import bcrypt from "bcrypt";
import crypto from "crypto";
import { getPool } from "../repositories/database.pool.js";

export const login = async (req, res) => {

  try {

    const {
      username,
      password,
      host,
      port,
      dbUser,
      dbPassword,
      database
    } = req.body;

    if (!username || !password) {
      return res.status(400).json({
        ok: false,
        message: "Usuario y contraseña son obligatorios"
      });
    }

    const { pool, error } = await getPool({
      host,
      port: Number(port),
      user: dbUser,
      password: dbPassword,
      database
    });

    if (error) {
      return res.status(500).json({
        ok: false,
        message: error.message
      });
    }

    const connection = await pool.getConnection();

    try {

      const [rows] = await connection.query(
        `
        SELECT id, username, password_hash, role, active
        FROM users
        WHERE username = ?
        LIMIT 1
        `,
        [username]
      );

      if (rows.length === 0) {
        return res.status(401).json({
          ok: false,
          message: "Usuario o contraseña incorrectos"
        });
      }

      const dbUserData = rows[0];

      if (!dbUserData.active) {
        return res.status(403).json({
          ok: false,
          message: "Usuario inactivo"
        });
      }

      const validPassword = await bcrypt.compare(
        password,
        dbUserData.password_hash
      );

      if (!validPassword) {
        return res.status(401).json({
          ok: false,
          message: "Usuario o contraseña incorrectos"
        });
      }

      const sessionId = crypto.randomUUID();

      const createdAt = new Date();
      const expiresAt = new Date(
        createdAt.getTime() + 24 * 60 * 60 * 1000
      );

      await connection.query(
        `
        INSERT INTO sessions
          (id, user_id, created_at, expires_at)
        VALUES (?, ?, ?, ?)
        `,
        [
          sessionId,
          dbUserData.id,
          createdAt,
          expiresAt
        ]
      );

      return res.json({
        ok: true,

        user: {
          id: dbUserData.id,
          username: dbUserData.username,
          role: dbUserData.role,
          active: dbUserData.active
        },

        session: {
          id: sessionId,
          user_id: dbUserData.id,
          created_at: createdAt,
          expires_at: expiresAt
        }
      });

    } finally {

      connection.release();

    }

  } catch (err) {

    console.error("Error en session login:", err);

    return res.status(500).json({
      ok: false,
      message: err.message
    });
  }
};

export const logout = async (req, res) => {

  try {

    const {
      sessionId,
      host,
      port,
      dbUser,
      dbPassword,
      database
    } = req.body;


    console.log("LOGOUT CONFIG:", {
      sessionId,
      host,
      port,
      dbUser,
      database
    });

    if (!sessionId) {
      return res.status(400).json({
        ok: false,
        message: "Falta sessionId"
      });
    }

    const { pool, error } = await getPool({
      host,
      port: Number(port),
      user: dbUser,
      password: dbPassword,
      database
    });

    if (error) {
      return res.status(500).json({
        ok: false,
        message: error.message
      });
    }

    const connection = await pool.getConnection();

    try {

      await connection.query(
        `
        DELETE FROM sessions
        WHERE id = ?
        `,
        [sessionId]
      );

      return res.json({
        ok: true,
        message: "Sesión cerrada correctamente"
      });

    } finally {

      connection.release();

    }

  } catch (err) {

    console.error("Error en session logout:", err);

    return res.status(500).json({
      ok: false,
      message: err.message
    });
  }
};

export const restore = async (req, res) => {

  try {

    const {
      sessionId,
      host,
      port,
      dbUser,
      dbPassword,
      database
    } = req.body;

    if (!sessionId) {
      return res.status(400).json({
        ok: false,
        message: "Falta sessionId"
      });
    }

    const { pool, error } = await getPool({
      host,
      port: Number(port),
      user: dbUser,
      password: dbPassword,
      database
    });

    if (error) {
      return res.status(500).json({
        ok: false,
        message: error.message
      });
    }

    const connection = await pool.getConnection();

    try {

      const [sessionRows] = await connection.query(
        `
        SELECT id, user_id, created_at, expires_at
        FROM sessions
        WHERE id = ?
        LIMIT 1
        `,
        [sessionId]
      );

      if (sessionRows.length === 0) {
        return res.status(404).json({
          ok: false,
          message: "Sesión no encontrada"
        });
      }

      const session = sessionRows[0];

      // Comprobar expiración
      if (new Date(session.expires_at) <= new Date()) {

        await connection.query(
          `
          DELETE FROM sessions
          WHERE id = ?
          `,
          [sessionId]
        );

        return res.status(404).json({
          ok: false,
          message: "Sesión expirada"
        });
      }

      const [userRows] = await connection.query(
        `
        SELECT id, username, role, active
        FROM users
        WHERE id = ?
        LIMIT 1
        `,
        [session.user_id]
      );

      if (userRows.length === 0) {
        return res.status(404).json({
          ok: false,
          message: "Usuario no encontrado"
        });
      }

      const user = userRows[0];

      if (!user.active) {
        return res.status(403).json({
          ok: false,
          message: "Usuario inactivo"
        });
      }

      return res.json({
        ok: true,

        user: {
          id: user.id,
          username: user.username,
          role: user.role,
          active: user.active
        },

        session: {
          id: session.id,
          user_id: session.user_id,
          created_at: session.created_at,
          expires_at: session.expires_at
        }
      });

    } finally {

      connection.release();

    }

  } catch (err) {

    console.error("Error en session restore:", err);

    return res.status(500).json({
      ok: false,
      message: err.message
    });
  }
};