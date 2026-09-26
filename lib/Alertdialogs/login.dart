
import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Backend/Providers/App_provaider.dart' show AppProvider;
import 'package:crud_factories/Backend/Providers/SessionProvaider.dart';
import 'package:crud_factories/Widgets/ForgotPasswordButton.dart' show ForgotPasswordButton;
import 'package:crud_factories/Widgets/genericCheckbox.dart' show genericCheckbox;
import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:crud_factories/Widgets/materialButton.dart' show materialButton;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' hide showDialog;
import 'package:provider/provider.dart';

import '../Backend/Providers/UserProvider.dart';
import '../Widgets/textFieldPassword.dart';
import '../Widgets/textfield.dart';
import '../generated/l10n.dart';
import 'forgotPasswordDialog.dart';

Future<void> LoginPage (BuildContext context) async {

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool showPassword = false;


  await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
            builder: (context,setState) {
                return Dialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                    child: SingleChildScrollView(
                      child: ConstrainedBox(
                            constraints: const BoxConstraints(
                            maxWidth: 400,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            headDialog(title: S.of(context).user_access),

                            defaultTextfield(
                                nameCamp: S.of(context).user,
                                controllerCamp: usernameController,
                                context: context
                            ),

                            textfieldPassword(
                                nameCamp: S.of(context).password,
                                controllerCamp: passwordController,
                                obscureText: !showPassword
                            ),

                            genericCheckbox(
                                text: S.of(context).show_password,
                                value: showPassword,
                                onChanged: (bool? value) {
                                  setState(() {
                                    showPassword = value ?? false;
                                  });
                                }

                            ),
                            ForgotPasswordButton(
                              onPressed: () => forgot_password(context,  usernameController),
                              action: S.of(context).forgot_password,
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 35.0, top: 15.0,right: 40.0, bottom: 20.0),
                              child:  materialButton(
                                nameAction: S.of(context).login,
                                function: () => login_in(
                                    context,
                                    usernameController,
                                    passwordController
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    )
                );
            },

      );

    },
  );
  usernameController.dispose();
  passwordController.dispose();
}

Future<void> login_in(BuildContext context, TextEditingController usernameController, TextEditingController passwordController) async {

  final sessionProvider = context.read<SessionProvider>();
    final appProvider = context.read<AppProvider>();

    final result = await sessionProvider.login(
      usernameController.text.trim(),
      passwordController.text,
    );

    switch (result) {
      case SessionStatus.authenticated:
        final messageWelcome =
            "${S.of(context).welcome}, ${usernameController.text.trim()}";

        await confirm(context, messageWelcome);

        final user = sessionProvider.user;

        if (user != null) {
          await appProvider.loadUserData(
            context,
            user,
          );
        }

        if (context.mounted) {
          Navigator.of(context).pop(false);
        }
        break;

      case SessionStatus.loading:
        throw UnimplementedError();

      case SessionStatus.unauthenticated:
        await error(
        context,
        S.of(context).the_user_or_password_are_incorrect,
        );
        break;
    }

  }


Future<void> forgot_password(BuildContext context, TextEditingController usernameController) async {

  final username = usernameController.text.trim();

  final userProvider = context.read<UserProvider>();

  final user = userProvider.findByUsernameAndMail(username);

  if (user == null) {
    await error(
      context,
      S.of(context).user_not_found,
    );
    return;
  }

  Navigator.of(context).pop();

  await forgotPassword(
    context,
    username,
  );
  }

