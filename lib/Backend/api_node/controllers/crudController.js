import { getPool } from '../repositories/database.pool.js';
import DatabaseService from '../services/database.service.js';

export async function getPoolFromReq(req, database, connectionData) {
  const { pool, error } = await getPool({
    ...connectionData,
    database
  });

  if (error) throw new Error(error.message);

  return pool;
}

export default class CrudController {

   constructor(tableName) {
       this.table = tableName

        // Bind para mantener el contexto de "this"
           this.getAll = this.getAll.bind(this);
           this.create = this.create.bind(this);
           this.update = this.update.bind(this);
           this.delete = this.delete.bind(this);
   }

     async getConnection(dbName) {
       const { pool, error } = await getPool({
         host: process.env.DB_HOST,
         port: Number(process.env.DB_PORT),
         user: process.env.DB_USER,
         password: process.env.DB_PASSWORD,
         database: dbName
       });

       if (error) throw error;

       return pool.getConnection();
     }

   async getAll(req,res) {

             try {
                const connection = await this.getConnection();
                const [rows] = await connection.query(`SELECT * FROM ??`, [this.table]);
                connection.release();
                res.json(rows);
              } catch (error) {
                res.status(500).json({ error: error.message });
              }
   }

   async create(req,res) {

         const data = req.body;
             if (!data || Object.keys(data).length === 0)
               return res.status(400).json({ error: 'No hay datos para insertar' });

             try {
               const connection = await this.getConnection();
               const [result] = await connection.query(`INSERT INTO ?? SET ?`, [this.table, data]);
               connection.release();
               res.status(201).json({ message: `${this.table} insertado correctamente`, insertId: result.insertId });
             } catch (error) {
               res.status(500).json({ error: error.message });
             }
   }

   async update(req,res) {
             const data = req.body;
              const { id } = req.params;
              if (!id || !data || Object.keys(data).length === 0)
                return res.status(400).json({ error: 'Faltan parámetros o datos' });

              try {
                const connection = await this.getConnection();
                const [result] = await connection.query(`UPDATE ?? SET ? WHERE id = ?`, [this.table, data, id]);
                connection.release();
                if (result.affectedRows === 0) return res.status(404).json({ error: 'Registro no encontrado' });
                res.json({ message: `${this.table} actualizado correctamente` });
              } catch (error) {
                res.status(500).json({ error: error.message });
              }
      }

      async delete(req,res) {

                     const { id } = req.params;
                       if (!id) return res.status(400).json({ error: 'Falta id' });

                       try {
                         const connection = await this.getConnection();
                         const [result] = await connection.query(`DELETE FROM ?? WHERE id = ?`, [this.table, id]);
                         connection.release();
                         if (result.affectedRows === 0) return res.status(404).json({ error: 'Registro no encontrado' });
                         res.json({ message: `${this.table} eliminado correctamente` });
                       } catch (error) {
                         res.status(500).json({ error: error.message });
                       }
            }
}