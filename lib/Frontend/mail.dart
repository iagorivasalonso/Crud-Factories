
import 'dart:ffi';

import 'package:crud_factories/Alertdialogs/confirm.dart' show confirm;
import 'package:crud_factories/Alertdialogs/error.dart' show error;
import 'package:crud_factories/Alertdialogs/selectCompany.dart' show newMailConfiguration;
import 'package:crud_factories/Backend/Data/controlsMessagesError/errors.dart';
import 'package:crud_factories/Backend/Feature/Mail/Service/mailConfiguration.dart';
import 'package:crud_factories/Backend/Providers/EditStateProvider.dart' show EditStateProvider;
import 'package:crud_factories/Backend/Providers/MailProvider.dart';
import 'package:crud_factories/Functions/isNotAndroid.dart' show isNotAndroid;
import 'package:crud_factories/Objects/Mail.dart';
import 'package:crud_factories/Objects/MailMessage.dart' show MailMessage;
import 'package:crud_factories/Validators/mail.dart';
import 'package:crud_factories/Widgets/headView.dart' show headView;
import 'package:crud_factories/Widgets/headViewsAndroid.dart' show appBarAndroid;
import 'package:crud_factories/Widgets/textFieldPassword.dart' show textfieldPassword;
import 'package:crud_factories/Widgets/textfield.dart' show defaultTextfield;
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:crud_factories/Backend/Global/controllers/Mail.dart';
import 'package:provider/provider.dart';

import '../Backend/Feature/Mail/Service/mailConfigurationService.dart';
import '../Widgets/materialButton.dart';



class MailFormPage extends StatefulWidget {

  MailFormPage();


  State<MailFormPage> createState() => _MailFormPageState();
}

class _MailFormPageState extends State<MailFormPage> {

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

    final mail = context.read<MailProvider>().selected;

    if(mail  != null) {
      loadSelectedMail(mail);
    }
  }

  @override
  void dispose() {
    controllers.mail.dispose();
    controllers.password.dispose();
    controllers.passwordVerify!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final mailSelected = context.watch<MailProvider>().selected;

    final isEditing = mailSelected != null;

    final title = isEditing
          ? S.of(context).edit
          : S.of(context).newMale;

    final action = isEditing
          ? S.of(context).update
          : S.of(context).create;

    final action2 = isEditing
        ? S.of(context).undo
        : S.of(context).clear;

    String name = S.of(context).mail;
    String title1 = "$title $name";


    final mailId = isEditing
          ? mailSelected!.id
          :createNextMailId(context.read<MailProvider>().mails);


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
                padding: const EdgeInsets.only(left: 10.0, top: 30.0),
                child: Container(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      children: [
                        SizedBox(
                          width: 600,
                          child: Column(
                            children: [
                              headView(
                                  title: title1
                              ),

                              defaultTextfield(
                                nameCamp: S.of(context).new_mail,
                                controllerCamp: controllers.mail,
                                campOld: mailSelected?.mail ?? '',
                                context: context
                              ),

                              textfieldPassword(
                                nameCamp: S.of(context).password,
                                controllerCamp: controllers.password,
                                context: context,
                              ),

                              textfieldPassword(
                                nameCamp: S.of(context).verify_password,
                                controllerCamp: controllers.passwordVerify!,
                              ),

                            ],
                          ),
                        ),

                        SizedBox(
                            width: 700,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 500.0, top: 150.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  materialButton(
                                    nameAction: action,
                                    function: () => _onSaveMail(
                                        context,
                                        mailSelected,
                                        controllers,
                                        mailId
                                    ),
                                  ),

                                  Padding(
                                      padding: const EdgeInsets.only(left: 20.0),
                                      child: materialButton(
                                        nameAction: action2,
                                        function: () => _onResetMail(
                                            mailSelected,
                                            controllers
                                        ),
                                      )
                                  )
                                ],
                              ),
                            ),
                        )
                      ],
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

  void loadSelectedMail(Mail mail) {

    controllers.mail.text = mail.mail;
    controllers.password.text = '';
    controllers.passwordVerify!.text = '';
  }

  void _onResetMail( Mail? mailSelected, MailController controllers) {

          if(mailSelected != null)
          {
            loadSelectedMail(mailSelected);
          }
          else
          {
            controllers.mail.clear();
            controllers.password.clear();
            controllers.passwordVerify?.clear();
          }


  }

  Future<void> _onSaveMail (BuildContext context, Mail? mailSelected, MailController controllers,String mailId) async {

       final isEditing = mailSelected != null;

       final mailProvider = context.read<MailProvider>();

       final errorMsg = MailValidator.validate(
            context,
            controllers,
            mailSelected,
            mailProvider.mails
       );

       if (errorMsg != null) {
         error(context, errorMsg);
         return;
       }

         final config = MailConfigurationService.fromMail(controllers.mail.text);

         final mailConfiguration = config ?? await newMailConfiguration(context);


         if (mailConfiguration == null) return;

           final id = isEditing ? mailSelected!.id : mailId;

           final  mail = MailConfigurationService.createMail(
               id: id,
               controllers: controllers,
               configuration: mailConfiguration,
             );

             mailProvider.select(mail);

             final result = await _testConnection(
               context,
               mailProvider,
               mail,
             );

             if(!result.success) {
               error(context, result.failed.first.error);
               return;
             }



       if(isEditing)
       {
            final result = await mailProvider.update(mail);

            switch(result)
            {
              case EditResult.success:
                await confirm(context,S.of(context).mail_updated_successfully);
              break;

              case EditResult.alreadyExists:
                await error(context, S.of(context).mail_already_exists);
               break;

              case EditResult.notFound:
                await error(context,S.of(context).mail_not_found);
              break;
              case EditResult.invalidData:
                await error(context, S.of(context).invalid_data);
               break;
              case EditResult.error:
                // TODO: Handle this case.
                throw UnimplementedError();
            }
       }
       else
       {
          final result = await mailProvider.create(mail);

          switch(result)
          {
            case CreateResult.success:
                await confirm(context,S.of(context).mail_created_successfully);
              break;
            case CreateResult.alreadyExists:
                await error(context, S.of(context).mail_already_exists);
             break;
            case CreateResult.invalidData:
              await error(context, S.of(context).invalid_data);
            break;
          }
       }
       context.read<EditStateProvider>().clear();
  }

  Future <MailResult> _testConnection (
      BuildContext context,
      MailProvider mailProvider,
      Mail mail,
      ) async {

    final mailMessage = MailMessage(
      recipients: [mail.mail],
      subject: S.of(context).connection_test,
      message: S.of(context).this_is_a_connection_test_from_the_application,
    );


    return await mailProvider.send(
      mailMessage,
      account: mail,
      noAccountMessage: S.of(context).no_mail_account_selected,
    );

  }

  String createNextMailId(List<Mail> mails) {

    final ids = mails.map((m) => int.parse(m.id));

    final maxId = ids.isEmpty ? 0 : ids.reduce((a, b) => a > b ? a : b);

      return (maxId + 1).toString();
  }
}


