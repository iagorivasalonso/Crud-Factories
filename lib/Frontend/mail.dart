import 'dart:io';

import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Alertdialogs/warning.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/SQL/createMail.dart';
import 'package:crud_factories/Backend/SQL/modifyMail.dart';
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Backend/CSV/exportMails.dart';
import 'package:crud_factories/Functions/validatorCamps.dart';
import 'package:crud_factories/Objects/Mail.dart';
import 'package:crud_factories/Widgets/headView.dart';
import 'package:crud_factories/Widgets/textfield.dart';
import 'package:crud_factories/Widgets/textFieldPassword.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:crud_factories/helpers/localization_helper.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:mailer/smtp_server/hotmail.dart';
import '../Backend/Global/controllers/Mail.dart';
import '../Widgets/headViewsAndroid.dart';
import '../Widgets/layoutVariant.dart';
import '../Widgets/materialButton.dart';


class newMail extends StatefulWidget {

  int select;


  newMail(this.select);


  State<newMail> createState() => _newMailState();
}

class _newMailState extends State<newMail> {

  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();

  double widthBar = 10.0;

  late final MailController controllers;

  @override
  void initState() {
    super.initState();
    controllers = MailController(
      mail: TextEditingController(),
      password: TextEditingController(),
      passwordVerify: TextEditingController(),
    );
  }

  @override
  void dispose() {
    controllers.mail.dispose();
    controllers.password.dispose();
    controllers.passwordVerify!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context0) {

    BuildContext context = Platform.isWindows ? context1 : context0;
    int select = widget.select;

    String action = "";
    String action2 = "";
    String title = "";

    if (select == -1) {
      title = S.of(context).newMale;
      action = S.of(context).create;
      action2 = S.of(context).delete;
    }
    else {
      title = S.of(context).edit;

      campCharge(context,select,controllers);

      action = S.of(context).update;
      action2 = S.of(context).undo;
    }

    String name = S.of(context).mail;
    String title1 = "$title $name";

    return Platform.isWindows
        ? Scaffold(
      body: AdaptiveScrollbar(
        controller: verticalScroll,
        width: widthBar,
        child: AdaptiveScrollbar(
          controller: horizontalScroll,
          width: widthBar,
          position: ScrollbarPosition.bottom,
          underSpacing: const EdgeInsets.only(bottom: 8),
          child: SingleChildScrollView(
            controller: verticalScroll,
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              controller: horizontalScroll,
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                height: 475,
                width: 890,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, top: 30.0),
                    child: SizedBox(
                      width: 700,
                      child: Column(
                        children: [
                          headView(
                              title: title1
                          ),

                          defaultTextfield(
                              nameCamp: S.of(context).new_mail,
                              controllerCamp: controllers.mail,
                              campOld: select == -1 ? '' : mails[select].address,
                          ),

                          textfieldPassword(
                              nameCamp: S.of(context).password,
                              controllerCamp: controllers.password,
                          ),

                          textfieldPassword(
                              nameCamp: S.of(context).verify_password,
                              controllerCamp: controllers.passwordVerify!,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 500.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                    materialButton(
                                    nameAction: action,
                                    function: () => _onSaveMail(
                                      context,
                                      select,
                                      controllers,
                                    ),
                                  ),

                            Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: materialButton(
                                      nameAction: action2,
                                      function: () => _onResetMail(
                                        context,
                                        select,
                                        controllers,
                                      ),
                                    )
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    )
        : Scaffold(
           appBar: appBarAndroid(context, name: title1),
           body: Text("creart email"),
    );
  }
}

Future<void> _onSaveMail(BuildContext context, int select,MailController controllers) async {

  List <Mail> current = [];
  String action = "";

  List <String> allKeys = [];
  String nameCamp = S.of(context).mail;


  String campOld = " ";
  if(select != -1)
  {
    campOld = mails[select].address;
  }

  if((validatorCamps.primaryKeyCorrect(controllers.mail.text,nameCamp,allKeys,campOld,context) ==true) )
  {
    if(validatorCamps.mailCorrect(controllers.mail.text) != true)
    {
      action = S.of(context).not_a_valid_mail;
      await error(context, action);
    }
    if(controllers.password.text.isEmpty || controllers.passwordVerify!.text.isEmpty)
    {

      if(controllers.password.text.isEmpty)
      {
        String array = S.of(context).password;
        action = LocalizationHelper.camp_empty(context, array);
        await error(context, action);
      }
      else
      {
        String array = S.of(context).verify_password;
        action = LocalizationHelper.camp_empty(context, array);
        error(context, action);
      }
    }
    else
    {
      if (controllers.password.text == controllers.passwordVerify!.text)
      {

        String username = controllers.mail.text;
        String password = "";
        String company = "";


        List <String> separeaddress = username.split("@");

        final message = Message()
          ..from = Address(username, separeaddress[0])
          ..recipients.add(username)
          ..subject = S.of(context).connection_test
          ..text = S.of(context).this_is_a_connection_test_from_the_application;


        final result = await sendingMail(context,controllers,message);

        if (result == false)
        {
          String action = S.of(context).connection_cannot_be_established;
          error(context, action);
        }
        else
        {
                if (conn != null)
                {
                  if (select == -1)
                  {
                    sqlCreateMail(current);
                  }
                  else
                  {
                    current.add(mails[select]);
                    sqlModifyMail(current);
                  }
                }
                else
                {
                  mails = mails + current;

                  bool errorExp = await csvExportatorMails(mails);

                  if(errorExp != true && result != false)
                  {
                    String array = S.of(context).mails;
                    String action = LocalizationHelper.no_file(context, array);
                    warning(context, action);
                  }
                }

                if (result == false)
                {
                  action = S.of(context).the_user_or_password_are_incorrect;
                  error(context, action);
                }
                else
                {
                     action = S.of(context).the_connection_test_was_sent_successfully;
                     confirm(context, action);
                }

        }
      }
      else
      {
        action = S.of(context).passwords_do_not_match;
        error(context, action);
      }

    }

  }
}

Future sendingMail(context,controllers, Message message) async {

  bool connectEmail = false;
  String username = controllers.mail.text;
  String password = controllers.password.text;

  List <String> separeaddress = username.split("@");
  List <String> extCompany = separeaddress[1].split(".");

  String company = extCompany[0];

      try {

            if (company == "gmail") {
              final smtpServer = gmail(username, password);
              final sendReport = await send(message, smtpServer);
            }
            if (company == "hotmail") {
              final smtpServer = hotmail(username, password);
              final sendReport = await send(message, smtpServer);
            }

            connectEmail = true;
      } catch (e) {
           connectEmail = false;
      }

  return connectEmail;
}


Future<void>_onResetMail(BuildContext context,int select,  MailController controllers) async {

  if (select == -1) {
    controllers.mail.text = "";
    controllers.password.text = "";
    controllers.passwordVerify!.text = "";
  }
  else {
    campCharge(context,select,controllers);

  }
  saveChanges = false;
}

void campCharge(
    BuildContext context,
    int select,
    MailController controllers,
              ) {

  if(saveChanges == false)
  {
    controllers.mail.text = mails[select].address;
    controllers.password.clear();
    controllers.passwordVerify!.clear();
  }
}

