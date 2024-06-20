import 'dart:io';
import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Alertdialogs/noFind.dart';
import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Backend/exportConections.dart';
import 'package:crud_factories/Backend/exportFactories.dart';
import 'package:crud_factories/Backend/exportLines.dart';
import 'package:crud_factories/Backend/exportMails.dart';
import 'package:crud_factories/Backend/importConections.dart';
import 'package:crud_factories/Backend/importFactories.dart';
import 'package:crud_factories/Backend/importLines.dart';
import 'package:crud_factories/Backend/importMails.dart';
import 'package:crud_factories/Objects/Conection.dart';
import 'package:crud_factories/Objects/Factory.dart';
import 'package:crud_factories/Objects/Mail.dart';
import 'package:crud_factories/Objects/LineSend.dart';
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
    List<LineSend> linesNew = [];
    List<Conection> conectionsNew = [];
    
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
                                  width: 420,
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
                                  child: MaterialButton(
                                    color: Colors.lightBlue,
                                    child: const Text('Examinar',
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                    onPressed: (){
                                      _pickFile(context, controllerDatePicker,factoriesNew,mailsNew,linesNew,conectionsNew);
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
                                  MaterialButton(
                                    color: Colors.lightBlue,
                                    child: const Text('Importar datos',
                                    style:  const TextStyle(color: Colors.white) ,),
                                    onPressed: () async {
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
                                      if(cantImport > 0)
                                      {
                                        action = 'se importaron $cantImport empresas correctamente';
                                        confirm(context, action);
                                      }
                                      else
                                      {
                                        action = 'no hay ninguna empresa para importar';
                                        confirm(context, action);
                                      }
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

                                        if(cantImport > 0)
                                        {
                                          action ='se importaron $cantImport emails correctamente';
                                          confirm(context,action);
                                        }
                                        else
                                        {
                                          action = 'no hay ningun email para importar';
                                          confirm(context, action);
                                        }

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
                                        for(int i = 0; i < linesNew.length; i++)
                                        {
                                          current = linesNew[i].factory;
                                          bool exist= false;
                                          
                                          for(int x = 0; x < factories.length; x++)
                                          {
                                               if(current == factories[x].name)
                                               {
                                                  exist = true;
                                               }
                                          }

                                          if(exist == false)
                                          {
                                            cantImport -= 1 ;
                                            String stringDialog ="La empresa $current no pertenece a nuestra base de datos";
                                            
                                            exist = await noFind(context, true, stringDialog);

                                          }
                                        }

                                        if(cantImport > 0)
                                        {
                                          action ='se importaron $cantImport lineas correctamente';
                                          confirm(context,action);
                                        }
                                        else
                                        {
                                          action = 'no hay ninguna linea para importar';
                                          confirm(context, action);
                                        }


                                        for(int i = 0; i < line.length; i++)
                                        {
                                          int id = i + 1;
                                          line[i].id = id.toString();
                                        }

                                        csvExportatorLines(line);
                                      }

                                      if(conectionsNew.isNotEmpty)
                                      {
                                        repeat = false;
                                        int cantImport = conectionsNew.length;

                                        for(int i = 0; i <conectionsNew.length; i++)
                                        {
                                          repeat = false;
                                          current = conectionsNew[i].database;

                                          for(int x = 0; x <conections.length; x++)
                                          {
                                            if(conections[x].database == current)
                                            {
                                              cantImport--;
                                              repeat= true;
                                            }
                                          }
                                          if(repeat == false)
                                          {
                                            conections.add(conectionsNew[i]);
                                          }

                                        }
                                      if(cantImport > 0)
                                      {
                                        action = 'se importaron $cantImport conexiones correctamente';
                                        confirm(context, action);
                                      }
                                      else
                                      {
                                        action = 'no hay ninguna conexion para importar';
                                        confirm(context, action);
                                      }
                                        for(int i = 0; i < conections.length; i++)
                                        {
                                          int id = i + 1;
                                          conections[i].id = id.toString();
                                        }

                                        csvExportatorConections(conections);
                                      }
                                    },
                                  ),
                                  MaterialButton(
                                    color: Colors.lightBlue,
                                    child: const Text('Borrar',
                                        style: const TextStyle(color: Colors.white),),
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
void _pickFile(BuildContext context, TextEditingController controllerDatePicker,List<Factory> factories,  List<Mail> mails, List<LineSend> lines, List<Conection> conections) async {


  FilePickerResult? result =  await FilePicker.platform.pickFiles(
    dialogTitle: 'Seleccionar archivo',
    type: FileType.custom,
    allowedExtensions: ['csv'],
  );

  if(result == null) return;

  PlatformFile file = result.files.single;

  controllerDatePicker.text =file.path!;

  factories.clear();
  mails.clear();
  lines.clear();
  conections.clear();

  File file1 =new File(file.path!);
  List<String> fileContent=[];
  fileContent = await file1.readAsLines();
  List <String> camps = [];
  for (int i = 0; i <fileContent.length; i++) {

    camps = fileContent[i].split(",");
  }


    if(camps.length>10)
    {
      try {
        factories.add(importFactory(fileContent, factories));
      } catch (Exeption) {

      }

    }
    else if(camps.length==4)
    {

      try {
        mails.add(importMail(fileContent, mails));
      } catch (Exeption) {

      }

      }
      else if(camps.length==5)
      {

        try {
          lines.add(importLines(fileContent, lines));
        } catch (Exeption) {

        }

      }
    else if(camps.length==6)
    {

      try {
        conections.add(importConections(fileContent, conections));

      } catch (Exeption) {

      }

    }
      else
      {
        String action ="archivo no valido";
        error(context, action);
      }

  }



