import 'package:crud_factories/Backend/Global/controllers/User.dart';
import 'package:crud_factories/Functions/validatorCamps.dart';
import 'package:crud_factories/Objects/User.dart' show User;
import 'package:crud_factories/generated/l10n.dart' show S;
import 'package:fluent_ui/fluent_ui.dart';

class UserValidator {

  static String? validate(
         BuildContext context,
         UserController controllers,
         User? userSelected,
         List<User> users,
         bool changePassword,
      ) {

      final username = controllers.username.text;
      final pass = controllers.password.text;
      final pass2 = controllers.passwordVerify!.text;
      final mail = controllers.mail!.text.trim();

      // 🔴 REQUIRED
      if (username.isEmpty) return S.of(context).usename_required;
      if (pass.isEmpty) return S.of(context).password_required;
      if (pass2.isEmpty) return S.of(context).password_required;

      // MAIL
      if (controllers.role.text == "admin" && mail.isEmpty) {
        return S.of(context).mail_required;
      }

      if (mail.isNotEmpty) {
        final err = ValidatorCamps.mailValidate(mail, context);
        if (err != null) return err;
      }

      // 🔴 UNIQUE
      final allUsers = users.map((e) => e.username).toList();
      final old = userSelected?.username ?? '';

      final userErrors = ValidatorCamps.primaryKeyValidate(
          username,
          allUsers,
          old,
          context
      );

      if (userErrors != null) return userErrors;

      // 🔴 PASSWORD MATCH
      if (userSelected == null || changePassword) {
        if (pass.isEmpty) {
          return S.of(context).password_required;
        }

        if (pass2.isEmpty) {
          return S.of(context).password_required;
        }

        if (pass != pass2) {
          return S.of(context).passwords_do_not_match;
        }
      }
      return null;

    }

}