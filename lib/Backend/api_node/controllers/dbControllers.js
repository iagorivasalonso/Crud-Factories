import databaseService from '../services/database.service.js';

export async function handleDbAction(req, res) {
  const { action, host, port, user, password, database,newDatabase} = req.body;

  if (!action || !database) {
    return res.status(400).json({ error: "Datos incompletos" });
  }

  try {
    await databaseService.handleAction(action, {
            host, port, user, password,
            database,
            databaseNew: newDatabase
     });
    res.status(200).json({ message: `Acción '${action}' ejecutada correctamente` });
  } catch (err) {
    console.error("Error en handleDbAction:", err);
    res.status(500).json({ error: err.message });
  }
}
