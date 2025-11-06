
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
  final String campName;
  final String actionName;
  final Future<void> function;


   const CSVPickerField({
    super.key,
    required this.controller,
    required this.campName,
    required this.actionName,
    required this.function ,

  });

  @override
  State<CSVPickerField> createState() => _CSVPickerFieldState();
}



class _CSVPickerFieldState extends State<CSVPickerField> {

  @override
  Widget build(BuildContext context0) {


    TextEditingController controllerImportPicker  = widget.controller;
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
            function: () => widget.function,
          ),
        ),
      ],
    );
  }
}



