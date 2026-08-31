
import 'package:crud_factories/Backend/Providers/SessionProvaider.dart';
import 'package:crud_factories/Widgets/genericCheckbox.dart' show genericCheckbox;
import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:crud_factories/Widgets/materialButton.dart' show materialButton;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' hide showDialog;
import 'package:provider/provider.dart';

import '../Widgets/textFieldPassword.dart';
import '../Widgets/textfield.dart';
import '../generated/l10n.dart';

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

                            Padding(
                              padding: const EdgeInsets.only(left: 35.0, top: 15.0,right: 40.0, bottom: 20.0),
                              child:  materialButton(
                                nameAction: S.of(context).login,
                                function: () async {
                                  await context.read<SessionProvider>().login(
                                    usernameController.text.trim(),
                                    passwordController.text,
                                  );

                                  final sessionProvider = context.read<SessionProvider>();
                                  print(sessionProvider.status);
                                  if (sessionProvider.isAuthenticated) {
                                    Navigator.pop(context);
                                  }
                                },
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

