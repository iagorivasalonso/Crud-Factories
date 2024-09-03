import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:flutter/material.dart';


 Future<bool> confirmEdit(BuildContext  context, String action) async {

  bool regisEdit = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) => Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: SizedBox(
              width: 350,
              height: 175,
              child: Column(
                children: [
                  headAlert(title:"Editado"),
                  Padding(
                    padding:  const EdgeInsets.only(left: 30,top: 25, bottom: 35),
                    child: Row(
                      children: [
                        Text("La $action fue editada correctamente"),

                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                          child: const Text("Aceptar",style: const TextStyle(color: Colors.white),),
                          color: Colors.lightBlue,
                          onPressed:(){
                            Navigator.of(context).pop(false);
                          }
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      });

  return regisEdit;
}


