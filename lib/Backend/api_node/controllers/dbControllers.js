import databaseService from '../services/database.service.js';
import { getPool } from '../repositories/database.pool.js';

// =========================
// ADMINISTRACIÓN DE BASES
// =========================

export const handleDbAction = async (req, res) => {

  try {

    const { action, ...config } = req.body;

    const result = await databaseService.handleAction(
      action,
      config
    );

    if (result?.ok === false) {
      return res.status(400).json(result);
    }

    return res.json(result);

  } catch (err) {

    console.error('Error en handleDbAction:', err);

    return res.status(500).json({
      ok: false,
      error: {
        type: 'UnhandledError',
        code: err.code || 'UNKNOWN',
        message: err.message || 'Error inesperado'
      }
    });
  }
};


// =========================
// CONSULTAS DINÁMICAS
// =========================

export const handleDynamicQuery = async (
  req,
  res,
  sql,
  params = [],
  singleResult = false
) => {

  const host = req.query.host || process.env.DB_HOST;
  const port = Number(req.query.port || process.env.DB_PORT);
  const user = req.query.user || process.env.DB_USER;
  const password = req.query.password || process.env.DB_PASSWORD;

  const dbName =
    req.params.db ||
    req.query.db ||
    process.env.DB_DATABASE;

  try {

    const { pool, error } = await getPool({
      host,
      port,
      user,
      password,
      database: dbName
    });

    if (error) {

      return res.status(500).json({
        ok: false,
        error: {
          type: error.type || 'ConnectionError',
          code: error.code || 'UNKNOWN',
          message: error.message ||
            `Error al conectar con ${dbName}`
        }
      });
    }

    const connection = await pool.getConnection();

    try {

      const [rows] = await connection.query(sql, params);

      return res.json(
        singleResult
          ? rows[0] || null
          : rows
      );

    } finally {

      connection.release();

    }

  } catch (err) {

    console.error(
      `Error en ${req.originalUrl}:`,
      err
    );

    return res.status(500).json({
      error: err.message
    });
  }
};