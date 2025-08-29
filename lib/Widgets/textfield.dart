import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:flutter/material.dart';

Padding defaultTextfield({
  required String nameCamp,
  required String campOld,
  required TextEditingController controllerCamp,
}){

  return Padding(
    padding: const EdgeInsets.only(left: 35.0, top: 20.0, bottom: 30.0, right: 90.0),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: SizedBox(
            width: 100,
            child: Text(nameCamp),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 40,
            child: TextField(
              controller: controllerCamp,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              onChanged: (s) {
                if (campOld.isNotEmpty) {
                  saveChanges = controllerCamp.text != campOld;
                } else {
                  saveChanges = controllerCamp.text.isNotEmpty;
                }
              },
            ),
          ),
        ),
      ],
    ),
  );
}
