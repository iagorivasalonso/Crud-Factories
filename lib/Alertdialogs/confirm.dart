import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:flutter/material.dart';


 void confirm(BuildContext  context, String action) async {

   showDialog(
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
                  headAlert(title:"Confirmar"),
                  Padding(
                    padding:  EdgeInsets.only(left: 30,top: 25, bottom: 35),
                    child: Row(
                      children: [
                        Text('$action '),

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
                            Navigator.of(context).pop(" ");
                          //  Navigator.of(context).pop(false);
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

}


