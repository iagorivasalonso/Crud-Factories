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

router.get(["/:db/empleoyes", "/empleoyes"], (req, res) =>
  handleDynamicQuery(req, res, "SELECT * FROM empleoyes")
);

// DELETE dinámico
router.delete("/:db/:table/:id", async (req, res) => {
  const { db, table, id } = req.params;
  await handleDynamicQuery(req, res, `DELETE FROM ${table} WHERE id=?`, [id]);
});

// UPDATE dinámico
router.put("/:db/:table/:id", async (req, res) => {
  const { db, table, id } = req.params;
  const fields = Object.values(req.body);
  const columns = Object.keys(req.body).map(c => `${c}=?`).join(",");
  await handleDynamicQuery(req, res, `UPDATE ${table} SET ${columns} WHERE id=?`, [...fields, id]);
});

export default router;
