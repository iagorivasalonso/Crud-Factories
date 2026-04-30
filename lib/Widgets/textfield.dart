import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:flutter/material.dart';

Padding defaultTextfield({
  required String nameCamp,
  String? campOld,
  required TextEditingController controllerCamp,
  FocusNode? focusNode,
  bool? automatic = false,
  bool? campEdit,
  ValueChanged<String>? onChanged,
}){

  return Padding(
    padding: const EdgeInsets.only(left: 35.0, top: 20.0,right: 40.0),
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
              focusNode: focusNode,
              onTapOutside: (_) {
                focusNode?.unfocus();
              },
              enabled: campEdit ?? true,
              controller: controllerCamp,
              style: TextStyle(color: automatic == true ? Colors.grey: Colors.black),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              ),
              onChanged: (value) {
                // 👉 SI el padre manda lógica, la usamos
                if (onChanged != null) {
                  onChanged(value);
                  return;
                }

                // 👉 SI NO, usamos lógica interna (fallback)
                if (campOld != null && campOld.isNotEmpty) {
                  saveChanges = value != campOld;
                } else {
                  saveChanges = value.isNotEmpty;
                }
              },
            ),
          ),
        ),
      ],
    ),
  );


}

