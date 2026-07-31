import 'package:crud_factories/Alertdialogs/confirm.dart' show confirm;
import 'package:crud_factories/Backend/Providers/ImportProvaider.dart';
import 'package:crud_factories/Backend/Providers/SectorProvider.dart' show SectorProvider;
import 'package:crud_factories/Widgets/headViewsAndroid.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:crud_factories/helpers/localization_helper.dart' show LocalizationHelper;
import 'package:flutter/material.dart';
import 'package:crud_factories/Functions/isNotAndroid.dart';
import 'package:crud_factories/Widgets/CSVPickerField.dart';
import 'package:crud_factories/Widgets/headView.dart';
import 'package:crud_factories/Widgets/materialButton.dart';
import 'package:provider/provider.dart';

import '../Alertdialogs/error.dart';

class NewImport extends StatefulWidget {


  const NewImport({super.key});

  @override
  State<NewImport> createState() => _NewImportState();
}

class _NewImportState extends State<NewImport> {

  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();

  late TextEditingController controllerImportPicker = TextEditingController();

  @override
  void initState (){
    super.initState();

  }

  @override
  void dispose() {
    controllerImportPicker.dispose();
    horizontalScroll.dispose();
    verticalScroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final provaiderImport = context.read<ImportProvaider>();

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
                      width: 680,
                      child: Column(
                        children: [
                          headView(
                              title: S.of(context).import_data
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top:10.0,bottom: 30.0),
                            child: Row(
                              children: [
                                Text(S.of(context).Import_data_in_CSV_format)
                              ] ,
                            ),
                          ),

                              SizedBox(
                                width: 700,
                                child: CSVPickerField(
                                    controller: controllerImportPicker,
                                    campName: S.of(context).route,
                                    actionName: S.of(context).examine,
                                    function: () => provaiderImport.pickFile(context, controllerImportPicker),
                                ),
                              ),

                             Padding(
                                padding: const EdgeInsets.only(left: 450.0, top: 260.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    materialButton(
                                        nameAction: S.of(context).import_data,
                                        function: () => _onSaveList(context)
                                    ),

                                   Padding(
                                        padding: const EdgeInsets.only(left: 20.0),
                                        child: materialButton(
                                          nameAction:S.of(context).delete,
                                          function: () => _onClear(context)

                                        ),
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
      appBar: appBarAndroid(context, name: S.of(context).sending_mails),
      body: Text("creart email"),
    );

  }
  Future<void> _onSaveList(BuildContext context) async {

    final providerImport = context.read<ImportProvaider>();

    final results = await providerImport.importAll(
      context: context,
    );

    final success = results
        .where((r) => r.inserted > 0)
        .toList();

    if (success.isNotEmpty) {

      final message = success
          .map((e) => LocalizationHelper.importData(
        context,
        e.entity,
        e.inserted,
      ))
          .join('\n');

      confirm(context, message);
    }
    else
    {
      error(context,S.of(context).no_new_data_to_import);
    }

  }


  Future<void> _onClear (BuildContext context) async {

    final providerImport = context.read<ImportProvaider>();

    providerImport.clear();

    setState(() {
      controllerImportPicker.clear();
    });
  }
}





