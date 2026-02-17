import express from "express";
import cors from "cors";
import dbRoutes from "./routers/db.js";

const app = express();
const PORT = 3000;

app.use(cors());
app.use(express.json());
app.use("/", dbRoutes);

app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});