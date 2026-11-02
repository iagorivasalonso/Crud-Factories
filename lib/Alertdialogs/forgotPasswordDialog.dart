
import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Backend/Providers/App_provaider.dart' show AppProvider;
import 'package:crud_factories/Backend/Providers/SessionProvider.dart';
import 'package:crud_factories/Backend/Providers/UserProvider.dart';
import 'package:crud_factories/Backend/Providers/notificacionProvider.dart' show NotificationProvider;
import 'package:crud_factories/Widgets/ForgotPasswordButton.dart' show ForgotPasswordButton;
import 'package:crud_factories/Widgets/genericCheckbox.dart' show genericCheckbox;
import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:crud_factories/Widgets/loadingOverlay.dart' show LoadingOverlay;
import 'package:crud_factories/Widgets/materialButton.dart' show materialButton;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' hide showDialog;
import 'package:provider/provider.dart';

import '../Widgets/dropDownButton.dart' show LoadingOverlay;
import '../Widgets/textFieldPassword.dart';
import '../Widgets/textfield.dart';
import '../generated/l10n.dart';
import 'login.dart';

Future<void> forgotPassword (BuildContext context, String username) async {

  final usernameController = TextEditingController();
  final mailController = TextEditingController();

  usernameController.text = username;

  bool isLoading = false;

  await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
            builder: (context,setState) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Stack(
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 400,
                          maxHeight: 900,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            headDialog(title: S.of(context).user_access),

                            Flexible(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    defaultTextfield(
                                      nameCamp: S.of(context).user,
                                      controllerCamp: usernameController,
                                      context: context,
                                    ),

                                    defaultTextfield(
                                      nameCamp: S.of(context).mail,
                                      controllerCamp: mailController,
                                      context: context,
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 20,
                                        bottom: 15,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          materialButton(
                                            nameAction: S.of(context).request,
                                            function: () async {
                                              if (isLoading) return;

                                              setState(() => isLoading = true);

                                              await Future.delayed(const Duration(milliseconds: 100));

                                              try {
                                                await requestPassword(
                                                  context,
                                                  usernameController,
                                                  mailController,
                                                );
                                              } finally {
                                                if (context.mounted) {
                                                  setState(() => isLoading = false);
                                                }
                                              }
                                            },
                                          ),
                                          const SizedBox(width: 20),
                                          materialButton(
                                            nameAction: S.of(context).back_to_login,
                                            function: () {
                                              Navigator.of(context).pop();
                                              LoginPage(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      if (isLoading)
                        LoadingOverlay(),
                    ],
                  ),
                );
            },

      );
    },
  );
  usernameController.dispose();
  mailController.dispose();
}

Future<void> requestPassword(
    BuildContext context,
    TextEditingController usernameController,
    TextEditingController mailController,
    ) async {
  final userProvider = context.read<UserProvider>();
  final notificationProvider = context.read<NotificationProvider>();

  final user = await userProvider.repository!.findByUsernameAndMail(
    usernameController.text.trim(),
    mailController.text.trim(),
  );

  if (user == null) {
    await error(context, S.of(context).user_or_mail_invalid);
    return;
  }

  if (user.mail == null || user.mail!.trim().isEmpty) {
    await error(
      context,
      S.of(context).account_not_configured_on_the_server,
    );
    return;
  }

  final result = await notificationProvider.requestPasswordReset(
    context: context,
    user: user,
  );

  if (result.success) {
    await confirm(
      context,
      S.of(context).password_recovery_request_sent,
    );
  }
}