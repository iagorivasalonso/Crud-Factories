import 'package:flutter/material.dart';

MaterialButton materialButton({
  String? nameAction,
  Widget? icon,
  required VoidCallback function,
}) {
  return MaterialButton(
    color: Colors.lightBlue,
    onPressed: function,
    padding: icon != null ? EdgeInsets.zero : null,
    minWidth: icon != null ? 0 : 88,
    child: icon != null
        ? Center(
      child: IconTheme(
          data: const IconThemeData(color: Colors.white),
          child: icon
      ),
    )
        : Text(
      nameAction ?? '',
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
  );
}
