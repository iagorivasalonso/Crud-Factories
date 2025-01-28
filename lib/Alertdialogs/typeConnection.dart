import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:flutter/material.dart';

Future<bool> typeConection (BuildContext  context) async {

  bool? tConnection  = await   showDialog(
      context: context,
      barrierDismissible: true,
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
                  const Expanded(
                    child: Padding(
                      padding:  EdgeInsets.only(left: 25,top: 25, bottom: 15),
                      child: Text("¿Que tipo de base de datos desea utilizar?",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,),
                    ),
                  ),

                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 70, right: 15),
                            child: MaterialButton(
                                color: Colors.lightBlue,
                                onPressed:() async {
                                  Navigator.of(context).pop(true);
                                },
                                child: const Text("SQL",style:  TextStyle(color: Colors.white),)
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5, right: 78),
                            child: MaterialButton(
                                color: Colors.lightBlue,
                                onPressed:(){
                                  Navigator.of(context).pop(false);
                                },
                                child: const Text("CSV",style: TextStyle(color: Colors.white),)
                            ),
                          ),
                        ),

                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );

      });


  return tConnection ?? false;
}

