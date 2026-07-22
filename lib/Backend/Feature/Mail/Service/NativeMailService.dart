import 'dart:io';
import 'package:crud_factories/Backend/Feature/Mail/Service/ImailService.dart';
import 'package:crud_factories/Objects/Mail.dart';
import 'package:crud_factories/Objects/MailMessage.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/mailer.dart' as mailer;

class NativeMailService  implements IMailService{

  @override
  Future<MailResult> send(Mail mail, MailMessage message) async{

    try{

      final smtpServer = SmtpServer(
        mail.host,
        port: int.parse(mail.port),
        username: mail.mail,
        password: mail.password,
        ssl: mail.secure,

      );

      final smtpMessage = mailer.Message()
        ..from = mailer.Address(mail.mail)
        ..recipients.addAll(message.recipients)
        ..subject = message.subject
        ..text = message.message
        ..attachments = message.attachments
            .where((attachment) => attachment.path != null)
            .map(
              (attachment) => mailer.FileAttachment(
            File(attachment.path!),
          ),
        )
            .toList();


        await mailer.send(smtpMessage, smtpServer);

        return MailResult(
          success: true,
          sent: message.recipients,
          failed: const [],
        );
      } on  mailer.MailerException catch (e) {
        return MailResult(
          success: false,
          sent: const [],
          failed: e.problems
              .map(
                (p) => MailFailure(
              mail: p.code, // luego vemos si merece la pena usarlo
              error: p.msg,
            ),
          )
              .toList(),
        );
      } catch (e) {
      return MailResult(
        success: false,
        sent: const [],
        failed: [
          MailFailure(
            error: e.toString(),
          ),
        ],
      );
    }

  }


}