import 'dart:io';
import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Backend/exportFactories.dart';
import 'package:crud_factories/Backend/exportLines.dart';
import 'package:crud_factories/Backend/exportMails.dart';
import 'package:crud_factories/Backend/importFactories.dart';
import 'package:crud_factories/Backend/importLines.dart';
import 'package:crud_factories/Backend/importMails.dart';
import 'package:crud_factories/Objects/Factory.dart';
import 'package:crud_factories/Objects/Mail.dart';
import 'package:crud_factories/Objects/lineSend.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class newImport extends StatefulWidget {

  @override
  State<newImport> createState() => _newImportState();
}

class _newImportState extends State<newImport> {

  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();

  TextEditingController controllerDatePicker = new TextEditingController();

  double widthBar = 10.0;
  String? selectedValue;

  @override
  Widget build(BuildContext context) {

    List<Factory> factoriesNew =[];
    List<Mail> mailsNew = [];
    List<lineSend> linesNew = [];
    
    return Scaffold(
      body: AdaptiveScrollbar(
        controller: verticalScroll,
        width: widthBar,
        child: AdaptiveScrollbar(
          controller: horizontalScroll,
          width: widthBar,
          position: ScrollbarPosition.bottom,
          underSpacing: EdgeInsets.only(bottom: 8),
          child: SingleChildScrollView(
            controller: verticalScroll,
            scrollDirection: Axis.vertical,
            child: Container(
              width: 2000,
              child: SingleChildScrollView(
                controller: horizontalScroll,
                scrollDirection: Axis.horizontal,
                child: Container(
                  height: 400,
                  width: 736,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child:  Padding(
                      padding: const EdgeInsets.only(left: 30.0,top: 30.0),
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              Text('Importar datos: ',
                                style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 15.00),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text('Importar datos en formato CSV.'),
                                  ],
                                ),
                              ],
                            ),

                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:80.0, bottom: 30.0),
                            child: Row(
                              children: [
                                const Text('Ruta: '),
                                SizedBox(
                                  width: 400,
                                  height: 40,
                                  child: TextField(
                                    decoration:const InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                    controller: controllerDatePicker,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 40.0),
                                  child: ElevatedButton(
                                    child: const Text('Examinar'),
                                    onPressed: (){
                                      _pickFile(controllerDatePicker,factoriesNew,mailsNew,linesNew);
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 130.0,left: 400),
                            child: Container(
                              width: 250,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    child: const Text('Importar datos'),
                                    onPressed: () {
                                      String action = '';
                                      String current = '';

                                      bool repeat = false;


                                      if(factoriesNew.isNotEmpty)
                                      {
                                        repeat = false;
                                        int cantImport = factoriesNew.length;

                                        for(int i = 0; i <factoriesNew.length; i++)
                                        {
                                           repeat = false;
                                           current = factoriesNew[i].name;

                                           for(int x = 0; x <factories.length; x++)
                                           {
                                              if(factories[x].name == current)
                                              {
                                                cantImport--;
                                                repeat= true;
                                              }

                                           }

                                           if(repeat == false)
                                           {
                                             factories.add(factoriesNew[i]);
                                           }

                                        }

                                        action ='se importaron $cantImport empresas correctamente';
                                        confirm(context,action);

                                        for(int i = 0; i < factories.length; i++)
                                        {
                                          int id = i + 1;
                                          factories[i].id = id.toString();
                                        }

                                        csvExportatorFactories(factories, -1);
                                      }

                                      if(mailsNew.isNotEmpty)
                                      {
                                        repeat = false;
                                         int cantImport = mailsNew.length;

                                        for(int i = 0; i <mailsNew.length; i++)
                                        {
                                          repeat = false;
                                          current = mailsNew[i].addrres;

                                          for(int x = 0; x <mails.length; x++)
                                          {
                                            if(mails[x].addrres == current)
                                            {
                                              cantImport--;
                                              repeat= true;
                                            }
                                          }
                                          if(repeat == false)
                                          {
                                            mails.add(mailsNew[i]);
                                          }

                                        }

                                        action ='se importaron $cantImport emails correctamente';
                                        confirm(context,action);

                                        for(int i = 0; i < mails.length; i++)
                                        {
                                          int id = i + 1;
                                          mails[i].id = id.toString();
                                        }

                                        csvExportatorMails(mails, -1);
                                      }

                                      if(linesNew.isNotEmpty)
                                      {

                                        int cantImport = linesNew.length;

                                        for(int i = 0; i <linesNew.length; i++)
                                        {
                                          line.add(linesNew[i]);
                                        }

                                        action ='se importaron $cantImport lineas correctamente';
                                        confirm(context,action);

                                        for(int i = 0; i < line.length; i++)
                                        {
                                          int id = i + 1;
                                          line[i].id = id.toString();
                                        }

                                        csvExportatorLines(line);
                                      }
                                    },
                                  ),
                                  ElevatedButton(
                                    child: const Text('Borrar'),
                                    onPressed: () {
                                          setState(() {
                                            controllerDatePicker.text = "";
                                          });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
void _pickFile(TextEditingController controllerDatePicker,List<Factory> factories,  List<Mail> mails, List<lineSend> lines) async {


  FilePickerResult? result =  await FilePicker.platform.pickFiles(
    dialogTitle: 'Seleccionar archivo',
    type: FileType.custom,
    allowedExtensions: ['csv'],
  );

  if(result == null) return;

  PlatformFile file = result.files.single;

  controllerDatePicker.text =file.path!;

  File file1 =new File(file.path!);
  List<String> fileContent=[];
  fileContent = await file1.readAsLines();
  List <String> camps = [];

  for (int i = 0; i <fileContent.length; i++) {

    camps = fileContent[i].split(",");
    print(camps);
  }

    if(camps.length>10)
    {

      try {
        factories.add(importFactory(fileContent, factories));
      } catch (Exeption) {

      }

    }
    if(camps.length==4)
    {
      bool isNumber = RegExp(r"^[0-9,$]*$").hasMatch(camps[0]);

      if(isNumber)
      {

        try {
          mails.add(importMail(fileContent, mails));
        } catch (Exeption) {

        }

      }
      else
      {

        try {
          lines.add(importLines(fileContent, lines));
        } catch (Exeption) {

        }

      }

  }



}