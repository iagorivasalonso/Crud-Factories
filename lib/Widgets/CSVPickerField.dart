
import 'package:crud_factories/Widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'materialButton.dart';

class CSVPickerField extends StatefulWidget {

  final TextEditingController controller;
  final String campName;
  final String actionName;
  final Future<void> Function() function;
  final bool automatic;



  const CSVPickerField({
    super.key,
    required this.controller,
    required this.campName,
    required this.actionName,
    required this.function,
    this.automatic = false,

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
    bool automatic = widget.automatic;


    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 3.0),
            child: defaultTextfield(
              nameCamp: campName,
              controllerCamp: controllerImportPicker,
              automatic: automatic
            ),
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



