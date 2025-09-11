import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:flutter/material.dart';

Row textArea({
  required String nameCamp,
  required String campOld,
  required TextEditingController controllerCamp,
}){

  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: SizedBox(
          width: 100,
          child: Text(nameCamp),
        ),
      ),
      SizedBox(
        width: 500,
        child: TextField(
          minLines: 6,
          maxLines: 20,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          controller: controllerCamp,
          onChanged: (s) {
            if (campOld.isNotEmpty) {
              saveChanges = controllerCamp.text != campOld;
            } else {
              saveChanges = controllerCamp.text.isNotEmpty;
            }
          },
        ),
      )
    ],
  );
}
