import dbRepo from '../repositories/database.repository.js';

class DatabaseService {
  async handleAction(action, config) {
    switch (action) {
      case 'create':
         throw new Error('crear base de datos aún no implementado');

      case 'update':
        throw new Error('Renombrar base de datos aún no implementado');

      case 'delete':
        throw new Error('Eliminar base de datos aún no implementado');

      default:
        throw new Error('Acción no soportada');
    }
  }
}

const databaseService = new DatabaseService();
export default databaseService;


