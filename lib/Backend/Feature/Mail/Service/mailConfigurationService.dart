import 'package:crud_factories/Backend/Feature/Mail/Service/mailConfiguration.dart';
import 'package:crud_factories/Backend/Global/controllers/Mail.dart';
import 'package:crud_factories/Objects/Mail.dart' show Mail;

class MailConfigurationService {

   static Mail? buildMail ({
       required MailController controllers,
       required String mailId,
       Mail? mailSelected
     }) {

     final configuration = fromMail(controllers.mail.text);

     if(configuration == null) return null;

     return createMail(
       id: mailId,
       controllers: controllers,
       configuration: configuration,
     );
   }

   static Mail createMail({
     required String id,
     required MailController controllers,
     required MailConfiguration configuration,
   }) {
     return Mail(
       id: id,
       mail: controllers.mail.text,
       host: configuration.host,
       port: configuration.port,
       secure: configuration.secure,
       password: controllers.password.text,
     );
   }

    static MailConfiguration? fromMail(String mail) {

        final domain = mail.split('@').last.toLowerCase();

        switch(domain) {
            case 'gmail.com':
                 return const MailConfiguration(
                     company: 'gmail',
                     host: 'smtp.gmail.com',
                     port: '465',
                     secure: true
                 );

            case 'hotmail.com':
            case 'outlook.com':
            case 'live.com':
                  return const MailConfiguration(
                      company: 'office365',
                      host: 'smtp.office365.com',
                      port: '587',
                      secure: false
                  );

            case 'yahoo.com':
            case 'yahoo.es':
                  return const MailConfiguration(
                      company: 'mail.yahoo',
                      host: 'smtp.mail.yahoo.com',
                      port: '465',
                      secure: true
                  );

        }
        return null;
    }


}