import 'dart:io';

import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Backend/exportLines.dart';
import 'package:crud_factories/Backend/exportMails.dart';
import 'package:crud_factories/Backend/importMails.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../Backend/exportFactories.dart';
import '../Backend/importFactories.dart';
import '../Backend/importLines.dart';
import '../Objects/Factory.dart';
import '../Objects/Mail.dart';
import '../Objects/lineSend.dart';

class newImport extends StatefulWidget {

  List<Factory> factories;
  List<Mail> mails;
  List<lineSend> line;
  
  newImport(this.factories, this.mails, this.line);
  
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

    List<Factory> factories = widget.factories;
    List<Factory> factoriesNew =[];
    List<Mail> mails = widget.mails;
    List<Mail> mailsNew = [];
    List<lineSend> lines = widget.line;
    List<lineSend> linesNew = [];

    
    return AdaptiveScrollbar(
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
                                    String current = '';
                                    String action = '';

                                    if(factoriesNew.isNotEmpty)
                                    {
                                          for(int i = 0; i < factories.length; i++)
                                          {
                                            if(i==0)
                                            {
                                              if(factories.isEmpty)
                                                factories.add(factories[0]);
                                            }
                                              current = factories[i].name;

                                              for(int x = 0; x < factoriesNew.length; x++) {
                                                if (factoriesNew[x].name == current) {
                                                    factoriesNew.removeAt(x);
                                                }
                                             }

                                          }

                                          for(int i = 0; i < factories.length; i++)
                                          {
                                             int id = i + 1;
                                            factories[i].id = id.toString();
                                          }

                                          factories = factories + factoriesNew;

                                          int cantImport = factoriesNew.length;
                                          action ='se importaron $cantImport empresas correctamente';
                                          confirm(context,action);


                                          csvExportatorFactories(factories, -1);
                                    }

                                    if(mailsNew.isNotEmpty)
                                    {
                                      for(int i = 0; i < mails.length; i++)
                                      {
                                        if(i==0)
                                        {
                                          if(mails.isEmpty)
                                            mails.add(mails[0]);
                                        }
                                        current = mails[i].addrres;

                                        for(int x = 0; x < mailsNew.length; x++) {
                                          if (mailsNew[x].addrres == current) {
                                            mailsNew.removeAt(x);
                                          }
                                        }

                                      }

                                      for(int i = 0; i < mails.length; i++)
                                      {
                                        int id = i + 1;
                                        mails[i].id = id.toString();
                                      }

                                      mails = mails + mailsNew;

                                      int cantImport = mailsNew.length;
                                      action ='se importaron $cantImport emails correctamente';
                                      confirm(context,action);

                                      csvExportatorMails(mails, -1);
                                    }

                                    if(linesNew.isNotEmpty)
                                    {
                                      int cantImport = linesNew.length;
                                      action ='se importaron $cantImport lineas correctamente';
                                      confirm(context,action);

                                      lines = lines + linesNew;

                                      csvExportatorLines(lines);
                                    }


                                  },
                                ),
                                ElevatedButton(
                                  child: const Text('Cancelar'),
                                  onPressed: () {

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
    );
  }
}
void _pickFile(TextEditingController controllerDatePicker,List<Factory> factories,  List<Mail> mails, List<lineSend> lines) async {

  factories.clear();
  mails.clear();
  lines.clear();


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
  }

    if(camps.length>10)
    {
      print("Es una empresa");

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
        print("Es un email");

        try {
          mails.add(importMail(fileContent, mails));
        } catch (Exeption) {

        }

      }
      else
      {
        print("Es un envio");
        try {
          lines.add(importLines(fileContent, lines));
        } catch (Exeption) {

        }

      }

  }



}