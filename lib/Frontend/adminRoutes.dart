import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Backend/CSV/chargueData%20csv.dart';
import 'package:crud_factories/Backend/CSV/exportRoutes.dart';
import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Objects/RouteCSV.dart';
import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

Future<bool> adminRoutes(BuildContext context, [bool? sqlBd]) async {

  List<TextEditingController> _controllerNameRoute = [];
  List<TextEditingController> _controllerRoute = [];

  bool onlySql = false;

  if(sqlBd == true)
  {
    onlySql = true;
  }

  if(onlySql == false)
  {
    currentRoutes = allRoutes;
  }
  else
  {
     currentRoutes = SQLRoutes;
  }

  for(int i = 0; i <allRoutes!.length; i++)
  {
    _controllerNameRoute.add(TextEditingController());
    _controllerRoute.add(TextEditingController());
  }

  if(routesManage.isEmpty)
  {
    for(int i = 0; i <allRoutes.length; i++)
    {
      _controllerNameRoute[i].text = allRoutes[i];

         if(i == 0)
         {
            String tmp = fRoutes.toString();
            List<String> partRoute = tmp.split("\'");
            _controllerRoute[i].text = partRoute[1];
         }
         else
         {
           _controllerRoute[i].text = " ";
         }

    }
  }
  else
  {
    campCharge(_controllerNameRoute,_controllerRoute);
  }

  bool? ruta = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
         builder: ((BuildContext context, void Function(void Function()) setState) => Dialog(
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
           child: SingleChildScrollView(
             child: SizedBox(
               height: 500,
               width: 500,
               child: Column(
                 children: [
                   headAlert(title:"Selector de rutas"),
                 Expanded(
                     child: Align(
                       alignment: Alignment.topLeft,
                       child: Padding(
                         padding: const EdgeInsets.only(top: 40.0),
                         child: SizedBox(
                           width: 310,
                           child: Row(
                             children: [
                               const Expanded(
                                 flex:2,
                                 child: Padding(
                                   padding: const EdgeInsets.only(left: 40.0),
                                   child: Text("Fuente",
                                     maxLines: 1,
                                     overflow: TextOverflow.ellipsis,
                                   ),
                                 ),
                               ),
                               Expanded(
                                 flex: 1,
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                    const Expanded(
                                       child: Text("Todas",
                                         maxLines: 1,
                                         overflow: TextOverflow.ellipsis,
                                       ),
                                     ),
                                     Expanded(
                                       child: Radio(
                                           value: false,
                                           groupValue: onlySql,
                                           onChanged: (value) {
                                             setState(() {
                                               onlySql = false;
                                               currentRoutes = allRoutes;
                                             });
                                           }),
                                     ),
                                   ],
                                 ),
                               ),
                               Expanded(
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     const Expanded(
                                       child: Padding(
                                         padding: EdgeInsets.only(left: 10),
                                         child: Text("SQL",
                                           maxLines: 1,
                                           overflow: TextOverflow.ellipsis,
                                         ),
                                       ),
                                     ),
                                     Expanded(
                                       child: Radio(
                                           value: true,
                                           groupValue: onlySql,
                                           onChanged: (value) {
                                             setState(() {
                                               onlySql = true;
                                               currentRoutes = SQLRoutes;
                                             });
                                           }),
                                     ),
                                   ],
                                 ),
                               ),
                             ],
                           ),
                         ),
                       ),
                     )
                 ),
                 Row(
                   children: [
                     Expanded(
                       child: SizedBox(
                         height: 300,
                         width: 500,
                         child: Padding(
                           padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                           child: ListView.builder(
                             itemCount: currentRoutes.length,
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
                                                  _controllerNameRoute[index].text,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                            ),
                                          ),
                                         Expanded(
                                            flex: 3,
                                            child: TextField(
                                              controller: _controllerRoute[index],
                                              decoration: const InputDecoration(
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
                                                    _pickFile(_controllerRoute[index]);
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
                     ),
                   ],
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
                                   List<RouteCSV> routesNew = [];

                                    int idNew = -1;

                                    for(int i = 0; i < currentRoutes.length; i++)
                                    {
                                      idNew = i + 1;

                                      routesNew.add(RouteCSV(
                                          id: idNew.toString(),
                                          name: _controllerNameRoute[i].text,
                                          route: _controllerRoute[i].text
                                      ));
                                    }

                                      String action = 'Las rutas se han guardado correctamente';
                                      await confirm(context, action);
                                      chargueDataCSV();
                                      csvExportatorRoutes(routesNew);


                                      setState((){
                                       Navigator.of(context).pop(true);
                                     });
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

                                   campCharge(_controllerNameRoute,_controllerRoute);

                                   setState((){
                                     Navigator.of(context).pop(false);
                                   });
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
           )
         )),
      );
    },
  );
  return ruta ?? false;
}

void campCharge(List<TextEditingController> _controllerNameRoute, List<TextEditingController> _controllerRoute) {

  for(int i = 0; i <routesManage.length; i++)
  {
     _controllerNameRoute[i].text = routesManage[i].name;
    _controllerRoute[i].text = routesManage[i].route;
  }
}
  void _pickFile(TextEditingController controllerRoute) async {

  FilePickerResult? result =  await FilePicker.platform.pickFiles(
    dialogTitle: 'Seleccionar archivo',
    type: FileType.custom,
    allowedExtensions:  ['csv','exe'],
  );

  if(result == null) return;

  PlatformFile file = result.files.single;

  controllerRoute.text = file.path!;

}
