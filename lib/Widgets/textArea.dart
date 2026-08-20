
import 'package:crud_factories/Backend/Providers/EditStateProvider.dart' show EditStateProvider;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Row textArea({
  required BuildContext context,
  required String nameCamp,
  required String campOld,
  required TextEditingController controllerCamp,
  bool? automatic = false,
}){

  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 10.0,left: 10.0),
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
          controller: controllerCamp,
          style: TextStyle(color: automatic == true ? Colors.grey: Colors.black),
          decoration: InputDecoration(
            filled: true,
            fillColor:  Colors.white,
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
          onChanged: (s) {

            if (campOld != null && campOld.isNotEmpty) {
              context.read<EditStateProvider>().markChanged();
            } else {
              context.read<EditStateProvider>().clear();
            }
          },
        ),
      )
    ],
  );
}
