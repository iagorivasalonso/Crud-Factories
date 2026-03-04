import { sendMailUser } from '../services/mail.service.js';

export const sendMail = async (req, res) => {

  const { host, port, secure, username, password, mail, subject, message } = req.body;

  if (!username || !password) {
    return res.status(400).json({ connectEmail: false, message: 'Faltan credenciales de correo' });
  }

  if (!mail || (Array.isArray(mail) && mail.length === 0)) {
    return res.status(400).json({ connectEmail: false, message: 'No se definieron destinatarios' });
  }

  try {
    await sendMailUser({ host, port, secure, username, password, mail, subject, message });

    return res.status(200).json({ connectEmail: true, message: 'Correo enviado correctamente' });
  } catch (err) {
    console.error('Error enviando correo:', err.message);

    if (err.message.includes('Usuario o contraseña')) {
      return res.status(401).json({ connectEmail: false, message: err.message });
    }

    if (err.message.includes('destinatario')) {
      return res.status(400).json({ connectEmail: false, message: err.message });
    }

    return res.status(500).json({ connectEmail: false, message: 'Error interno del servidor' });
  }
};