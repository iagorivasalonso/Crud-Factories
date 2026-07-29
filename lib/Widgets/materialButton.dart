import 'package:flutter/material.dart';

MaterialButton materialButton({
  String? nameAction,
  Widget? icon,
  required VoidCallback  function,

}){

  return   MaterialButton(
    color: Colors.lightBlue,
    onPressed: function,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          IconTheme(
            data: const IconThemeData(color: Colors.white),
            child: icon,
          ),
          const SizedBox(width: 8),
        ],
        if (nameAction != null)
          Flexible(
            child: Text(
              nameAction,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
      ],
    ),
  );
}


