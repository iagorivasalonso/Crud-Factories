import nodemailer from 'nodemailer';

export const sendMailUser = async ({
  host, port, secure, username, password, mail, subject, message, attachments
}) => {

  if (!host || !port || !username || !password || !mail || !subject || !message) {
    const error = new Error('Todos los parámetros son obligatorios');
    error.code = 'INVALID_PARAMS';
    throw error;
  }

    const formattedAttachments = attachments?.map(att => ({
      filename: att.filename,
      content: Buffer.from(att.content, "base64"),
      contentType: att.contentType,
    }));

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
        attachments: formattedAttachments,
      });

      results.push({ email, status: `✅ Correo enviado a ${email}`});
    } catch (err) {
      results.push({ email, status: 'failed', error: err.message });
    }
  }

  return results;
};