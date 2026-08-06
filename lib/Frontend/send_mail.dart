import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Alertdialogs/error.dart' show error;
import 'package:crud_factories/Alertdialogs/errorList.dart';
import 'package:crud_factories/Alertdialogs/selectCompany.dart' show newMailConfiguration;
import 'package:crud_factories/Alertdialogs/warning.dart' show warning;
import 'package:crud_factories/Backend/Data/controlsMessagesError/errors.dart';
import 'package:crud_factories/Backend/Feature/Mail/Service/mailConfigurationService.dart';
import 'package:crud_factories/Backend/Providers/EditStateProvider.dart' show EditStateProvider;
import 'package:crud_factories/Backend/Providers/FactoryProvider.dart';
import 'package:crud_factories/Backend/Providers/LineSendProvider.dart' show LineSendProvider;
import 'package:crud_factories/Backend/Providers/MailProvider.dart' show MailProvider;
import 'package:crud_factories/Validators/sendMail.dart' show SendMailValidator;
import 'package:crud_factories/helpers/localization_helper.dart';
import 'package:flutter/material.dart';
import 'package:crud_factories/Objects/Factory.dart';
import 'package:crud_factories/Objects/Mail.dart';
import 'package:crud_factories/Widgets/genericRadioGroup.dart';
import 'package:crud_factories/Widgets/headView.dart';
import 'package:crud_factories/Widgets/headViewsAndroid.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:crud_factories/Backend/Global/controllers/Mail.dart';
import 'package:crud_factories/Functions/isNotAndroid.dart';
import 'package:crud_factories/Widgets/dropDownButton.dart';
import 'package:crud_factories/Widgets/Fileattachment.dart';
import 'package:crud_factories/Widgets/layoutVariant.dart';
import 'package:crud_factories/Widgets/materialButton.dart';
import 'package:crud_factories/Widgets/tableElements.dart';
import 'package:crud_factories/Widgets/textArea.dart';
import 'package:crud_factories/Widgets/textFieldPassword.dart';
import 'package:crud_factories/Widgets/textfield.dart';
import 'package:provider/provider.dart' show WatchContext, ReadContext;

import '../Objects/MailMessage.dart';



class SendMail extends StatefulWidget {


   const SendMail({super.key});

  @override
  State<SendMail> createState() => _SendMailState();
}

class _SendMailState extends State<SendMail> {


  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();

  late final MailController controller;



  String? selectedSend;
  String? selectedOption;

  List<Factory> selectedFactories = [];

  bool otherMail = false;

  String previousMail = "";
  String previusPassword = "";

  @override
  void initState() {
    super.initState();

    controller = MailController(
      mail: TextEditingController(),
      password: TextEditingController(),
      mailTo: TextEditingController(),
      subject: TextEditingController(),
      message: TextEditingController(),
    );

    final provider = context.read<MailProvider>();

    otherMail = provider.mails.isEmpty;

    WidgetsBinding.instance.addPostFrameCallback((_) {

      if (provider.selected == null && provider.mails.isNotEmpty) {
        provider.select(provider.mails.first);
      }
    });

  }

  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_initialized) return;

    selectedOption = S.of(context).a_recipient;

    _initialized = true;
  }

  @override
  void dispose() {
    horizontalScroll.dispose();
    verticalScroll.dispose();

    controller.mail.dispose();
    controller.password.dispose();
    controller.mailTo!.dispose();
    controller.subject!.dispose();
    controller.message!.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final providerMails = context.watch<MailProvider>();
    final providerLines = context.watch<LineSendProvider>();

    final mails = providerMails.mails;
    Mail? selectedMail;

    if(providerMails.selected != null)
    {

      for (final mail in mails) {
        if (mail.id == providerMails.selected!.id) {
          selectedMail = mail;
          break;
        }
      }
    }

    final lines = providerLines.LineSends;

    final dateSends = providerLines
        .displayLines(shipmentText: S
        .of(context)
        .shipment)
        .map((card) => card.description)
        .toList();

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
                    minWidth: MediaQuery
                        .of(context)
                        .size
                        .width,
                    minHeight: MediaQuery
                        .of(context)
                        .size
                        .height,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width: 880,
                      child: Column(
                          children: [
                            headView(
                                title: S
                                    .of(context)
                                    .sending_mails
                            ),

                            Padding(
                              padding: otherMail == false
                                  ? const EdgeInsets.only(left: 30.0)
                                  : const EdgeInsets.only(left: 3.0),
                              child: layoutVariant(
                                items: [
                                  Flexible(
                                    flex: 4,
                                    child: otherMail == false
                                        ? GenericDropdown<Mail>(
                                      items: mails,
                                      camp: S
                                          .of(context)
                                          .sender,
                                      selectedItem: selectedMail,
                                      hint: mails.isNotEmpty
                                          ? mails.first.mail
                                          : "",
                                      itemLabel: (mail) => mail.mail,
                                      onChanged: _onMailChanged,
                                    )
                                        : Row(
                                      children: [
                                        Expanded(
                                          child: defaultTextfield(
                                            nameCamp: S
                                                .of(context)
                                                .mail,
                                            controllerCamp: controller.mail,
                                            context: context,
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: textfieldPassword(
                                            nameCamp: S
                                                .of(context)
                                                .password,
                                            controllerCamp: controller.password,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  if(mails.isNotEmpty)
                                    Flexible(
                                      flex: 1,
                                      child: Padding(
                                        padding: otherMail == false
                                            ? const EdgeInsets.only(top: 10)
                                            : const EdgeInsets.only(top: 20),
                                        child: materialButton(
                                            nameAction: otherMail == false
                                                ? S
                                                .of(context)
                                                .orther
                                                : S
                                                .of(context)
                                                .back,
                                            function: _changeMailMode
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            ),

                            if(lines.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(left: 30.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 150.0, bottom: 10.0),
                                    child: GenericRadioGroup<String>(
                                      items: [S
                                          .of(context)
                                          .a_recipient, S
                                          .of(context)
                                          .multiple_recipients
                                      ],
                                      camp: S
                                          .of(context)
                                          .select,
                                      selectedItem: selectedOption,
                                      label: (item) => item,
                                      onChanged: _onOptionChanged,
                                      direction: Axis.horizontal,
                                    ),
                                  ),
                                ),
                              ),

                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: selectedOption == S
                                  .of(context)
                                  .a_recipient
                                  ? Align(
                                alignment: Alignment.topLeft,
                                child: SizedBox(
                                  width: 600,
                                  child: defaultTextfield(
                                    nameCamp: S
                                        .of(context)
                                        .a_recipient,
                                    controllerCamp: controller.mailTo!,
                                    context: context,
                                  ),
                                ),
                              )
                                  : Padding(
                                    padding: const EdgeInsets.only(left: 80.0),
                                    child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: SizedBox(
                                        width: 420,
                                        child: GenericDropdown<String>(
                                          items: dateSends,
                                          camp: S
                                              .of(context)
                                              .multiple_recipients,
                                          selectedItem: selectedSend,
                                          hint: S
                                              .of(context)
                                              .select,
                                          itemLabel: (dateSend) => dateSend,
                                          onChanged: _onDateSelect,
                                        ),
                                      ),
                                    ),

                                    if(selectedFactories.isNotEmpty)
                                    tableElements(
                                      columnsTable: [S
                                          .of(context)
                                          .company, S
                                          .of(context)
                                          .mail
                                      ],
                                      contentTable: selectedFactories,
                                      rowBuilder: (factory) =>
                                      [
                                        factory.name,
                                        factory.mail
                                      ],
                                    ),
                                  ],
                                    ),
                                  ),
                            ),

                            Align(
                              alignment: Alignment.topLeft,
                              child: Fileattachment(
                                camp: controller.subject!,
                                multiple: true,
                                attachments: controller.attachments,
                                allowedExtensions: ['pdf', 'csv', 'jpg'],
                                // extensiones permitidas
                                onFilesChanged: (files) {
                                  setState(() {
                                    controller.attachments.addAll(files);
                                  });
                                },
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 30.0, top: 30.0),
                              child: textArea(
                                  nameCamp: S
                                      .of(context)
                                      .message,
                                  campOld: '',
                                  controllerCamp: controller.message!,
                                  context: context
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 650.0, top: 40.0, bottom: 20.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  materialButton(
                                    nameAction: S
                                        .of(context)
                                        .send,
                                    function: () =>
                                        _onSendMail(context, controller),

                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: materialButton(
                                      nameAction: S
                                          .of(context)
                                          .reboot,
                                      function: () => _onResetMail(context,controller),

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
      ),
    )
        : Scaffold(
      appBar: appBarAndroid(context, name: S
          .of(context)
          .sending_mails),
      body: const Text("creart email"),
    );
  }

  void _onMailChanged(Mail? mailChoose) {

    context.read<MailProvider>().select(mailChoose);
  }

  void _onDateSelect(String? dateChoose) {
    if (dateChoose == null) return;

    final lineProvider = context.read<LineSendProvider>();
    final factoryProvider = context.read<FactoryProvider>();

    final linesDay = lineProvider.getLines(date: dateChoose);

    final factoriesDay = lineProvider.getFactories(
        factories: factoryProvider.factories,
        lines: linesDay
    );

    setState(() {
      selectedSend = dateChoose;
      selectedFactories = factoriesDay;
    });
  }

  void _changeMailMode() {
    setState(() {
      if (!otherMail) {
        previousMail = controller.mail.text;
        previusPassword = controller.password.text;

        controller.mail.clear();
        controller.password.clear();
      } else {
        controller.mail.text = previousMail;
        controller.password.text = previusPassword;
      }

      otherMail = !otherMail;
    });
  }

  void _onOptionChanged(String? value) {
    if (value == null) return;

    setState(() {
      selectedOption = value;
    });
  }


  Future<void> _onSendMail(BuildContext context, MailController controller, ) async {

    final mailProvider = context.read<MailProvider>();
    final factoryProvider = context.read<FactoryProvider>();
    final lineProvider = context.read<LineSendProvider>();

               final recipients = selectedOption == S.of(context).a_recipient
                      ?[controller.mailTo!.text.trim()]
                      : selectedFactories
                               .map((f) => f.mail.trim())
                               .where((mail) => mail.isNotEmpty)
                               .toList();

                final errorMsg = SendMailValidator.validateAll(
                  context: context,
                  recipients: recipients,
                  mail: controller.mail.text,
                  password: controller.password.text,
                  mailTo: controller.mailTo?.text ?? '',
                  subject: controller.subject!.text ?? '',
                  message: controller.message!.text ?? '',
                  otherMail: otherMail,
                  isRecipient: selectedOption == S.of(context).a_recipient,
                );

              // 🔴 ERROR (no deja seguir)
                if (errorMsg.error != null) {
                  error(context, errorMsg.error!);
                  return;
                }

              // 🔴 WARNING (solo avisa)
                if (errorMsg.warnings.isNotEmpty) {
                  for (final warn in errorMsg.warnings) {
                    final accepted  = await warning(context, warn);
                    if (!accepted ) return;
                  }
                }

                final config = MailConfigurationService.fromMail(
                    otherMail
                          ? controller.mail.text.trim()
                          : mailProvider.selected!.mail
                );

                final mailConfiguration = config ?? await newMailConfiguration(context);


                if (mailConfiguration == null) return;

                Mail mail;

             if (otherMail)
             {
               final mailId = "0"; //ya el repositorio se encargara de asignarle el suyo

                   mail = MailConfigurationService.createMail(
                        id: mailId,
                        controllers: controller,
                        configuration: mailConfiguration,
                     );
             }
             else
             {
                mail = mailProvider.selected!;
             }

              if (otherMail) {
                mailProvider.select(mail);
              }

              final result = await _createMail(
                context,
                mailProvider,
                mail,
                recipients,
                controller
              );

               context.read<EditStateProvider>().clear();

               if(selectedOption != S.of(context).a_recipient)
              {
                      final sentFactories = result.sent
                          .map((mail) => factoryProvider.findByMail(mail)?.name)
                          .whereType<String>()
                          .toSet();

                      final failedFactories = result.failed
                          .map((e) => factoryProvider.findByMail(e.mail)?.name)
                          .whereType<String>()
                          .toSet();

                      await lineProvider.updateStates(
                          sentFactories: sentFactories,
                          failedFactories: failedFactories
                      );
              }


              if(result.sent.isNotEmpty)
              {
                   String action = LocalizationHelper.sendMails(context, result.sent.length);

                   await confirm(context, action);

                   if(otherMail)
                   {
                        action = S.of(context).do_you_want_to_save_the_account;
                        bool saveAccount  = await  warning(context, action);

                        if(saveAccount)
                        {
                           final resultCreate = await mailProvider.create(mail);

                           switch(resultCreate)
                           {
                             case CreateResult.success:
                               await confirm(context,S.of(context).mail_saved_successfully);
                               break;
                             case CreateResult.alreadyExists:
                               await error(context, S.of(context).mail_already_exists);
                               break;
                             case CreateResult.invalidData:
                               await error(context, S.of(context).invalid_data);
                               break;
                           }
                        }
                   }
              }

              if(result.failed.isNotEmpty)
              {
                    final errorsMails = result.failed
                        .map((e) => "${e.mail} : ${e.error}")
                        .toList();

                   await  showErrors(context, errorsMails);
              }

              await _onResetMail(context,controller);

             context.read<EditStateProvider>().clear();

  }

  Future <MailResult> _createMail (
      BuildContext context,
      MailProvider mailProvider,//aqui va el mensaje montaado
      Mail mail,
      List<String> recipients,
      MailController controller,
      ) async {

    final attachment = controller.attachments.map((file) {
       return MailAttachment(
           name: file.name,
           path: file.path,
           bytes: file.bytes,
       );
    }).toList();

    final mailMessage = MailMessage(
      recipients: recipients,
      subject: controller.subject!.text.trim(),
      message: controller.message!.text.trim(),
      attachments: attachment
    );

    return await mailProvider.send(
      mailMessage,
      account: mail,
      noAccountMessage: S.of(context).no_mail_account_selected,
    );

  }

  Future<void> _onResetMail(BuildContext context, MailController controllers) async {

    controllers.mail.text = "";
    controllers.password.text = "";
    controllers.mailTo!.text = "";
    controllers.subject!.text = "";
    controllers.message!.text = "";
    controllers.attachments.clear();

    context.read<EditStateProvider>().clear();

    setState(() {
      selectedOption = S
          .of(context)
          .a_recipient;

      selectedSend = null;
      selectedFactories.clear();
    });
  }
}

