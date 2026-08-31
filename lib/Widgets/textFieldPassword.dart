import 'package:crud_factories/Backend/Providers/EditStateProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Padding textfieldPassword({
  required String nameCamp,
  String? campOld,
  required TextEditingController controllerCamp,
  bool? campEdit,
  bool obscureText = true,
  BuildContext? context,

}){

  return  Padding(
    padding: const EdgeInsets.only(left: 35.0, top: 20.0,right: 40.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
              obscureText: obscureText,
              controller: controllerCamp,
              decoration: InputDecoration(
                filled: true,
                fillColor: campEdit == false
                    ? Colors.grey.shade200
                    : Colors.white,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.blue.shade300,
                    width: 1.2,
                  ),
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.blue.shade600,
                    width: 2,
                  ),
                ),

                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
              ),
              onChanged: (value) {

                 if(context == null) return;

                  final changed = (campOld ?? '') != controllerCamp.text;

                  if (changed) {
                    context.read<EditStateProvider>().markChanged();
                  } else {
                    context.read<EditStateProvider>().clear();
                  }
              },
            ),
          ),
        ),
      ],
    ),
  );
}
