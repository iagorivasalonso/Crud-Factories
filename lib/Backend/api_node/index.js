import express from "express";
import cors from "cors";
import dbRoutes from "./routers/db.js";
import mailRoutes from "./routers/mail.js";
import sessionRoutes from "./routers/session.js";
import dotenv from 'dotenv';

dotenv.config();

const app = express();

app.use(cors());
app.use(express.json());

app.get('/health', (req, res) => {
   res.status(200).json({
         ok: true,
         status:'ready'
   });
});


app.use('/db', dbRoutes);
app.use('/mail', mailRoutes);
app.use('/session', sessionRoutes)

const PORT = process.env.PORT || 3000;

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});
