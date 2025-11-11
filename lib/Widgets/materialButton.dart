

import 'package:flutter/material.dart';

MaterialButton materialButton({
  String? nameAction,
  Widget? icon,
  required Future<void> Function() function,

}){

  return  MaterialButton(
      color: Colors.lightBlue,
      child: Row(
        mainAxisSize: MainAxisSize.min, //
        children: [
          if (icon != null)
            nameAction == null
                ? IconTheme(
              data: const IconThemeData(color: Colors.white),
              child: icon!,
            )
                : icon!,
          if (icon != null && nameAction != null) const SizedBox(width: 8),
          if (nameAction != null)
          Text(nameAction!,
          style: const TextStyle(
          color: Colors.white),
            ),
        ],
      ),
  onPressed: () async {
    await function();

  }
  );
}


