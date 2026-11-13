
import 'package:crud_factories/Alertdialogs/confirm.dart' show confirm;
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Backend/Feature/PasswordReset/Service/IPasswordResetService.dart' show IPasswordResetService;
import 'package:crud_factories/Widgets/genericCheckbox.dart';
import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:crud_factories/Widgets/loadingOverlay.dart' show LoadingOverlay;
import 'package:crud_factories/Widgets/materialButton.dart';
import 'package:crud_factories/Widgets/textFieldPassword.dart' show textfieldPassword;
import 'package:crud_factories/generated/l10n.dart' show S;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' hide showDialog;
import 'package:provider/provider.dart';
import '../Widgets/textfield.dart';


enum PasswordResetStep{
      request,
      verify,
      changuePassword
}

Future<void> forgot_Password (
     BuildContext context,
     TextEditingController usernameController
    ) async {

      await forgotPassword(
          context,
          usernameController.text
      );
}

Future<bool?> forgotPassword(
     BuildContext context,
     String username
     ) async {

   final usernameController = TextEditingController(text: username);
   final mailController = TextEditingController();
   final tokenController = TextEditingController();
   final passwordController = TextEditingController();
   final confirmPasswordController = TextEditingController();

   final service = context.read<IPasswordResetService>();

   PasswordResetStep currentStep = PasswordResetStep.request;

   bool  isLoading = false;
   bool showPassword = false;
   bool showConfirmPassword = false;

   final result = await showDialog<bool>(
       context: context,
       builder: (dialogContext) {
             return StatefulBuilder(
                 builder: (dialogContext,setState) {


                   Future<void> requestPass() async {// Solicitar recuperación
                     if (isLoading) return;

                     setState(() {
                          isLoading = true;
                     });

                      try {

                           await service.requestReset(
                               username: usernameController.text,
                               mail: mailController.text
                           );

                           if(!dialogContext.mounted) return;

                            setState(() {
                              currentStep = PasswordResetStep.verify;
                            });
                      } catch (e) {
                        if (dialogContext.mounted) {
                          await error(dialogContext, e.toString());
                        }
                      } finally {
                        if (dialogContext.mounted) {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }


                   }

                   Future<void> verifyCode() async {         //verificar codigo

                     if (isLoading) return;

                     setState(() {
                       isLoading = true;
                     });

                     try {
                          final isValid = await service.verifyReset(
                              username: usernameController.text,
                              mail: mailController.text,
                              token: tokenController.text
                          );

                          if(!dialogContext.mounted) return;

                          if(isValid){
                            setState(() {
                              currentStep = PasswordResetStep.changuePassword;
                            });
                          } else {
                            await error(
                              dialogContext,
                              S.of(context).invalid_recovery_code,
                            );
                          }

                     } catch (e){
                       if (dialogContext.mounted) {
                         await error(dialogContext, e.toString());
                       }

                     } finally {
                       if(dialogContext.mounted) {
                         setState((){
                             isLoading = false;
                         });
                       }

                     }

                   }

                   Future<void> changePassword() async {       // Cambiar contraseña

                     if (isLoading) return;

                     if(passwordController.text.isEmpty || confirmPasswordController.text.isEmpty)
                     {
                       await error(dialogContext, S.of(context).complete_both_passwords);
                       return;
                     }

                     if(passwordController.text != confirmPasswordController.text)
                     {
                       await error(dialogContext, S.of(context).passwords_do_not_match);
                       return;
                     }

                     setState(() {
                       isLoading = true;
                     });

                      try{
                           await service.resetPassword(
                               username: usernameController.text,
                               mail: mailController.text,
                               token: tokenController.text,
                               newPassword: passwordController.text
                           );

                           if (!dialogContext.mounted) return;

                           Navigator.of(dialogContext).pop(true);

                           await confirm(
                             context,
                             S.of(context).password_reset_success,
                           );


                      } catch (e) {
                        if (dialogContext.mounted) {
                          await error(dialogContext, e.toString());
                        }

                      } finally {
                        if (dialogContext.mounted) {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }

                   }

                   return Dialog(
                       shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(0)
                       ),
                       child: Stack(
                           children: [
                                ConstrainedBox(
                                    constraints: const BoxConstraints(
                                       maxWidth: 400,
                                       minHeight: 90
                                    ),
                                    child: Column(
                                       mainAxisSize: MainAxisSize.min,
                                       children: [
                                           headDialog(
                                               title: S.of(dialogContext).user_access
                                           ),
                                           Flexible(
                                               child: SingleChildScrollView(
                                                   child: Padding(
                                                       padding: const EdgeInsetsGeometry.all(15),
                                                       child: Column(
                                                           children: [
                                                               if(currentStep == PasswordResetStep.request) ...[
                                                                 
                                                                 defaultTextfield(
                                                                   nameCamp: S.of(dialogContext).user,
                                                                   controllerCamp: usernameController,
                                                                   context: dialogContext,
                                                                 ),

                                                                 defaultTextfield(
                                                                   nameCamp: S.of(dialogContext).mail,
                                                                   controllerCamp: mailController,
                                                                   context: dialogContext,
                                                                 ),

                                                                 const SizedBox(height: 20),

                                                                 Row(
                                                                   mainAxisAlignment: MainAxisAlignment.center,
                                                                   children: [
                                                                     materialButton(
                                                                         nameAction:  S.of(context).reset,
                                                                         function: () => requestPass()
                                                                     ),
                                                                     SizedBox(width: 25),
                                                                     materialButton(
                                                                       nameAction: S.of(dialogContext).back,
                                                                       function: () {
                                                                         Navigator.of(dialogContext).pop(true);
                                                                       },
                                                                     )
                                                                   ],
                                                                 ),
                                                               ],
                                                               if(currentStep == PasswordResetStep.verify) ...[

                                                                   defaultTextfield(
                                                                     nameCamp:  S.of(context).recovery_code,
                                                                     controllerCamp: tokenController,
                                                                     context: dialogContext,
                                                                   ),

                                                                   const SizedBox(height: 20),

                                                                   Row(
                                                                     mainAxisAlignment: MainAxisAlignment.center,
                                                                     children: [

                                                                       materialButton(
                                                                           nameAction:  S.of(context).verify,
                                                                           function: () => verifyCode()
                                                                       ),
                                                                       SizedBox(width: 25),
                                                                       materialButton(
                                                                         nameAction: S.of(dialogContext).back,
                                                                         function: () {
                                                                           setState((){
                                                                              currentStep = PasswordResetStep.request;
                                                                           });
                                                                         },
                                                                       ),
                                                                     ],
                                                                   ),
                                                             ],
                                                             if(currentStep == PasswordResetStep.changuePassword) ...[

                                                               textfieldPassword(
                                                                   nameCamp: S.of(context).password,
                                                                   controllerCamp: passwordController,
                                                                   obscureText: !showPassword
                                                               ),

                                                               genericCheckbox(
                                                                   text: S.of(context).show_password,
                                                                   value: showPassword,
                                                                   onChanged: (value) {
                                                                      setState((){
                                                                         showPassword = value ?? false;
                                                                      });
                                                                   }),


                                                               textfieldPassword(
                                                                   nameCamp: S.of(context).verify_password,
                                                                   controllerCamp: confirmPasswordController,
                                                                   obscureText: !showPassword
                                                               ),

                                                               genericCheckbox(
                                                                   text: S.of(context).show_password,
                                                                   value: showConfirmPassword,
                                                                   onChanged: (value) {
                                                                     setState((){
                                                                       showConfirmPassword = value ?? false;
                                                                     });
                                                                   }),

                                                                  const SizedBox(height: 20,),

                                                                materialButton(
                                                                    nameAction: S.of(context).change_password,
                                                                    function: () => changePassword()
                                                                ),

                                                             ]
                                                           ],
                                                       ),
                                                   ),
                                               )
                                           )
                                       ],
                                    ),
                                ),
                             if (isLoading)
                               LoadingOverlay()
                           ],
                       ),
                    );
                 }
             );
       });

   usernameController.dispose();
   mailController.dispose();
   tokenController.dispose();
   passwordController.dispose();
   confirmPasswordController.dispose();

   return result;
}


/*
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
}*/