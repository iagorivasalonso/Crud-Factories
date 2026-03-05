import nodemailer from 'nodemailer';

export const sendMailUser = async ({
  host, port, secure, username, password, mail, subject, message
}) => {

  if (!host || !port || !username || !password || !mail || !subject || !message) {
    const error = new Error('Todos los parámetros son obligatorios');
    error.code = 'INVALID_PARAMS';
    throw error;
  }

  const transporter = nodemailer.createTransport({
    host,
    port,
    secure,
    auth: { user: username, pass: password },
  });

  // Asegurarse que sea array
  const mails = Array.isArray(mail) ? mail : [mail];
  const results = [];

  for (const email of mails) {
    // Validación mínima de formato
    if (!email || !/^[\w.-]+@[\w.-]+\.\w+$/.test(email)) {

      results.push({ email, status: 'failed', error: 'Formato inválido' });
      continue;
    }

    try {
      await transporter.sendMail({
        from: username,
        to: email,
        subject,
        text: message,
      });

      results.push({ email, status: `✅ Correo enviado a ${email}`});
    } catch (err) {
      results.push({ email, status: 'failed', error: err.message });
    }
  }

  return results;
};