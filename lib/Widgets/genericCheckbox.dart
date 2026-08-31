
import 'package:flutter/material.dart';

Widget genericCheckbox({
  required String text,
  required bool value,
  required ValueChanged<bool?> onChanged,
}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Checkbox(
        value: value,
        onChanged: onChanged,
      ),
      const SizedBox(width: 4),
      Text(text),
    ],
  );
}