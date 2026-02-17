import mysql from "mysql2/promise";

const pools = {};

export const getPool = async (config) => {
  const { host, port, user, password, database } = config;

 if (!database || !database.trim()) {
    return {
      pool: null,
      error: {
        type: 'config',
        code: 'INVALID_DATABASE',
        message: 'Database requerida para conectar',
      },
    };
  }
  const poolKey = `${host}:${port}:${user}:${database}`;
  if (pools[poolKey]) return  { pool: pools[poolKey], error: null };

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
console.log(err.code)
    switch (err.code) {
      case 'ENOTFOUND':
        errorInfo.type = 'SocketException';
        errorInfo.message = `Host no encontrado (${host})`;
        break;

      case 'ECONNREFUSED':
        errorInfo.type = 'unknown host';
        errorInfo.message = `Puerto ${port} cerrado o MySQL apagado`;
        break;

      case 'ER_ACCESS_DENIED_ERROR':
        errorInfo.type = 'Access denied for user';
        errorInfo.message = `Usuario o contraseña incorrectos`;
        break;

      case 'ER_BAD_DB_ERROR':
        errorInfo.type = 'Unknown database';
        errorInfo.message = `La base de datos "${database}" no existe`;
        break;

      case 'ETIMEDOUT':
        errorInfo.type = 'is not allowed to connect to this MySQL server';
        errorInfo.message = `Timeout al conectar con ${host}:${port}`;
        break;
    }

    return { pool: null, error: errorInfo };
  }

};
