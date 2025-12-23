// dbControllers.js
export const handleDbAction = async (req, res) => {
  try {
    // Aquí va la lógica de tu POST
    res.json({ message: "Acción de DB ejecutada correctamente" });
  } catch (err) {
    console.error("Error en handleDbAction:", err.message);
    res.status(500).json({ error: "Error en handleDbAction" });
  }
};
