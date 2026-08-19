import express from "express";
import { handleDbAction, handleDynamicQuery } from "../controllers/dbControllers.js";

const router = express.Router();

// Administración de bases
router.post("/db", handleDbAction);

// Rutas CRUD dinámicas
router.get(["/:db/sectors", "/sectors"], (req, res) =>
  handleDynamicQuery(req, res, "SELECT * FROM sectors")
);

router.get(["/:db/factories", "/factories"], (req, res) =>
  handleDynamicQuery(req, res, "SELECT * FROM factories")
);

router.get(["/:db/lines", "/lines"], (req, res) =>
  handleDynamicQuery(req, res, "SELECT * FROM linesends")
);

router.get(["/:db/mails", "/mails"], (req, res) =>
  handleDynamicQuery(req, res, "SELECT * FROM mails")
);

router.get(["/:db/employees", "/employees"], (req, res) =>
  handleDynamicQuery(req, res, "SELECT * FROM employees")
);


// INSERT dinámico
router.post("/:db/:table", async (req, res) => {
  const { table } = req.params;

  if (!req.body || Object.keys(req.body).length === 0) {
    return res.status(400).json({
      error: "No hay datos para insertar"
    });
  }

  const fields = Object.values(req.body);

  const columns = Object.keys(req.body)
    .map(c => `\`${c}\``)
    .join(",");

  const placeholders = Object.keys(req.body)
    .map(() => "?")
    .join(",");

  await handleDynamicQuery(
    req,
    res,
    `INSERT INTO \`${table}\` (${columns}) VALUES (${placeholders})`,
    fields
  );
});


// DELETE dinámico
router.delete("/:db/:table/:id", async (req, res) => {
  const { table, id } = req.params;

  const sql = `DELETE FROM \`${table}\` WHERE id=?`;

// UPDATE dinámico
router.put("/:db/:table/:id", async (req, res) => {
  const { table, id } = req.params;

  const fields = Object.values(req.body);

  const columns = Object.keys(req.body)
    .map(c => `\`${c}\`=?`)
    .join(",");

  await handleDynamicQuery(
    req,
    res,
    `UPDATE \`${table}\` SET ${columns} WHERE id=?`,
    [...fields, id]
  );
});


export default router;