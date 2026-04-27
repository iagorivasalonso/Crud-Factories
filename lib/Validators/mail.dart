
import 'package:crud_factories/Backend/Global/controllers/Mail.dart' show MailController;
import 'package:crud_factories/Functions/validatorCamps.dart' show ValidatorCamps;
import 'package:crud_factories/Objects/Mail.dart';
import 'package:crud_factories/generated/l10n.dart' show S;
import 'package:fluent_ui/fluent_ui.dart';

class MailValidator {

  static String? validate({
    required BuildContext context,
    required MailController controllers,
    required List<Mail> mails,
    required int select,
  }) {

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
    final allKeys = mails.map((e) => e.address).toList();
    final old = select != -1 ? mails[select].address : "";

    final keyError = ValidatorCamps.primaryKeyValidate(
      mail,
      allKeys,
      old,
      context,
    );

    if (keyError != null) return keyError;

    // 🔴 PASSWORD MATCH
    if (pass != pass2) {
      return S.of(context).passwords_do_not_match;
    }

    return null;
  }
}