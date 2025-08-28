import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:flutter/material.dart';

Padding defaultTextfield({
  required String nameCamp,
  required String oldCamp,
  required TextEditingController controllerCamp,
}){

  return  Padding(
    padding: const EdgeInsets.only(
        left: 30, top: 20.0, bottom: 30.0),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Text(nameCamp),
        ),
        SizedBox(
          width: 450,
          height: 40,
          child: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            onChanged: (s){
              if(saveChanges == false)
              {
                if(oldCamp.isNotEmpty)
                {
                  if(controllerCamp == oldCamp)
                  {
                    saveChanges = false;
                  }
                  else
                  {
                    saveChanges = true;
                  }
                }
                else
                {
                  if(controllerCamp.text.isEmpty)
                  {
                    saveChanges = false;
                  }
                  else
                  {
                    saveChanges = true;
                  }
                }

              }
            },
          ),
        ),
      ],
    ),
  );
}
