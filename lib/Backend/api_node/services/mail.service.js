import nodemailer from 'nodemailer';

export const sendMailUser = async ({ host, port, secure, username, password, mail, subject, message}) => {

      const domain = username.split("@")[1];
try {
    const transporter = nodemailer.createTransport({
      host,
      port,
      secure,
      auth: { user: username, pass: password },
    });

    await transporter.sendMail({
      from: username,
      to: mail,
      subject,
      text: message,
    });

  } catch (err) {

    // Identificar tipo de error
    if (err.code === 'EAUTH') {
      // Credenciales incorrectas
      throw new Error('Usuario o contraseña del correo incorrectos');
    }

    if (err.code === 'ENOTFOUND' || err.code === 'ECONNECTION') {
      // Problema de host / conexión
      throw new Error('No se pudo conectar con el servidor de correo');
    }

    if (err.responseCode === 550) {
      // Correo destinatario inválido
      throw new Error('Correo destinatario inválido');
    }

    // Otros errores → propagar genérico
    throw err;
  }
};
