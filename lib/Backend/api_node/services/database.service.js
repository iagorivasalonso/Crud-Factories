import { getPool } from '../repositories/database.pool.js';
import dbRepo from '../repositories/database.repository.js';

class DatabaseService {

  disconnecting = false;

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

                         if (error) {
                           console.log("Error al obtener pool:", error);
                           return {
                             ok: false,
                             error: {
                               type: error.type || 'ConnectionError',
                               code: error.code || 'UNKNOWN',
                               message: `No se pudo conectar a ${config.host}:${config.port}. ${error.message}`,
                             }
                           };
                         }

                         let connection;
                         try {
                           connection = await pool.getConnection();
                           await connection.query(`USE ${config.database}`);
                           this.pool = pool; // Guardar pool en la instancia
                           return { ok: true, message: 'Conectado correctamente' };
                         } catch (err) {
                           return {
                             ok: false,
                             error: {
                               type: err.type || 'ConnectionError',
                               code: err.code || 'UNKNOWN',
                               message: `Error al usar la base de datos: ${err.message}`,
                             }
                           };
                         } finally {
                           if (connection) connection.release();
                         }

       case 'disconnect':
         try {
           if (this.disconnecting) {
             return { ok: true, message: 'Desconexión en progreso' };
           }

           this.disconnecting = true;

           if (!this.pool) {
             return { ok: true, message: 'Ya estaba desconectado' };
           }

           const poolToClose = this.pool;
           this.pool = null;

           console.log('[DatabaseService] Cerrando pool...');
           await poolToClose.end();

           console.log('[DatabaseService] Pool cerrado correctamente');
           return { ok: true, message: 'Desconectado correctamente' };

         } catch (error) {
           console.error('[DatabaseService] Error al desconectar', error);
           return { ok: false, error };
         } finally {
           this.disconnecting = false;
         }

        case 'update':
          return await dbRepo.renameDatabase(config);
        case 'delete':
          return await dbRepo.deleteDatabase(config);
        default:
          throw new Error('Acción no soportada');
      }
    } catch (err) {
      console.error(`[DatabaseService] Acción: ${action}`, err);
       return {
              ok: false,
              error: {
                type: 'UnhandledError',
                message: err.message || 'Error inesperado',
                code: err.code || 'UNKNOWN'
              }
            };
    }
  }
}

export default new DatabaseService();
