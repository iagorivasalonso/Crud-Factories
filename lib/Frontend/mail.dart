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

import '../Widgets/headViewsAndroid.dart';
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

  late TextEditingController controllerMail = new TextEditingController();
  late TextEditingController controllerCompany = new TextEditingController();
  late TextEditingController controllerPas = new TextEditingController();
  late TextEditingController controllerPasVerificator = new TextEditingController();


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

      campCharge(context,select,controllerMail,controllerPas,controllerPasVerificator);

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
                              controllerCamp: controllerMail,
                              campOld: select == -1 ? '' : mails[select].addrres,
                          ),

                          textfieldPassword(
                              nameCamp: S.of(context).password,
                              controllerCamp: controllerPas,
                          ),

                          textfieldPassword(
                              nameCamp: S.of(context).verify_password,
                              controllerCamp: controllerPasVerificator,
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: SizedBox(
                              width: 200,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  materialButton(
                                    nameAction: action,
                                    function: () => _onSaveMail(
                                      context,
                                      select,
                                      controllerMail,
                                      controllerPas,
                                      controllerPasVerificator,
                                    ),
                                  ),

                                  materialButton(
                                    nameAction: action2,
                                    function: () => _onResetMail(
                                      context,
                                      select,
                                      controllerMail,
                                      controllerPas,
                                      controllerPasVerificator,
                                    ),
                                  )
                                ],
                              ),
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

Future<void>_onResetMail(BuildContext context,int select, TextEditingController controllerMail, TextEditingController controllerPas, TextEditingController controllerPasVerificator) async {

  if (select == -1) {
    controllerMail.text = "";
    controllerPas.text = "";
    controllerPasVerificator.text = "";
  }
  else {
    campCharge(context,select,controllerMail,controllerPas,controllerPasVerificator);

  }
  saveChanges = false;
}


Future<void> _onSaveMail(BuildContext context, int select,TextEditingController controllerMail, TextEditingController controllerPas, TextEditingController controllerPasVerificator) async {

  List <Mail> current = [];
  String action = "";

  List <String> allKeys = [];
  String nameCamp = S.of(context).mail;

  for (int i = 0; i < allFactories.length; i++)
  {
    allKeys.add(allFactories[i].name);
  }


  String campOld = " ";
  if(select != -1)
  {
    campOld = mails[select].addrres;
  }


  if((validatorCamps.primaryKeyCorrect(controllerMail.text,nameCamp,allKeys,campOld,context) ==true) )
  {
    if(validatorCamps.mailCorrect(controllerMail.text) != true)
    {
      action = S.of(context).not_a_valid_mail;
      await error(context, action);
    }
    if(controllerPas.text.isEmpty || controllerPasVerificator.text.isEmpty)
    {

      if(controllerPas.text.isEmpty)
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
      if (controllerPas.text == controllerPasVerificator.text)
      {
        final result = await testMail(context,controllerMail,controllerPas,controllerPasVerificator);

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

Future testMail(context,controllerMail,controllerPas,controllerPasVerificator) async {

  bool connectEmail = false;
  String username = controllerMail.text;
  String password = "";
  String company = " ";

  if (controllerPas.text == controllerPasVerificator.text) {
    password = controllerPas.text;
  }

  List <String> separeAddrres = username.split("@");
  List <String> extCompany = separeAddrres[1].split(".");

  company = extCompany[0];

  try {
    final message = Message()
      ..from = Address(username, separeAddrres[0])
      ..recipients.add(username)
      ..subject = S.of(context).connection_test
      ..text = S.of(context).this_is_a_connection_test_from_the_application;


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
    print(e);
    connectEmail = false;
  }

  return connectEmail;
}

void campCharge(
    BuildContext context,
    int select,
    TextEditingController controllerMail,
    TextEditingController controllerPas,
    TextEditingController controllerPasVerificator
              ) {

  if(saveChanges == false)
  {
    controllerMail.text = mails[select].addrres;
    controllerPas.text = "";
    controllerPasVerificator.text = "";
  }
}

