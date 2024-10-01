import 'package:crud_factories/Backend/CSV/exportLines.dart';
import 'package:crud_factories/Backend/CSV/exportSectors.dart';
import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Objects/Sector.dart';
import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:flutter/material.dart';


Future<String> createSector(BuildContext  context) async {

  late TextEditingController controllerSector = TextEditingController();

  String sector = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) => Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: SizedBox(
              width: 350,
              height: 230, // 175,
              child: Column(
                children: [
                  headAlert(title:"Creacion del sector"),
                  Padding(
                    padding: const EdgeInsets.only(left: 30,top: 25, bottom: 30),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Text('Nombre del sector:'),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15,left: 40),
                              child: SizedBox(
                                width: 180,
                                height: 40,
                                child: TextField(
                                  controller: controllerSector,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),

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
                            Navigator.of(context).pop(controllerSector.text);
                           // Navigator.of(context).pop(false);
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
     return sector;
}

