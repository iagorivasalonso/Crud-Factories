import 'package:crud_factories/Backend/Feature/Mail/Service/mailConfiguration.dart' show MailConfiguration;
import 'package:crud_factories/Widgets/genericSwitch.dart';
import 'package:crud_factories/Widgets/headAlertDialog.dart' show headDialog;
import 'package:crud_factories/Widgets/materialButton.dart';
import 'package:crud_factories/Widgets/textfield.dart' show defaultTextfield;
import 'package:crud_factories/generated/l10n.dart' show S;
import 'package:flutter/material.dart';

Future<MailConfiguration?> newMailConfiguration (BuildContext context) async {

  final companyController = TextEditingController();
  final hostController = TextEditingController();
  final portController = TextEditingController();

  bool secure = true;

  void createConfig() {

    final configuration = MailConfiguration(
        company: companyController.text.trim(),
        host: hostController.text.trim(),
        port: portController.text.trim(),
        secure: secure
    );

    Navigator.pop(context,configuration);
  }

  final MailConfiguration? miConfiguration = await showDialog<MailConfiguration>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return StatefulBuilder(
            builder: (context,setState) {
              return Dialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: 450,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        headDialog(title:  S.of(context).new_smtp_configuration),
                        defaultTextfield(
                            nameCamp: S.of(context).company,
                            controllerCamp: companyController,
                            context: context
                        ),

                        defaultTextfield(
                            nameCamp: S.of(context).smtp_host,
                            controllerCamp: hostController,
                            context: context
                        ),

                        defaultTextfield(
                            nameCamp: S.of(context).port,
                            controllerCamp: portController,
                            context: context
                        ),

                        GenericSwitch(
                            text: S.of(context).secure_connection,
                            value: secure,
                            onChanged: (value) {
                                setState(() {
                                  secure = value;
                                });
                          },
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 35.0, top: 15.0,right: 40.0, bottom: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: materialButton(
                                  nameAction: S.of(context).acept,
                                  function: createConfig,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: materialButton(
                                  nameAction: S.of(context).cancel,
                                  function: () => Navigator.pop(context),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
        );
      }
  );

  companyController.dispose();
  hostController.dispose();
  portController.dispose();

  return miConfiguration;
}


