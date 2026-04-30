
import 'package:crud_factories/Backend/Providers/RoutesProvider.dart' show RoutesProvider;
import 'package:crud_factories/Widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'materialButton.dart';

class CSVPickerField extends StatelessWidget {
  final String value;
  final String campName;
  final String actionName;
  final ValueChanged<String> onChanged;
  final Future<void> Function() function;
  final bool automatic;
  final int index;

  const CSVPickerField({
    super.key,
    required this.value,
    required this.campName,
    required this.actionName,
    required this.onChanged,
    required this.function,
    required this.index,
    this.automatic = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 3.0),
            child: defaultTextfield(
              nameCamp: campName,
              controllerCamp: TextEditingController(text: value),
              automatic: automatic,
              onChanged: (v) => onChanged(v),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: materialButton(
            nameAction: actionName,
            function: () async => await function(),
          ),
        ),
      ],
    );
  }
}



