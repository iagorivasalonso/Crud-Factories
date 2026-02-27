import nodemailer from 'nodemailer';

export const sendMailUser = async ({ username, password, to, subject, message}) => {

      const domain = username.split("@")[1];
      let host, port, secure

      host = "smtp.gmail.com"
      port = 465
      secure = true;

      const transporter = nodemailer.createTransport({
         host,
         port,
         secure,
         auth: {user: username, pass: password },
      });

      await transporter.sendMail({
         from: username,
         to,
         subject,
         text: message
      });
};
