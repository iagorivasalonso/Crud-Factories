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

      final screenWith = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;

      return StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState) => Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          child: SizedBox(
            width: mWidth,
            height: 350,
            child: Column(
              children: [
                headAlert(title: "Manejo Sectores"),
                if(screenHeight>105.0)
                const SizedBox(height: 60),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                    child: ListView.builder(
                      itemCount: sectors.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(sectors[index].name),
                          trailing: screenWith > 330.0
                              ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () async {
                                  String modif = sectors[index].name;
                                  bool? create = await createSector(context, modif);

                                  if (create == true) {
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
                                  bool correct = await warning(context, action1);
                                  String search = sectors[index].name;
                                  String idSupr = "";

                                  if (correct)
                                  {

                                    if (sectors.length == 1)
                                    {
                                      Navigator.of(context).pop(false);
                                    }

                                    setState(() {
                                      sectors.removeAt(index);
                                      String action = 'El sector se ha quitado correctamente';
                                      confirm(context, action);
                                    });
                                  }

                                  if (conn != null)
                                  {

                                    for (int i = 0; i < sectors.length; i++)
                                    {
                                      if (search == sectors[i].name)
                                      {
                                        idSupr = sectors[i].id;
                                      }
                                    }

                                    sqlDeleteSector(idSupr);
                                  }
                                  else
                                  {
                                     csvExportatorSectors(sectors);
                                  }
                                },
                              ),
                            ],
                          )
                              : null,
                        );
                      },
                    ),
                  ),
                ),
               Expanded(
                 child: Padding(
                               padding: const EdgeInsets.only(left: 30.0, right: 10.0,top: 44),
                 child: Row(
                   children: [
                     Expanded(
                       child: Padding(
                         padding: const EdgeInsets.only(left: 70, right: 15),
                         child: MaterialButton(
                           color: Colors.lightBlue,
                           child: const Text(
                             "Crear",
                             style: TextStyle(color: Colors.white),
                           ),
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
                             "Cerrar",
                             style: TextStyle(color: Colors.white),
                           ),
                         ),
                       ),
                     ),
                   ],
                 ),
                             ),
               )
              ],
            ),
          ),
        ),
      );
    },
  );



}