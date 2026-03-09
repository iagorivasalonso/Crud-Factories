import express from "express";
import cors from "cors";
import dbRoutes from "./routers/db.js";
import mailRoutes from "./routers/mail.js";
import dotenv from 'dotenv';

dotenv.config();

const app = express();
const PORT = 3000;

app.use(cors());
app.use(express.json());

app.use("/db", dbRoutes);
app.use('/mail', mailRoutes);



app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});