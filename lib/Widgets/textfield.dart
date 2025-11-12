import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:flutter/material.dart';

Padding defaultTextfield({
  required String nameCamp,
  String? campOld,
  required TextEditingController controllerCamp,
  bool? campEdit,
}){

  return Padding(
    padding: const EdgeInsets.only(left: 35.0, top: 20.0,right: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if(nameCamp.isNotEmpty)
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: SizedBox(
            width: 100,
            child: Text(
              nameCamp,
            ),
            ),
          ),

        Expanded(
          child: SizedBox(
            height: 40,
            child: TextField(
              enabled: campEdit,
              controller: controllerCamp,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              ),
              onChanged: (s) {
                if (campOld?.isNotEmpty ?? false) {
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

