import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:flutter/material.dart';

void adminRoutes(BuildContext context) {

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 80.0),
          child: StatefulBuilder(
             builder: ((BuildContext context, void Function(void Function()) setState) => Dialog(
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
               child: SizedBox(
                 height: 400,
                 width: 500,
                 child: Column(
                   children: [
                     headAlert(title:"Selector de rutas"),
                   SizedBox(
                     height: 300,
                     width: 500,
                     child: Padding(
                       padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                       child: ListView.builder(
                         itemCount: routesManage.length,
                         itemBuilder: (BuildContext context, int index) {
                           return Padding(
                             padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                             child: Row(
                               children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 18.0),
                                          child: Text(
                                              routesManage[index].name,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                        ),
                                      ),
                                     const Expanded(
                                        flex: 3,
                                        child: TextField(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 18.0),
                                          child: MaterialButton(
                                            color: Colors.lightBlue,
                                            onPressed: () async {
                                              setState(() {

                                              });
                                            },
                                            child: const Text(
                                              "Examinar",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),


                               ],
                             ),
                           );
                         },
                       ),
                     ),
                   ),

                   Expanded(
                       child: Row(
                         children: [
                           Expanded(
                             child: Padding(
                               padding: const EdgeInsets.only(left: 140, right: 15),
                               child: MaterialButton(
                                   color: Colors.lightBlue,
                                   onPressed:() async {

                                   },
                                   child: const Text("Importar",style:  TextStyle(color: Colors.white),)
                               ),
                             ),
                           ),
                           Expanded(
                             child: Padding(
                               padding: const EdgeInsets.only(left: 15, right: 140),
                               child: MaterialButton(
                                   color: Colors.lightBlue,
                                   onPressed:(){

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
               )
             )),
          ),
        ),
      );
    },
  );
}

