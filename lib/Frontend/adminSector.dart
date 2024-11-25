import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Alertdialogs/create%20sector.dart';
import 'package:crud_factories/Alertdialogs/warning.dart';
import 'package:crud_factories/Backend/CSV/exportSectors.dart';
import 'package:crud_factories/Backend/SQL/deleteSector.dart';
import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:flutter/material.dart';


Future<void> adminSector(BuildContext context) async {

  double mWidth = 400;

  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) => Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: SizedBox(
              width: mWidth,
              height: 350,
              child: Row(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: mWidth,
                          child: headAlert(title:"Manejo Sectores")),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: SizedBox(
                                    width: 300,
                                    height: 200,
                                    child: ListView.builder(
                                      itemCount: sectors.length,
                                      itemBuilder: (BuildContext context, int index) {
                                         return ListTile(
                                           title: Text(sectors[index].name),
                                           trailing: Row(
                                             mainAxisSize: MainAxisSize.min,
                                             children: [
                                               IconButton(
                                                 icon: Icon(Icons.edit, color: Colors.blue),
                                                 onPressed: () async {
                                                      String modif = sectors[index].name;
                                                      bool? create = await createSector(context,modif);

                                                      if (create == true)
                                                      {
                                                        setState(() {});
                                                        String action = 'El sector se ha editado correctamente';
                                                        confirm(context, action);
                                                      }

                                                  },
                                               ),
                                               IconButton(
                                                 icon: Icon(Icons.delete, color: Colors.red),
                                                 onPressed: () async {

                                                     String action1 = "¿Realmente desea eliminar el sector?";
                                                     bool  correct = await warning(context, action1);
                                                     String search = sectors[index].name;
                                                     String idSupr = "";

                                                       for (int i = 0; i <sectors.length; i++)
                                                       {
                                                         if(search == sectors[i].name)
                                                         {
                                                           idSupr = sectors[i].id;

                                                         }
                                                       }

                                                      if(correct)
                                                      {
                                                        if(sectors.length==1)
                                                        {
                                                          Navigator.of(context).pop(false);
                                                        }
                                                         setState((){
                                                           sectors.removeAt(index);
                                                           String action = 'El sector se ha quitado correctamente';
                                                           confirm(context, action);
                                                         });
                                                      }


                                                      if(conn != null)
                                                      {
                                                        sqlDeleteSector(idSupr);
                                                      }
                                                      else
                                                      {
                                                        csvExportatorSectors(sectors);
                                                      }


                                                 },
                                               ),
                                             ],
                                           ),
                                         );
                                      },

                                  ),
                                ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 25.0,top: 13.0),
                                child: SizedBox(
                                    width: 200,
                                    height: 70,
                                    child:Row(
                                      children: [
                                        MaterialButton(
                                          child: const Text("crear",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          color: Colors.lightBlue,
                                          onPressed: () async {

                                                String modif = "nuevo";
                                                bool create = await createSector(context,modif);

                                                if(create == true)
                                                {
                                                    setState((){
                                                      String action = 'El sector se ha creado correctamente';
                                                      confirm(context, action);
                                                    });
                                                }

                                          },

                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 22.0),
                                          child: MaterialButton(
                                            color: Colors.lightBlue,
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                            },
                                            child: const Text("Cerrar",
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                ),
                              ),

                            ],
                          ),

                            ]
                          )
                        ],
                      ),
                    ],
                  ),

              ),
            ),
        );
      });


}