import dbRepo from '../repositories/database.repository.js';

class DatabaseService {
  async handleAction(action, config) {

     try{
      switch (action) {
           case 'createBD':
             return await dbRepo.createDatabase(config);
            case 'createTables':
              return await dbRepo.createTables(config);
           case 'connect':
             return console.log(config)
           case 'update':
               return await dbRepo.renameDatabase(config);
           case 'delete':
              return await dbRepo.deleteDatabase(config);

           default:
             throw new Error('Acción no soportada');
         }

     }catch(error){
       console.error(`[DatabaseService] Acción: ${action} - Error:`, {
         message: error.message,
         code: error.code,
         stack: error.stack
       });

       return { ok: false, message: 'Error interno en la base de datos' };
     }

  }
}

const databaseService = new DatabaseService();
export default databaseService;


