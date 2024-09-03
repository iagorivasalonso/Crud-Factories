import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:flutter/material.dart';

Future<bool> typeConection (BuildContext  context,) async {

  bool tConnection  = await   showDialog(
      context: context,
      builder: (BuildContext context, ) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) => Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: SizedBox(
              width: 340,
              height: 175,
              child: Column(
                children: [
                  headAlert(title:"Tipo de fuente"),
                  const Padding(
                    padding:  EdgeInsets.only(left: 30,top: 25, bottom: 35),
                    child: Row(
                      children: [
                        Text("¿Que tipo de base de datos desea utilizar?")
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 90, right: 15),
                        child: MaterialButton(
                            child: const Text("SQL",style: const TextStyle(color: Colors.white),),
                            color: Colors.lightBlue,
                            onPressed:() async {
                              Navigator.of(context).pop(true);
                            }
                        ),
                      ),
                      MaterialButton(
                          child: const Text("CSV",style: const TextStyle(color: Colors.white),),
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


  return tConnection;
}

