
import 'package:crud_factories/Widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'materialButton.dart';

class CSVPickerField extends StatefulWidget {

  final TextEditingController controller;
  final String campName;
  final String actionName;
  final Future<void> Function() function;



   const CSVPickerField({
    super.key,
    required this.controller,
    required this.campName,
    required this.actionName,
    required this.function,


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
            function: () async => await widget.function(),
          ),
        ),
      ],
    );
  }
}



