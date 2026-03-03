import { sendMailUser } from '../services/mail.service.js';

export const sendMail = async (req, res) => {

    const {host, port, secure, username, password ,mail, subject, message} = req.body

    try{
           await sendMailUser({host, port, secure,username, password ,mail, subject, message})
           res.status(200).json({connectEmail:true});

    }catch(err) {
         res.status(500).json({ connectEmail: false, error: err.message });
    }
};
