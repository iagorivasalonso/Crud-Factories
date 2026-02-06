import express from "express";
 import { createPool } from "mysql2/promise";
 import { handleDbAction } from "../controllers/dbControllers.js";

 const router = express.Router();

 // -------------------------
 // Pool dinámico por base de datos
 // -------------------------
 const pools = {};
 const getPool = (dbName) => {
   if (!pools[dbName]) {
     pools[dbName] = createPool({
       host: "localhost",
       port: 3307,
       user: "root",
       password: "usbw",
       database: dbName,
       waitForConnections: true,
       connectionLimit: 10,
       queueLimit: 0,
     });
   }
   return pools[dbName];
 };

 // -------------------------
 // POST de ejemplo
 // -------------------------
 router.post("/db", handleDbAction);

 // -------------------------
 // GET sectores dinámico
 // Soporta URL con /:db/sectors o query ?db=
 // -------------------------
 router.get(["/:db/sectors", "/sectors"], async (req, res) => {
   const dbName = req.params.db || req.query.db;
   if (!dbName) return res.status(400).json({ error: "No se especificó la base de datos" });

   try {
     const pool = getPool(dbName);
     const connection = await pool.getConnection();
     try {
       const [rows] = await connection.query("SELECT * FROM sectors");
       res.json(rows);
     } finally {
       connection.release();
     }
   } catch (err) {
     console.error(`Error al obtener sectores de ${dbName}:`, err.message);
     res.status(500).json({ error: `Error al obtener sectores de ${dbName}`, details: err.message });
   }
 });

 router.get(["/:db/factories", "/factories"], async (req, res) => {
    const dbName = req.params.db || req.query.db;
    if (!dbName) return res.status(400).json({ error: "No se especificó la base de datos" });

    try {
      const pool = getPool(dbName);
      const connection = await pool.getConnection();
      try {
        const [rows] = await connection.query("SELECT * FROM factories");
        res.json(rows);
      } finally {
        connection.release();
      }
    } catch (err) {
      console.error(`Error al obtener empresas de ${dbName}:`, err.message);
      res.status(500).json({ error: `Error al obtener empresas de ${dbName}`, details: err.message });
    }
  });


router.delete('/:db/sectors/:id', async (req, res) => {
  const { db, id } = req.params;
  if (!db) return res.status(400).json({ error: "No se especificó la base de datos" });

  try {
    const pool = getPool(db);
    const connection = await pool.getConnection();
    try {
      await connection.query('DELETE FROM sectors WHERE id=?', [id]);
      res.json({ success: true });
    } finally {
      connection.release();
    }
  } catch (err) {
    console.error(`Error al borrar sector ${id} de ${db}:`, err.message);
    res.status(500).json({ error: `Error al borrar sector`, details: err.message });
  }
});

// MODIFY sector
router.put('/:db/sectors/:id', async (req, res) => {
  const { db, id } = req.params;
  const { sector } = req.body;
  if (!db) return res.status(400).json({ error: "No se especificó la base de datos" });

  try {
    const pool = getPool(db);
    const connection = await pool.getConnection();
    try {
      await connection.query('UPDATE sectors SET sector=? WHERE id=?', [sector, id]);
      res.json({ success: true });
    } finally {
      connection.release();
    }
  } catch (err) {
    console.error(`Error al modificar sector ${id} de ${db}:`, err.message);
    res.status(500).json({ error: `Error al modificar sector`, details: err.message });
  }
});

// =======================
// FACTORIES
// =======================

router.delete('/:db/factories/:id', async (req, res) => {
  const { db, id } = req.params;
  if (!db) return res.status(400).json({ error: "No se especificó la base de datos" });
  try {
    const pool = getPool(db);
    const connection = await pool.getConnection();
    try {
      await connection.query('DELETE FROM factories WHERE id=?', [id]);
      res.json({ success: true });
    } finally {
      connection.release();
    }
  } catch (err) {
    console.error(`Error al borrar factory ${id} de ${db}:`, err.message);
    res.status(500).json({ error: `Error al borrar factory`, details: err.message });
  }
});

router.put('/:db/factories/:id', async (req, res) => {
  const { db, id } = req.params;
  const { name, highDate, sector, thelephones, mail, web, address } = req.body;
  if (!db) return res.status(400).json({ error: "No se especificó la base de datos" });
  try {
    const pool = getPool(db);
    const connection = await pool.getConnection();
    try {
      await connection.query(
        'UPDATE factories SET name=?, highDate=?, sector=?, thelephones=?, mail=?, web=?, address=? WHERE id=?',
        [name, highDate, sector, JSON.stringify(thelephones), mail, web, JSON.stringify(address), id]
      );
      res.json({ success: true });
    } finally {
      connection.release();
    }
  } catch (err) {
    console.error(`Error al modificar factory ${id} de ${db}:`, err.message);
    res.status(500).json({ error: `Error al modificar factory`, details: err.message });
  }
});

// =======================
// EMPLEOYES
// =======================

router.get(['/:db/empleoyes', '/empleoyes'], async (req, res) => {
  const dbName = req.params.db || req.query.db;
  if (!dbName) return res.status(400).json({ error: "No se especificó la base de datos" });

  try {
    const pool = getPool(dbName);
    const connection = await pool.getConnection();
    try {
      const [rows] = await connection.query("SELECT * FROM empleoyes");
      res.json(rows);
    } finally {
      connection.release();
    }
  } catch (err) {
    console.error(`Error al obtener empleoyes de ${dbName}:`, err.message);
    res.status(500).json({ error: `Error al obtener empleoyes de ${dbName}`, details: err.message });
  }
});

router.delete('/:db/empleoyes/:id', async (req, res) => {
  const { db, id } = req.params;
  if (!db) return res.status(400).json({ error: "No se especificó la base de datos" });
  try {
    const pool = getPool(db);
    const connection = await pool.getConnection();
    try {
      await connection.query('DELETE FROM empleoyes WHERE id=?', [id]);
      res.json({ success: true });
    } finally {
      connection.release();
    }
  } catch (err) {
    console.error(`Error al borrar empleoye ${id} de ${db}:`, err.message);
    res.status(500).json({ error: `Error al borrar empleoye`, details: err.message });
  }
});

router.put('/:db/empleoyes/:id', async (req, res) => {
  const { db, id } = req.params;
  const { name, idFactory } = req.body;
  if (!db) return res.status(400).json({ error: "No se especificó la base de datos" });
  try {
    const pool = getPool(db);
    const connection = await pool.getConnection();
    try {
      await connection.query('UPDATE empleoyes SET name=?, idFactory=? WHERE id=?', [name, idFactory, id]);
      res.json({ success: true });
    } finally {
      connection.release();
    }
  } catch (err) {
    console.error(`Error al modificar empleados ${id} de ${db}:`, err.message);
    res.status(500).json({ error: `Error al modificar empleados`, details: err.message });
  }
});

// =======================
// LINESENDS
// =======================

router.get(['/:db/lines', '/lines'], async (req, res) => {
  const dbName = req.params.db || req.query.db;
  if (!dbName) return res.status(400).json({ error: "No se especificó la base de datos" });

  try {
    const pool = getPool(dbName);
    const connection = await pool.getConnection();
    try {
      const [rows] = await connection.query("SELECT * FROM linesends");
      res.json(rows);
    } finally {
      connection.release();
    }
  } catch (err) {
    console.error(`Error al obtener lineas de ${dbName}:`, err.message);
    res.status(500).json({ error: `Error al obtener lineas de ${dbName}`, details: err.message });
  }
});

router.delete('/:db/lineSends/:id', async (req, res) => {
  const { db, id } = req.params;
  if (!db) return res.status(400).json({ error: "No se especificó la base de datos" });
  try {
    const pool = getPool(db);
    const connection = await pool.getConnection();
    try {
      await connection.query('DELETE FROM lineSends WHERE id=?', [id]);
      res.json({ success: true });
    } finally {
      connection.release();
    }
  } catch (err) {
    console.error(`Error al borrar lineSend ${id} de ${db}:`, err.message);
    res.status(500).json({ error: `Error al borrar lineSend`, details: err.message });
  }
});

router.put('/:db/lineSends/:id', async (req, res) => {
  const { db, id } = req.params;
  const { date, factory, observations, state } = req.body;
  if (!db) return res.status(400).json({ error: "No se especificó la base de datos" });
  try {
    const pool = getPool(db);
    const connection = await pool.getConnection();
    try {
      await connection.query(
        'UPDATE lineSends SET date=?, factory=?, observations=?, state=? WHERE id=?',
        [date, factory, observations, state, id]
      );
      res.json({ success: true });
    } finally {
      connection.release();
    }
  } catch (err) {
    console.error(`Error al modificar lineSend ${id} de ${db}:`, err.message);
    res.status(500).json({ error: `Error al modificar lineSend`, details: err.message });
  }
});

// =======================
// MAILS
// =======================

router.get(['/:db/mails', '/mails'], async (req, res) => {
  const dbName = req.params.db || req.query.db;
  if (!dbName) return res.status(400).json({ error: "No se especificó la base de datos" });

  try {
    const pool = getPool(dbName);
    const connection = await pool.getConnection();
    try {
      const [rows] = await connection.query("SELECT * FROM mails");
      res.json(rows);
    } finally {
      connection.release();
    }
  } catch (err) {
    console.error(`Error al obtener mails de ${dbName}:`, err.message);
    res.status(500).json({ error: `Error al obtener mmails de ${dbName}`, details: err.message });
  }
});
router.delete('/:db/mails/:id', async (req, res) => {
  const { db, id } = req.params;
  if (!db) return res.status(400).json({ error: "No se especificó la base de datos" });
  try {
    const pool = getPool(db);
    const connection = await pool.getConnection();
    try {
      await connection.query('DELETE FROM mails WHERE id=?', [id]);
      res.json({ success: true });
    } finally {
      connection.release();
    }
  } catch (err) {
    console.error(`Error al borrar mail ${id} de ${db}:`, err.message);
    res.status(500).json({ error: `Error al borrar mail`, details: err.message });
  }
});

router.put('/:db/mails/:id', async (req, res) => {
  const { db, id } = req.params;
  const { address, company, password } = req.body;
  if (!db) return res.status(400).json({ error: "No se especificó la base de datos" });
  try {
    const pool = getPool(db);
    const connection = await pool.getConnection();
    try {
      await connection.query(
        'UPDATE mails SET address=?, company=?, password=? WHERE id=?',
        [address, company, password, id]
      );
      res.json({ success: true });
    } finally {
      connection.release();
    }
  } catch (err) {
    console.error(`Error al modificar mail ${id} de ${db}:`, err.message);
    res.status(500).json({ error: `Error al modificar mail`, details: err.message });
  }
});

export default router;
