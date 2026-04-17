import 'dart:convert';
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
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:crud_factories/Backend/Global/controllers/Mail.dart';
import 'package:crud_factories/Backend/connectors_API/MailApi.dart';
import 'package:crud_factories/Functions/isNotAndroid.dart';
import 'package:crud_factories/Widgets/headViewsAndroid.dart';
import 'package:crud_factories/Widgets/materialButton.dart';


class newMail extends StatefulWidget {

  int select;


  newMail(this.select);


  State<newMail> createState() => _newMailState();
}

class _newMailState extends State<newMail> {

  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();


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

    BuildContext context = isNotAndroid() ? context0 :  context1;
    int select = widget.select;

    String action = "";
    String action2 = "";
    String title = "";

    if (select == -1) {
      title = S.of(context).newMale;
      action = S.of(context).create;
      action2 = S.of(context).reboot;
    }
    else {
      title = S.of(context).edit;

      campCharge(context,select,controllers);

      action = S.of(context).update;
      action2 = S.of(context).undo;
    }

    String name = S.of(context).mail;
    String title1 = "$title $name";

    return !isNotAndroid()
        ? Scaffold(
      body: Scrollbar(
        controller: verticalScroll,
        thumbVisibility: true,
        child: Scrollbar(
          controller: horizontalScroll,
          thumbVisibility: true,
          notificationPredicate: (notification) =>
          notification.metrics.axis == Axis.horizontal,
          child: SingleChildScrollView(
            controller: verticalScroll,
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              controller: horizontalScroll,
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 30.0, top: 30.0),
                child: Container(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
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
                            padding: const EdgeInsets.only(left: 500.0, top: 150.0),
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


        final result = await sendingMail(context,controllers,message,select);

        if (result.length != 1)
        {
          String action = S.of(context).connection_cannot_be_established;
          error(context, action);
        }
        else
        {

                if (BaseDateSelected.isNotEmpty)
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



                saveChanges = false;
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

                  bool errorExp = await csvExportatorMails(mails);

                if (!kIsWeb && errorExp != false)
                {
                  String array = S.of(context).mails;
                  String action = LocalizationHelper.no_file(context, array);
                  warning(context, action);
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

Future<List<String>> sendingMail(context,controllers, Message message, [select]) async {

  List<String> mailSends = [];

  String username = controllers.mail.text;
  String password = controllers.password.text;

  List <String> separeaddress = username.split("@");
  List <String> extCompany = separeaddress[1].split(".");

  String company = extCompany[0];

  final newMail = Mail(
    address: controllers.mail.text,
    password: controllers.password.text,
    id: '0',
    company: company,
  );

  if (select == -1) {
    // CREAR
    mails.add(newMail);
  } else {
    // EDITAR
    mails[select] = newMail;
  }

      try {

        SmtpServer? smtpServer;

            if (company == "gmail")
            {
              smtpServer = gmail(username, password);
            }
            else if (company == "hotmail")
            {
              smtpServer = hotmail(username, password);
            }
            else
            {
               String action = S.of(context).account_not_configured_on_the_server;
               error(context, action);
            }

        if (smtpServer != null)
        {

              if(kIsWeb)
              {

                List<Map<String, dynamic>> attachmentList = [];

                for (var file in controllers.attachments) {
                  if (file.bytes != null) {
                    attachmentList.add({
                      'filename': file.name,
                      'content': base64Encode(file.bytes!),
                      'contentType': 'application/octet-stream',
                    });
                  }
                }

                MessageMail messageMail = MessageMail(
                        host: smtpServer.host,
                        port: 465,
                        secure: true,
                        username: smtpServer.username!,
                        password:smtpServer.password!,
                        mails: message.recipients,
                        subject: message.subject!,
                        message: message.text!,
                        attachments: attachmentList
                    );

                    final mailResponse = await Mailapi.sendingMailApi(messageMail);


                final results = mailResponse['results'] as List<dynamic>?;

                if (results != null && results.isNotEmpty) {
                  final statuses = results.map((e) => (e as Map<String, dynamic>)['status']).join("\n");

                  if (results != null && results.isNotEmpty) {
                    for (var r in results) {
                      final map = r as Map<String, dynamic>;
                      final status = map['status'] ?? '';

                      // Regex para extraer correo
                      final regex = RegExp(r'\b[\w\.-]+@[\w\.-]+\.\w+\b');
                      final match = regex.firstMatch(status);
                      if (match != null) {
                        final email = match.group(0);
                        mailSends.add(email.toString());

                      }
                    }
                  }
                }
              }
              else
              {
                try {
                  final sendReport = await send(message, smtpServer);

                  for(int i = 0; i  < message.recipients.length; i++)
                  {
                    mailSends.add(message.recipients[i].toString());
                  }

                } catch (e) {
                  print("Error enviando correo: $e");
                }
              }

        }

      } catch (e) {
        print(e.toString());
       mailSends = [];
      }

  return mailSends;
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

