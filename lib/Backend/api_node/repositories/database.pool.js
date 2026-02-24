import mysql from "mysql2/promise";

const pools = {};

export const getPool = async (config) => {
  const { host, port, user, password, database } = config;

  // Validación estricta de los datos
  if (!config.host || !config.port || !config.user || !config.password || !config.database) {
    console.error("Parámetros de conexión incompletos. Abortando todo el servidor.");
     process.exit(1);
  }
  const poolKey = `${host}:${port}:${user}:${database}`;
 if (pools[poolKey]) {
   try {
     const conn = await pools[poolKey].getConnection();
     conn.release();
     return { pool: pools[poolKey], error: null };
   } catch {
     delete pools[poolKey]; // pool inválido → recrear
   }
 }

  try {
    const pool = mysql.createPool({
      host,
      port,
      user,
      password,
      database,
      waitForConnections: true,
      connectionLimit: 10,
    });

    // Verificar que la conexión funciona
    const connection = await pool.getConnection();
    connection.release();

    // Guardar el pool SOLO si todo fue bien
    pools[poolKey] = pool;
    console.log(`Conectado a DB: ${poolKey}`);

    return { pool, error: null }; // <
  } catch (err) {
       let errorInfo = {
          code: err.code || 'UNKNOWN',
          message: err.message,
          type: 'unknown',
        };

switch (err.code) {
  case 'ENOTFOUND':
    errorInfo.message = 'Unknown host';
    errorInfo.type = 'dns';
    break;

  case 'ECONNREFUSED':
    errorInfo.message = 'Connection refused (check host or port)';
    errorInfo.type = 'connection';
    break;

  case 'ER_ACCESS_DENIED_ERROR':
    errorInfo.message = 'Access denied for user';
    errorInfo.type = 'auth';
    break;

  case 'ER_BAD_DB_ERROR':
    errorInfo.message = 'Unknown database';
    errorInfo.type = 'database';
    break;

  case 'ETIMEDOUT':
    errorInfo.message = 'Connection timed out';
    errorInfo.type = 'timeout';
    break;
}

    return { pool: null, error: errorInfo };
  }

};
