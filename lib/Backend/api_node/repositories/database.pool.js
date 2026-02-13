import mysql from "mysql2/promise";

const pools = {};

export const getPool = async (config) => {
  const { host, port, user, password, database } = config;

  if (!database || typeof database !== "string" || !database.trim()) {
    throw new Error('"database" debe ser un string válido');
  }

  if (!host || !port || !user || !password) {
    throw new Error("Todas las credenciales deben estar definidas");
  }

  const poolKey = `${host}:${port}:${user}:${database}`;
  if (pools[poolKey]) return pools[poolKey];


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


  pools[poolKey] = pool;
  console.log(`Conectado a DB: ${poolKey}`);
  return pool;
};

export const buildDbConfig = (req) => {
  const dbName = req.params.db || req.query.db;
  if (!dbName) throw new Error("No se especificó la base de datos");

  return {
    host: req.query.host,
    port: Number(req.query.port),
    user: req.query.user,
    password: req.query.password,
    database: dbName
  };
};
