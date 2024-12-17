import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:flutter/material.dart';


Future<int> noCategory(BuildContext  context, String array) async {

  int? dato = await showDialog(
      context: context,
      builder: (BuildContext context) {
       return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) => Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: SizedBox(
              width: 450,
              height: 175,
              child: Column(
                children: [
                  headAlert(title:"Error categoria"),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25,right: 15 ,top: 25, bottom: 15),
                      child: Text('No tiene $array  en la base de datos ¿Que desea hacer?',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: MaterialButton(
                                color: Colors.lightBlue,
                                onPressed:() async {
                                  Navigator.of(context).pop(1);
                                },
                                child: const Text("Crear",style: TextStyle(color: Colors.white),)
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: MaterialButton(
                                color: Colors.lightBlue,
                                onPressed:(){
                                  Navigator.of(context).pop(2);
                                },
                                child: const Text("Importar",style: TextStyle(color: Colors.white),)
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:const EdgeInsets.only(left: 25, right: 25),
                            child: MaterialButton(
                                color: Colors.lightBlue,
                                onPressed:(){
                                  Navigator.of(context).pop(3);
                                },
                                child: const Text("Cancelar",style: TextStyle(color: Colors.white),)
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
  return  dato ?? -3;
}


