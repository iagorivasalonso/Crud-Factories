

import 'package:flutter/material.dart';

MaterialButton materialButton({
  required String nameAction,
  required Future<void> Function() function,

}){

  return   MaterialButton(
      color: Colors.lightBlue,
      child: Text(nameAction,
      style: const TextStyle(
      color: Colors.white)
  ),
  onPressed: () async {
    await function();

  }
  );
}
