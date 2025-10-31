
import 'dart:convert';
import 'dart:io';
import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Alertdialogs/warning.dart';
import 'package:crud_factories/Backend/CSV/exportLines.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/SQL/modifyLines.dart';
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Functions/validatorCamps.dart';
import 'package:crud_factories/Objects/Factory.dart';
import 'package:crud_factories/Objects/Mail.dart';
import 'package:crud_factories/Objects/LineSend.dart';
import 'package:crud_factories/Widgets/genericRadioGroup.dart';
import 'package:crud_factories/Widgets/headView.dart';
import 'package:crud_factories/Widgets/headViewsAndroid.dart';
import 'package:crud_factories/Widgets/textfieldCalendar.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:crud_factories/helpers/localization_helper.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart' show Message, Address, send;
import 'package:mailer/smtp_server/gmail.dart';
import 'package:mailer/src/entities/attachment.dart';

import '../Backend/Global/controllers/Mail.dart';
import '../Widgets/dropDownButton.dart';
import '../Widgets/Fileattachment.dart';
import '../Widgets/layoutVariant.dart';
import '../Widgets/materialButton.dart';
import '../Widgets/tableElements.dart';
import '../Widgets/textArea.dart';
import '../Widgets/textFieldPassword.dart';
import '../Widgets/textfield.dart';
import 'mail.dart';




class sendMail extends StatefulWidget {


  sendMail();

  @override
  State<sendMail> createState() => _sendMailState();
}

class _sendMailState extends State<sendMail> {


  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();
  final ScrollController verticalScrollTable = ScrollController();



  double widthBar = 10.0;


  List <String> columns = [];
  List <String> columnsTable = [];
  List <LineSend> sends = [];
  List <LineSend> sendsDay = [];
  List <Factory> selectedFactories = [];
  String? selectedSend;
  Mail? selectedMail;
  bool otherMail= false;
  bool mailSave = false;
  int cantFactories = 0;
  double marginBox = 0;

  String nameRoute = "";

  late final MailController controllers;

  @override
  void initState() {
    super.initState();
    controllers = MailController(
      mail: TextEditingController(),
      password: TextEditingController(),
      mailTo: TextEditingController(),
      subject: TextEditingController(),
      message: TextEditingController()

    );

  }

  @override
  void dispose() {
    controllers.mail.dispose();
    controllers.password.dispose();
    controllers.mailTo!.dispose();
    controllers.subject!.dispose();
    controllers.message!.dispose();

    super.dispose();
  }

  String? selectedOption;




  @override
  Widget build(BuildContext context0) {

    BuildContext context = Platform.isWindows ? context1 : context0;

    if(selectedOption==null)
    {
      selectedOption =S.of(context).a_recipient;
    }

    if(mails.isEmpty)
    {
        otherMail = true;
    }
    else
    {
           if (selectedMail==null)
           {
               controllers.mailTo!.text = mails[0].address;
               controllers.password.text =  mails[0].password;
               mailSave = true;
           }

           if(otherMail == true)
           {
             controllers.mailTo!.text  = "";
             controllers.password.text = "";
           }
    }


    return Platform.isWindows
        ? Scaffold(
      body: AdaptiveScrollbar(
        controller: verticalScroll,
        width: widthBar,
        child: AdaptiveScrollbar(
          controller: horizontalScroll,
          width: widthBar,
          position: ScrollbarPosition.bottom,
          underSpacing: EdgeInsets.only(bottom: 8),
          child: SingleChildScrollView(
            controller: verticalScroll,
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              controller: horizontalScroll,
              scrollDirection: Axis.horizontal,
              child: Container(
                height: selectedOption == S.of(context).a_recipient
                    ? 835
                    : 1105,
                width: 880,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0, left: 30),
                    child: Column(
                        children: [
                          headView(
                              title: S.of(context).sending_mails
                          ),

                    layoutVariant(
                      items: [
                        Flexible(
                          flex: 9,
                          child: otherMail == false
                              ? GenericDropdown<Mail>(
                                items: mails,
                                camp: S.of(context).sender,
                                selectedItem: selectedMail,
                                hint: mails[0].address,
                                itemLabel: (Mail) => Mail.address,
                                onChanged: (mailChoose) => _onMailChanged(mailChoose),
                              )
                              : Row(
                            children: [
                              Expanded(
                                child: defaultTextfield(
                                  nameCamp: S.of(context).mail,
                                  controllerCamp: controllers.mail,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: textfieldPassword(
                                  nameCamp: S.of(context).password,
                                  controllerCamp: controllers.password,
                                ),
                              ),
                            ],
                          ),
                        ),

                        if(mails.isNotEmpty)
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20,left:22),
                            child: materialButton(
                              nameAction: otherMail == false
                                  ? S.of(context).orther
                                  : S.of(context).volver,
                              function: () async {
                                setState(() {
                                  otherMail = !otherMail;
                                });
                              },
                            ),
                          ),
                        )
                      ],
                    ),

                    if(allLines.isNotEmpty)
                    Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: GenericRadioGroup<String>(
                              items: [S.of(context).a_recipient,S.of(context).multiple_recipients],
                              camp: S.of(context).select,
                              selectedItem: selectedOption,
                              label: (item) => item,
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    selectedOption = value;
                                  });
                                }
                              },
                              direction: Axis.horizontal,
                            ),
                          ),


                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: selectedOption == S.of(context).a_recipient
                            ? Align(
                              alignment: Alignment.topLeft,
                              child: SizedBox(
                                width: 800,
                                child: defaultTextfield(
                                  nameCamp: S.of(context).a_recipient,
                                  controllerCamp: controllers.mailTo!,
                                ),
                              ),
                            )
                            : Column(
                              children: [
                               Align(
                                 alignment: Alignment.topLeft,
                                 child: SizedBox(
                                      width: 420,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 20.0),
                                        child: GenericDropdown<String>(
                                          items: dateSends,
                                          camp: S.of(context).multiple_recipients,
                                          selectedItem: selectedSend,
                                          hint: S.of(context).select,
                                          itemLabel: (dateSend) => dateSend,
                                          onChanged: _onDateSelect,
                                        ),
                                      ),
                                    ),
                               ),

                                tableElements(
                                  columnsTable: [S.of(context).company, S.of(context).mail],
                                  contentTable: selectedFactories,
                                  controllerCamp: TextEditingController(),
                                  rowBuilder:  (factory) => [factory.name, factory.mail],
                                ),

                              ],
                            ),
                          ),


                          Fileattachment(
                            camp: controllers.subject!,
                            multiple: true,
                            attachments: controllers.attachments,
                            allowedExtensions: ['pdf', 'csv', 'jpg'], // extensiones permitidas
                            onFilesChanged: (files) {
                              setState(() {
                                controllers.attachments.addAll(files);
                              });
                            },
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 30.0,top: 30.0),
                            child: textArea(
                                nameCamp: S.of(context).message,
                                campOld: '',
                                controllerCamp: controllers.message!
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 650.0,top:  20.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                materialButton(
                                    nameAction: S.of(context).send,
                                    function: () => _onSendMail(context,controllers,otherMail,selectedOption),

                                ),

                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: materialButton(
                                      nameAction: S.of(context).reboot,
                                      function: () => _onResetMail(context,controllers,setState,selectedOption),

                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    )
        : Scaffold(
          appBar: appBarAndroid(context, name: S.of(context).sending_mails),
          body: Text("creart email"),
    );
  }

  Future<void>_onMailChanged(Mail? mailChoose) async {

      setState(() {
        selectedMail = mailChoose;

        controllers.mail.text = mailChoose!.address;

        Codec<String, String> stringToBase64 = utf8.fuse(base64);
        String password = stringToBase64.decode(controllers.password.text);

        controllers.password.text = password;

        mailSave = true;
      });
    }

  Future<void> _onDateSelect(String? dateChoose) async {
    if (dateChoose == null) return;

    final newSendsDay = lineSector
        .where((sector) => sector.date == dateChoose)
        .toList();

    final newFactories = allFactories
        .where((factory) => newSendsDay.any((send) => send.factory == factory.name))
        .toList();

    setState(() {
      selectedSend = dateChoose;
      sendsDay = newSendsDay;
      selectedFactories = newFactories;
      cantFactories = selectedFactories.length;
    });
  }
}

Future<void> _onSendMail(BuildContext context,MailController controllers, bool otherMail, String? selectedOption) async {

  bool correct = true;
  String action = '';


   if(otherMail)
   {
         if(validatorCamps.mailCorrect(controllers.mail.text) != true)
         {
             correct = false;
             action = S.of(context).your_mail_is_invalid;
             error(context,action);
         }
   }
   
   if (correct)
   {

         if(selectedOption == S.of(context).a_recipient)
         {
               if(validatorCamps.mailCorrect(controllers.mailTo!.text) != true)
               {
                   correct = false;
                   action = S.of(context).The_recipient_is_not_a_valid_mail;
                   error(context,action);
               }
         }
   }

   if(correct)
   {
         if(controllers.subject!.text.isEmpty)
         {
           String array = S.of(context).affair;
           action = LocalizationHelper.camp_empty_continue(context, array);
           correct= await warning(context, action);
         }
   }

  if(correct)
  {
    if(controllers.message!.text.isEmpty)
    {
      String array = S.of(context).message;
      action = LocalizationHelper.camp_empty_continue(context, array);
      correct= await warning(context, action);
    }
  }

  if(correct)
  {
    List <String> separeaddress = controllers.mailTo!.text.split("@");

    final message = Message()
      ..from = Address(controllers.mailTo!.text, separeaddress[0])
      ..recipients.add(controllers.mailTo!.text)
      ..subject = controllers.subject!.text
      ..text = controllers.message!.text
      ..attachments = controllers.attachments
          .map((file) => FileAttachment(file))
          .toList();

      final result = await sendingMail(context,controllers,message);

      if(result)
      {
        action=S.of(context).the_mail_has_been_successfully_sent;
        confirm(context,action);
      }

  }

}

Future<void> _onResetMail(BuildContext context,MailController controllers, Function(VoidCallback) setState, String? selectedOption) async {

  controllers.mail.text = "";
  controllers.password.text = "";
  controllers.mailTo!.text = "";
  controllers.subject!.text ="";
  controllers.message!.text="";
  controllers.attachments.clear();

  selectedOption = S.of(context).a_recipient;

}






