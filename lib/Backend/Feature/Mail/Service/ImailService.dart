
import 'package:crud_factories/Objects/Mail.dart' show MailResult, Mail;
import 'package:crud_factories/Objects/MailMessage.dart';

abstract class IMailService {

  Future<MailResult> send(
        Mail mail,
        MailMessage message
      );
}