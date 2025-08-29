import 'package:flutter/material.dart';

Padding textfieldPassword({
  required String nameCamp,
  required TextEditingController controllerCamp,
}){

  return  Padding(
    padding: const EdgeInsets.only(left: 30.0, top: 20.0, bottom: 30.0,right: 90.0),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Text(nameCamp),
        ),
        Expanded(
          child: SizedBox(
            width: 40,
            child: TextField(
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}