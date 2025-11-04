
import 'dart:convert';
import 'dart:io';

import 'package:crud_factories/Widgets/textfield.dart';
import 'package:file_picker/file_picker.dart' show FilePickerResult, FileType, FilePicker;
import 'package:flutter/material.dart';
import '../Alertdialogs/error.dart';
import '../Backend/CSV/importConections.dart';
import '../Backend/CSV/importEmpleoyes.dart';
import '../Backend/CSV/importFactories.dart';
import '../Backend/CSV/importLines.dart';
import '../Backend/CSV/importMails.dart';
import '../Backend/CSV/importRoutes.dart';
import '../Backend/CSV/importSectors.dart';
import '../Backend/Global/controllers/List.dart';
import '../Backend/Global/variables.dart';
import '../generated/l10n.dart';
import 'materialButton.dart';

class CSVPickerField extends StatefulWidget {

  final TextEditingController controller;
  final ListController listController;
  final String campName;
  final String actionName;


   const CSVPickerField({
    super.key,
    required this.controller,
    required this.listController,
    required this.campName,
    required this.actionName,

  });

  @override
  State<CSVPickerField> createState() => _CSVPickerFieldState();
}



class _CSVPickerFieldState extends State<CSVPickerField> {

  @override
  Widget build(BuildContext context0) {

    BuildContext context = Platform.isWindows ? context1 : context0;
    TextEditingController controllerImportPicker  = widget.controller;
    ListController listController = widget.listController;
    String campName = widget.campName;
    String action = widget.actionName;


    return Row(
      children: [
        Expanded(
          child: defaultTextfield(
              nameCamp: campName,
              controllerCamp:  controllerImportPicker
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: materialButton(
            nameAction: action,
            function: () =>_pickFile(context, controllerImportPicker, listController),
          ),
        ),
      ],
    );
  }
}


Future<void> _pickFile(BuildContext context, TextEditingController controllerImportPicker, ListController listController) async {


  FilePickerResult? result =  await FilePicker.platform.pickFiles(
    dialogTitle: S.of(context).select_file,
    type: FileType.custom,
    allowedExtensions: ['csv'],
  );

  if(result == null) return;

  final file = File(result.files.single.path!);


  controllerImportPicker.text =file.path!;

  final content = await file.readAsString(encoding: utf8);
  final linesSend = const LineSplitter().convert(content);


  try{
    final parts = linesSend.first.split(";");
    switch(parts.length)
    {
      case 2:
        listController.sectorsNew.addAll(await readSectorsFromCsv(file));
        break;

      case 3:
        if(file.path.contains('routes.csv'))
        {

          listController.routesNew.addAll(await readRoutesFromCsv(file));
        }
        else
        {
          listController.empleoyesNew.addAll(await readEmpleoyeFromCsv(file));
        }
        break;

      case 4:
        listController.mailsNew.addAll(await readMailsFromCsv(file));
        break;

      case 5:
        listController.linesNew.addAll(await readLinesFromCsv(file));
        break;

      case 6:
        listController.conectionsNew.addAll(await readConectionsFromCsv(file));
        break;

      case 14:
        listController.factoriesNew.addAll(await readFactoriesFromCsv(file));
        break;

      default:
        String action = S.of(context).file_not_found;
        error(context, action);
        break;
    }
  }catch (e) {
    error(context, S.of(context).file_not_found);
  }

}
