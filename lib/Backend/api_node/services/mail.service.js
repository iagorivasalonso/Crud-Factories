import nodemailer from 'nodemailer';

export const sendMailUser = async ({ host, port, secure, mailTo, password, to, subject, message}) => {

      const domain = mailTo.split("@")[1];

      const transporter = nodemailer.createTransport({
         host,
         port,
         secure,
         auth: {user: mailTo, pass: password },
      });

      await transporter.sendMail({
         from: mailTo,
         to,
         subject,
         text: message
      });
};
