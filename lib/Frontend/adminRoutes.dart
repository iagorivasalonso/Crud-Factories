import 'dart:io';

import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Backend/CSV/chargueData%20csv.dart';
import 'package:crud_factories/Backend/CSV/exportRoutes.dart';
import 'package:crud_factories/Backend/Global/files.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Objects/RouteCSV.dart';
import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:crud_factories/Widgets/headViewsAndroid.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:crud_factories/helpers/localization_helper.dart';
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
    currentRoutes = allRoutesOrdened;
  }
  else
  {
     currentRoutes = SQLRoutes;
  }

  for(int i = 0; i <currentRoutes!.length; i++)
  {
    _controllerNameRoute.add(TextEditingController());
    _controllerRoute.add(TextEditingController());
  }

  if(routesCSV.isEmpty)
  {
    for(int i = 0; i <currentRoutes.length; i++)
    {
      _controllerNameRoute[i].text = allRoutesOrdened[i];

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
    campCharge(_controllerNameRoute,_controllerRoute,context);
  }

  bool? route = await showDialog(
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
                   headAlert(title: S.of(context).route_selector),
                 Expanded(
                     child: Align(
                       alignment: Alignment.topLeft,
                       child: Padding(
                         padding: const EdgeInsets.only(top: 40.0),
                         child: SizedBox(
                           width: 310,
                           child: Row(
                             children: [
                                Expanded(
                                 flex:2,
                                 child: Padding(
                                   padding: const EdgeInsets.only(left: 40.0),
                                   child: Text(S.of(context).source,
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
                                     Expanded(
                                       child: Text(S.of(context).allFemale,
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
                                               currentRoutes = allRoutesOrdened;
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
                                     Expanded(
                                       child: Padding(
                                         padding: EdgeInsets.only(left: 10),
                                         child: Text(S.of(context).sql,
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
                                                    _pickFile(_controllerRoute[index],context);
                                                  });
                                                },
                                                child: Text(
                                                  S.of(context).examine,
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

                                       String array = S.of(context).routes;
                                       String actionArray = S.of(context).saved;

                                       String action = LocalizationHelper.manage_array(context, array, actionArray);

                                      await confirm(context, action);
                                      chargueDataCSV(context);
                                   print(routesNew);
                                      csvExportatorRoutes(routesNew);


                                      setState((){
                                       Navigator.of(context).pop(true);
                                     });
                                 },
                                 child: Text(S.of(context).import,style:  TextStyle(color: Colors.white),)
                             ),
                           ),
                         ),
                         Expanded(
                           child: Padding(
                             padding: const EdgeInsets.only(left: 15, right: 140),
                             child: MaterialButton(
                                 color: Colors.lightBlue,
                                 onPressed:(){
                                   campCharge(_controllerNameRoute,_controllerRoute,context);

                                   setState((){
                                     Navigator.of(context).pop(false);
                                   });
                                 },
                                 child: Text(S.of(context).cancel,style: TextStyle(color: Colors.white),)
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
  return route ?? false;
}


void campCharge(List<TextEditingController> _controllerNameRoute, List<TextEditingController> _controllerRoute, BuildContext context) {


  for(int i = 0; i <routesCSV.length; i++)
  {
     _controllerNameRoute[i].text = routesCSV[i].name;
    _controllerRoute[i].text = routesCSV[i].route;
  }
}
void _pickFile(TextEditingController controllerRoute, BuildContext context) async {

  FilePickerResult? result =  await FilePicker.platform.pickFiles(
    dialogTitle: S.of(context).select_file,
    type: FileType.custom,
    allowedExtensions:  ['csv','exe'],
  );

  if(result == null) return;

  PlatformFile file = result.files.single;

  controllerRoute.text = file.path!;

}
