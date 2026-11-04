
import 'package:crud_factories/Backend/Providers/MailProvider.dart' show MailProvider;
import 'package:crud_factories/Backend/Providers/UserProvider.dart' show UserProvider;
import 'package:crud_factories/Objects/Mail.dart';
import 'package:crud_factories/Objects/MailMessage.dart';
import 'package:crud_factories/Objects/User.dart' show User;
import 'package:crud_factories/generated/l10n.dart' show S;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';



class NotificationProvider extends ChangeNotifier {

   final MailProvider mailProvider;
   final UserProvider userProvider;

   NotificationProvider({
        required this.mailProvider,
        required this.userProvider
   });


   Future<MailResult> requestAdminAccess({
     required BuildContext context,
     required String username,
     required String mail,
   }) async {
     final recipients = await userProvider.loadAdminUsers();

     if (recipients.isEmpty) {
       return MailResult(
         success: false,
         sent: [],
         failed: [
           MailFailure(
             mail: '',
             error: S.of(context).no_admin_with_mail,
           ),
         ],
       );
     }

     if (mailProvider.mails.isEmpty) {
       return MailResult(
         success: false,
         sent: [],
         failed: [
           MailFailure(
             mail: '',
             error: S.of(context).no_mail_account_selected,
           ),
         ],
       );
     }

     final mailMessage = MailMessage(
       recipients: recipients,
       subject: S.of(context).admin_request_subject,
       message: S.of(context).admin_request_message(
         username,
         mail,
       ),
       attachments: [],
     );

      mailProvider.select(mailProvider.mails.first);

     return await mailProvider.send(
       mailMessage,
       noAccountMessage: S.of(context).no_mail_account_selected,
     );
   }

   Future<MailResult> requestPasswordReset({
     required BuildContext context,
     required User user,
   }) async {

     final recipients =  await userProvider.loadAdminUsers();


     if (recipients.isEmpty) {
       print('ERROR: no hay admins con mail');

       return MailResult(
         success: false,
         sent: [],
         failed: [
           MailFailure(
             mail: '',
             error: S.of(context).no_admin_with_mail,
           ),
         ],
       );
     }

     final systemMails = await mailProvider.loadSystemMails();

     if (systemMails.isEmpty) {
       print('ERROR: no hay cuentas de correo configuradas');

       return MailResult(
         success: false,
         sent: [],
         failed: [
           MailFailure(
             mail: '',
             error: S.of(context).no_mail_account_selected,
           ),
         ],
       );
     }

     final mailMessage = MailMessage(
       recipients: recipients,
       subject: S.of(context).password_recovery_request_subject,
       message: S.of(context).password_recovery_request_message(
         user.username,
         user.mail ?? '',
       ),
       attachments: [],
     );

     mailProvider.select(systemMails.first);

     final result = await mailProvider.send(
       mailMessage,
       account: systemMails.first,
       noAccountMessage: S.of(context).no_mail_account_selected,
     );

     return result;
   }

  Future<MailResult> notifyAdminPromotion( {
    required BuildContext context,
    required String? mailAdmin,
    required String? mailUser}) async {


    print("MAIL ADMIN: [$mailAdmin]");
    print("MAIL USUARIO: [$mailUser]");
    if (mailUser == null ||
        mailUser.trim().isEmpty ||
        mailAdmin == null ||
        mailAdmin.trim().isEmpty) {
      return MailResult(
        success: false,
        sent: [],
        failed: [
          MailFailure(
            mail: '',
            error: S
                .of(context)
                .no_mail_account_selected,
          ),
        ],
      );
    }

     final mailMessage = MailMessage(
         recipients: [mailUser!],
         subject: "respuesta a solicitud admin",
         message: "le ham aprovado la solicitud de admin"
     );

    final mailProvider = context.read<MailProvider>();

        final adminAcount = mailProvider.mails.where(
            (mail) => mail.mail == mailAdmin
        );
    print("CUENTAS EN MAIL PROVIDER: ${mailProvider.mails.length}");
    print("CUENTA ADMIN ENCONTRADA: ${adminAcount.length}");
    print("MAIL ADMIN SESIÓN: $mailAdmin");

    for (final mail in mailProvider.mails) {
      print("CUENTA CONFIGURADA: ${mail.mail}");
    }

    mailProvider.selected = adminAcount.first;

    return await mailProvider.send(
      mailMessage,
      noAccountMessage: S.of(context).no_mail_account_selected,
    );
  }

}