import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Backend/CSV/exportRoutes.dart';
import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Objects/RouteCSV.dart';
import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

Future<bool> adminRoutes(BuildContext context, [bool? sqLbd]) async {

  List <String> nameRoutes = ['Routes', 'Conections', 'serverSql', 'Sectors', 'Factories', 'Empleoyes', 'Lines', 'Mails'];

  List<TextEditingController> _controllerNameRoute = [];
  List<TextEditingController> _controllerRoute = [];

  bool onlySql = false;

  if(sqLbd!= null)
  {
    onlySql = true;
  }
  
  for(int i = 0; i <nameRoutes!.length; i++)
  {
    _controllerNameRoute.add(TextEditingController());
    _controllerRoute.add(TextEditingController());
  }

  if(routesManage.isEmpty)
  {
    for(int i = 0; i <nameRoutes.length; i++)
    {
      _controllerNameRoute[i].text = nameRoutes[i];
      _controllerRoute[i].text = " ";
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
                 Padding(
                   padding: const EdgeInsets.only(top: 40.0, left: 20.0),
                   child: Row(
                      children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text("Todas"),
                                  ),
                                  Radio(
                                      value: false,
                                      groupValue: onlySql,
                                      onChanged: (value) {
                                        setState(() {
                                          onlySql = false;
                                        });
                                      }),
                                ],
                              ),

                            ],
                          ),
                          Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Text("SQL"),
                                ),
                                Radio(
                                    value: true,
                                    groupValue: onlySql,
                                    onChanged: (value) {
                                      setState(() {
                                        onlySql = true;
                                      });
                                    }),

                              ],
                            ),

                          ],
                        )
                      ],
                   ),
                 ),
                 Row(
                   children: [
                     SizedBox(
                       height: 300,
                       width: 500,
                       child: Padding(
                         padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                         child: ListView.builder(
                           itemCount: onlySql ==  true
                                      ? 3
                                      : nameRoutes.length,
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

                                    for(int i = 0; i < routesManage.length; i++)
                                    {
                                      idNew = i + 1;

                                      routesNew.add(RouteCSV(
                                          id: idNew.toString(),
                                          name: _controllerNameRoute[i].text,
                                          route: _controllerRoute[i].text
                                      ));
                                    }
                                     String action = 'Las rutas se han guardado correctamente';
                                     bool conf = await confirm(context, action);

                                     setState((){
                                       csvExportatorRoutes(routesNew);
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
    allowedExtensions: ['csv','pdf'],
  );

  if(result == null) return;

  PlatformFile file = result.files.single;

  controllerRoute.text = file.path!;

}
