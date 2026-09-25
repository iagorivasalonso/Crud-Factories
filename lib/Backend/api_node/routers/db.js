import express from "express";
import {
  handleDbAction,
  handleDynamicQuery
} from "../controllers/dbControllers.js";

const router = express.Router();

// Administración de bases
router.post("/db", handleDbAction);


// ==================== USERS ====================

router.get("/:db/users", async (req, res) => {
  await handleDynamicQuery(
    req,
    res,
    `SELECT id, username, mail, role, active FROM users`
  );
});

router.post("/:db/users", async (req, res) => {
  const { username, mail, password_hash, role, active } = req.body;

  if (!username || !password_hash) {
    return res.status(400).json({
      error: "Faltan datos obligatorios"
    });
  }

  await handleDynamicQuery(
    req,
    res,
    `INSERT INTO users
     (username, mail, password_hash, role, active)
     VALUES (?, ?, ?, ?, ?)`,
    [username, mail ?? null, password_hash, role, active]
  );
});

router.put("/:db/users/:id", async (req, res) => {
  const { id } = req.params;
  const { username, mail, password_hash, role, active } = req.body;

  if (password_hash) {
    await handleDynamicQuery(
      req,
      res,
      `UPDATE users
       SET username = ?,
           mail = ?,
           password_hash = ?,
           role = ?,
           active = ?
       WHERE id = ?`,
      [
        username,
        mail ?? null,
        password_hash,
        role,
        active,
        id
      ]
    );
  } else {
    await handleDynamicQuery(
      req,
      res,
      `UPDATE users
       SET username = ?,
           mail = ?,
           role = ?,
           active = ?
       WHERE id = ?`,
      [
        username,
        mail ?? null,
        role,
        active,
        id
      ]
    );
  }
});

router.delete("/:db/users/:id", async (req, res) => {
  const { id } = req.params;

  await handleDynamicQuery(
    req,
    res,
    `DELETE FROM users WHERE id = ?`,
    [id]
  );
});

// =========================
// SELECT
// =========================


router.get(["/:db/sectors", "/sectors"], (req, res) =>
  handleDynamicQuery(
    req,
    res,
    "SELECT * FROM sectors WHERE user_id = ?",
    [req.query.user_id]
  )
);

router.get(["/:db/factories", "/factories"], (req, res) =>
  handleDynamicQuery(
    req,
    res,
    "SELECT * FROM factories WHERE user_id = ?",
    [req.query.user_id]
  )
);

router.get(["/:db/lines", "/lines"], (req, res) =>
  handleDynamicQuery(
    req,
    res,
    "SELECT * FROM lineSends WHERE user_id = ?",
    [req.query.user_id]
  )
);

router.get(["/:db/mails", "/mails"], (req, res) =>
  handleDynamicQuery(
    req,
    res,
    "SELECT * FROM mails WHERE user_id = ?",
    [req.query.user_id]
  )
);


router.get(["/:db/mails/system", "/mails/system"], (req, res) =>
  handleDynamicQuery(
    req,
    res,
    "SELECT id, mail, host, port, secure, password FROM mails ORDER BY id"
  )
);

router.get(["/:db/employees", "/employees"], (req, res) =>
  handleDynamicQuery(
    req,
    res,
    "SELECT * FROM employees WHERE user_id = ?",
    [req.query.user_id]
  )
);


// =========================
// INSERT
// =========================

router.post("/:db/:table", async (req, res) => {
  const { table } = req.params;
  const userId = req.query.user_id;

  if (!userId) {
    return res.status(400).json({
      error: "Falta user_id"
    });
  }

  if (!req.body || Object.keys(req.body).length === 0) {
    return res.status(400).json({
      error: "No hay datos para insertar"
    });
  }

  const data = {
    ...req.body,
    user_id: userId,
  };

  const fields = Object.values(data);
  const columns = Object.keys(data).join(",");
  const placeholders = Object.keys(data)
    .map(() => "?")
    .join(",");

  await handleDynamicQuery(
    req,
    res,
    `INSERT INTO ${table} (${columns}) VALUES (${placeholders})`,
    fields
  );
});


// =========================
// DELETE
// =========================

router.delete("/:db/:table/:id", async (req, res) => {
  const { table, id } = req.params;
  const userId = req.query.user_id;

  if (!userId) {
    return res.status(400).json({
      error: "Falta user_id"
    });
  }

  await handleDynamicQuery(
    req,
    res,
    `DELETE FROM ${table}
     WHERE id = ?
     AND user_id = ?`,
    [id, userId]
  );
});


// =========================
// UPDATE
// =========================

router.put("/:db/:table/:id", async (req, res) => {
  const { table, id } = req.params;
  const userId = req.query.user_id;

  if (!userId) {
    return res.status(400).json({
      error: "Falta user_id"
    });
  }

  const fields = Object.values(req.body);

  const columns = Object.keys(req.body)
    .map(c => `${c} = ?`)
    .join(",");

  await handleDynamicQuery(
    req,
    res,
    `UPDATE ${table}
     SET ${columns}
     WHERE id = ?
     AND user_id = ?`,
    [...fields, id, userId]
  );
});


export default router;