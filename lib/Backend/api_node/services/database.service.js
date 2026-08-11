import { getPool } from '../repositories/database.pool.js';
import dbRepo from '../repositories/database.repository.js';

class DatabaseService {

  disconnecting = false;

  async handleAction(action, config) {
  console.log("eee");
console.log(
  action === 'create',
  action === 'test-connection',
  action === 'connect',
  action === 'disconnect',
  action === 'update',
  action === 'delete'
);
    try {
      switch (action) {
        case 'create':
          return await dbRepo.createDatabase(config);
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


           await poolToClose.end();


           return { ok: true, message: 'Desconectado correctamente' };

         } catch (error) {

           return { ok: false, error };
         } finally {
           this.disconnecting = false;
         }

       case 'update':
         console.log('ENTRA UPDATE');
         console.log('CONFIG UPDATE:', config);
         console.log('DB REPO:', dbRepo);
         console.log('RENAME:', typeof dbRepo.renameDatabase);

         console.log('ANTES LLAMADA');

         try {
           console.log('LLAMANDO...');
           const result = await dbRepo.renameDatabase(config);
           console.log('LLAMADA TERMINADA');
           console.log('RESULT:', result);
           return result;
         } catch (e) {
           console.error('ERROR AL LLAMAR RENAME:', e);
           console.error('ERROR MESSAGE:', e?.message);
           console.error('ERROR STACK:', e?.stack);

           throw e;
         }
        case 'delete':
          return await dbRepo.deleteDatabase(config);
        default:
          throw new Error('Acción no soportada');
      }
    } catch (err) {

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
