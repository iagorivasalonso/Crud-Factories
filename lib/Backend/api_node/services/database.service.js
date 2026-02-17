import { getPool } from '../repositories/database.pool.js';
import dbRepo from '../repositories/database.repository.js';

class DatabaseService {

  async handleAction(action, config) {
  console.log(action);
    try {
      switch (action) {
        case 'createBD':
          return await dbRepo.createDatabase(config);
        case 'createTables':
          return await dbRepo.createTables(config);
       case 'test-connection':
       case 'connect':
         if (!config.database || !config.database.trim()) {
           return {
             ok: false,
             error: {
               type: 'config',
               code: 'INVALID_DATABASE',
               message: 'Database requerida para conectar',
             },
           };
         }

         const { pool, error } = await getPool(config);
         if (error) return { ok: false, error };

         let connection;
         try {
           connection = await pool.getConnection();
           await connection.query(`USE ${config.database}`);
           console.log(`[DatabaseService] Conectado a ${config.database}`);
           return { ok: true, message: 'Conectado correctamente' };
         } finally {
           if (connection) connection.release();
         }

        case 'update':
          return await dbRepo.renameDatabase(config);
        case 'delete':
          return await dbRepo.deleteDatabase(config);
        default:
          throw new Error('Acción no soportada');
      }
    } catch (err) {
      console.error(`[DatabaseService] Acción: ${action}`, err.message);
      return { ok: false, message: err.message };
    }
  }
}

export default new DatabaseService();
