const {sendEmailUser} = require('../services/email/service');

const sendMail = async (req, res) => {

    const {username, password ,to, subject, message} = req.body

    try{
           await SendEmailUser({username, password ,to, subject, message}})
           res.status(200).json({connectEmail:true});

    }catch(err) {
         res.status(500).json({ connectEmail: false, error: err.message });
    }
};

module.exports = { sendEmail}