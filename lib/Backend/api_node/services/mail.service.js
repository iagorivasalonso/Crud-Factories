import nodemailer from "nodemailer";

export const sendMailUser = async ({
  host, port, secure, username, password, mail, subject, message, attachments
}) => {

  if (!host || !port || !username || !password || !mail) {
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

  for (const address of mails) {
    // Validación mínima de formato
    if (!address || !/^[\w.-]+@[\w.-]+\.\w+$/.test(address)) {

      results.push({ address, status: 'failed', error: 'Formato inválido' });
      continue;
    }

    try {
      await transporter.sendMail({
        from: username,
        to: address,
        subject: subject || "",
        text: message || "",
        attachments: formattedAttachments ?? [],
      });

      results.push({ address, status: 'sent'});
    } catch (err) {
      results.push({ address, status: 'failed', error: err.message });
    }
  }

  return results;
};