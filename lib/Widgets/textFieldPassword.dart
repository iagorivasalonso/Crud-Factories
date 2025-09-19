import 'package:flutter/material.dart';

Padding textfieldPassword({
  required String nameCamp,
  required TextEditingController controllerCamp,
  bool? campEdit,
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
              obscureText: true,
              controller: controllerCamp,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}