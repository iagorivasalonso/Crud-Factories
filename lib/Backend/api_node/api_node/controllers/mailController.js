import { sendMailUser } from '../services/mail.service.js';

export const sendMail = async (req, res) => {

  const { host, port, secure, username, password, mail, subject, message, attachments} = req.body;

  if (!host || !port) {
    return res.status(400).json({
      success: false,
      message: 'Configuración SMTP incompleta (host/port)'
    });
  }

  if (!username || !password) {
    return res.status(400).json({
    success: false,
    message: 'Faltan credenciales de correo' });
  }

  if (!mail || (Array.isArray(mail) && mail.length === 0)) {
    return res.status(400).json({
    success: false,
    message: 'No se definieron destinatarios' });
  }

  try {
   const results = await sendMailUser({ host, port, secure, username, password, mail, subject, message, attachments});


          const mailResults = results.map((r, index) => ({
            mail: Array.isArray(mail) ? mail[index] : mail,
            status: r.status,
            info: r.info || null, // opcional, si quieres detalles
          }));


          res.status(200).json({
            success: true,
            results: mailResults
          });


  } catch (err) {


    switch (err.code) {

          case 'EAUTH':
            return res.status(401).json({
              success: false,
              message: 'Credenciales incorrectas'
            });

          case 'ECONNECTION':
          case 'ENOTFOUND':
            return res.status(503).json({
              success: false,
              message: 'No se pudo conectar con el servidor SMTP'
            });

          case 'EENVELOPE':
            return res.status(400).json({
              success: false,
              message: 'Destinatario inválido'
            });

          case 'ETIMEDOUT':
            return res.status(504).json({
              success: false,
              message: 'Tiempo de espera agotado'
            });

          default:
            return res.status(500).json({
              success: false,
              message: 'Error interno del servidor'
            });
        }

  }
};