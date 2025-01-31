import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';


void closeAlert(BuildContext  context) {

  showDialog(
      context: context,
      builder: (BuildContext context, ) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) => Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
              child: SizedBox(
                width:  50,
                height: 175,
                child: Column(
                  children: [
                   headAlert(title:"Salida de la aplicación"),
                    Expanded(child: Padding(
                      padding: EdgeInsets.only(left: 25,top: 25, bottom: 15),
                      child: Text("¿Desea salir de la aplicacion?",
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
                              child: const Text(
                                "Si",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                Navigator.of(context).pop(false);
                                await windowManager.destroy();
                              },
                            ),
                          ),
                        ),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5, right: 70),
                            child: MaterialButton(
                              color: Colors.lightBlue,
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              child: const Text(
                                "No",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                          ],
                        ),
                  ),
             ]
              )
          ),
          ),
        );

      });
}





