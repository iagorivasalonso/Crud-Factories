
import 'package:crud_factories/Functions/validatorCamps.dart' show ValidatorCamps;
import 'package:crud_factories/generated/l10n.dart' show S;
import 'package:crud_factories/helpers/localization_helper.dart' show LocalizationHelper;
import 'package:fluent_ui/fluent_ui.dart';

class SendMailValidator {

  static SendMailResult validateAll({
    required BuildContext context,
    required String mail,
    required String password,
    required String mailTo,
    required String subject,
    required String message,
    required bool otherMail,
    required bool isRecipient,
  }) {

    // 🔴 REMITENTE
    if (otherMail) {
      final error = ValidatorCamps.mailValidate(mail, context);
      if (error != null) {
        return SendMailResult.error(
          S.of(context).your_mail_is_invalid,
        );
      }

      if (password.trim().isEmpty) {
        return SendMailResult.error(
          S.of(context).password_required,
        );
      }
    }

// 🔴 DESTINATARIO (ESTE ES EL IMPORTANTE)
    if (mailTo.trim().isNotEmpty) {
      final error = ValidatorCamps.mailValidate(mailTo, context);
      if (error != null) {
        return SendMailResult.error(
          S.of(context).The_recipient_is_not_a_valid_mail,
        );
      }
    }

    List<String> warnings = [];

    if (subject.isEmpty) {
      warnings.add(
        LocalizationHelper.camp_empty_continue(
          context,
          S.of(context).affair,
        ),
      );
    }

    if (message.isEmpty) {
      warnings.add(
        LocalizationHelper.camp_empty_continue(
          context,
          S.of(context).message,
        ),
      );
    }

    if (warnings.isNotEmpty) {
      return SendMailResult.warnings(warnings);
    }

    return const SendMailResult.ok();
  }
}

class SendMailResult {

  final String? error;
  final List<String> warnings;

  const SendMailResult._({
    this.error,
    this.warnings = const [],
  });



  const SendMailResult.ok() : this._();

  const SendMailResult.error(String msg)
      : this._(error: msg);



  const SendMailResult.warnings(List<String> msgs)
      : this._(warnings: msgs);
}




