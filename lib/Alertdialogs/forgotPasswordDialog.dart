
import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Backend/Providers/App_provaider.dart' show AppProvider;
import 'package:crud_factories/Backend/Providers/SessionProvaider.dart';
import 'package:crud_factories/Backend/Providers/UserProvider.dart';
import 'package:crud_factories/Backend/Providers/notificacionProvider.dart' show NotificationProvider;
import 'package:crud_factories/Widgets/ForgotPasswordButton.dart' show ForgotPasswordButton;
import 'package:crud_factories/Widgets/genericCheckbox.dart' show genericCheckbox;
import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:crud_factories/Widgets/materialButton.dart' show materialButton;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' hide showDialog;
import 'package:provider/provider.dart';

import '../Widgets/textFieldPassword.dart';
import '../Widgets/textfield.dart';
import '../generated/l10n.dart';
import 'login.dart';

Future<void> forgotPassword (BuildContext context) async {

  final usernameController = TextEditingController();
  final mailController = TextEditingController();

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

                            defaultTextfield(
                                nameCamp: S.of(context).mail,
                                controllerCamp: mailController,
                                context: context
                            ),


                            Padding(
                              padding: const EdgeInsets.only(top:20,bottom: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  materialButton(
                                    nameAction: "solicitar",
                                    function: () => requestPassword(
                                        context,
                                        usernameController,
                                        mailController
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  materialButton(
                                    nameAction: "volver al inicio de sesion",
                                    function:  () async {
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
                    )
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
    TextEditingController mailController) async {

   final userProvider = context.read<UserProvider>();
   final notificationProvider = context.read<NotificationProvider>();

   print('========== RECOVERY ==========');
   print('UserRepository: ${userProvider.repository}');
   print('username: ${usernameController.text.trim()}');
   print('mail: ${mailController.text.trim()}');

   final user = await userProvider.repository!
         .findByUsernameAndMail(
           usernameController.text.trim(),
           mailController.text.trim()
   );
print(user);
   if(user == null) {
     await error(context, "usuario o correo no funcionan");
     return;
   }

   final result = await notificationProvider.requestPasswordReset(
       context: context,
       user: user
   );
   print(result.sent);
   if (result.success) {
     await confirm(
       context,
     "se envio password",
     );
   }
}

