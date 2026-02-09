import dbRepo from '../repositories/database.repository.js';

class DatabaseService {
  async handleAction(action, config) {
  console.log(config)
  console.log(action)
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
  }
}

const databaseService = new DatabaseService();
export default databaseService;


