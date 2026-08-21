
import 'package:crud_factories/Backend/Global/controllers/Mail.dart' show MailController;
import 'package:crud_factories/Functions/validatorCamps.dart' show ValidatorCamps;
import 'package:crud_factories/Objects/Mail.dart';
import 'package:crud_factories/generated/l10n.dart' show S;
import 'package:fluent_ui/fluent_ui.dart';

class MailValidator {

  static String? validate(
    BuildContext context,
    MailController controllers,
    Mail? mailSelected,
    List<Mail> mails,
      ) {

    final mail = controllers.mail.text.trim();
    final pass = controllers.password.text;
    final pass2 = controllers.passwordVerify!.text;

    // 🔴 REQUIRED
    if (mail.isEmpty) return S.of(context).mail_required;
    if (pass.isEmpty) return S.of(context).password_required;
    if (pass2.isEmpty) return S.of(context).password_required;

    // 🔴 FORMAT
    final mailError = ValidatorCamps.mailValidate(mail, context);
    if (mailError != null) return mailError;

    // 🔴 UNIQUE
    final allMails = mails.map((e) => e.mail).toList();
    final old = mailSelected?.mail ?? '';

    final mailErrors = ValidatorCamps.primaryKeyValidate(
      mail,
      allMails,
      old,
      context,
    );

    if (mailErrors != null) return mailErrors;

    // 🔴 PASSWORD MATCH
    if (pass != pass2) {
      return S.of(context).passwords_do_not_match;
    }

    return null;
  }
}
