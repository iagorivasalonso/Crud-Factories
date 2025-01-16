import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void adminRoutes(BuildContext context) {

  List<TextEditingController> _controllerNameRoute = [];
  List<TextEditingController> _controllerRoute = [];

  for(int i = 0; i <routesManage.length; i++)
  {
      _controllerNameRoute.add(TextEditingController());
      _controllerRoute.add(TextEditingController());
      _controllerNameRoute[i].text = routesManage[i].name;
      _controllerRoute[i].text = routesManage[i].route;

  }
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: StatefulBuilder(
             builder: ((BuildContext context, void Function(void Function()) setState) => Dialog(
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
               child: SizedBox(
                 height: 300,
                 width: 500,
                 child: Column(
                   children: [
                     headAlert(title:"Selector de rutas"),
                   SizedBox(
                     height: 200,
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
