import nodemailer from 'nodemailer';

export const sendMailUser = async ({ host, port, secure, username, password, mail, subject, message}) => {

      const domain = username.split("@")[1];

      const transporter = nodemailer.createTransport({
         host,
         port,
         secure,
         auth: {user: username, pass: password },
      });

      await transporter.sendMail({
         from: username,
         to: mail,
         subject,
         text: message
      });
};
