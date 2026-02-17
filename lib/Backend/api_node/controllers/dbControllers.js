import databaseService from '../services/database.service.js';
import { getPool} from '../repositories/database.pool.js';

// 🔹 Administración de bases
export async function handleDbAction(req, res) {
  const { action, host, port, user, password, database, newDatabase } = req.body;

  if (!action || !database) return res.status(400).json({ error: "Datos incompletos" });

  try {
    const result = await databaseService.handleAction(action, {
      host, port, user, password, database, newDatabase
    });

    if (!result.ok) return res.status(403).json(result);
    return res.status(200).json(result);
  } catch (err) {
    console.error("Error en handleDbAction:", err);
    return res.status(500).json({ error: err.message });
  }
}

// 🔹 Función genérica para queries
export const handleDynamicQuery = async (req, res, sql, params = [], singleResult = false) => {
  const { host, port, user, password } = req.query; // credenciales dinámicas desde query
  const dbName = req.params.db || req.query.db;


  try {
    const { pool, error }  = await getPool({
      host,
      port: Number(port),
      user,
      password,
      database: dbName
    });

        if (error) {
          return res.status(500).json({ error: `Error en ${req.originalUrl}`, details: error.message });
        }


    const connection = await pool.getConnection();
    try {
      const [rows] = await connection.query(sql, params);
      return res.json(singleResult ? rows[0] || null : rows);
    } finally {
      connection.release();
    }
  } catch (err) {
    console.error(`Error en ${req.originalUrl}:`, err.message);
    res.status(500).json({ error: `Error en ${req.originalUrl}`, details: err.message });
  }
};
