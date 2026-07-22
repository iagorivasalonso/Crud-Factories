
import 'package:crud_factories/Backend/Feature/Mail/IMailDataSource.dart';
import 'package:crud_factories/Backend/core/service/Cryptoservice.dart' show CryptoService;
import 'package:crud_factories/Objects/Mail.dart';

class MailRepository {

   final IMailDataSource dataSource;

    MailRepository(this.dataSource);

    Future<void> insert(Mail mail) {

      final encryptedMail = Mail(
        id: mail.id,
        mail: mail.mail,
        host: mail.host,
        port: mail.port,
        secure: mail.secure,
        password: CryptoService.encrypt(mail.password),
      );

      return dataSource.insert(encryptedMail);
    }

    Future<void> delete(String id) async {

       return dataSource.delete(id);
    }

    Future<List<Mail>> load() async {

      final mails = await dataSource.load();

      return mails.map((mail) {
        return Mail(
          id: mail.id,
          mail: mail.mail,
          host: mail.host,
          port: mail.port,
          secure: mail.secure,
          password: CryptoService.decrypt(mail.password),
        );
      }).toList();
    }

   Future<void> upload(Mail mail) {

     final encryptedMail = Mail(
       id: mail.id,
       mail: mail.mail,
       host: mail.host,
       port: mail.port,
       secure: mail.secure,
       password: CryptoService.encrypt(mail.password),
     );


     return dataSource.upload(encryptedMail);
   }
}