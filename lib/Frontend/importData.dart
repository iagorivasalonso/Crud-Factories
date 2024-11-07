import 'dart:io';
import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Alertdialogs/noFind.dart';
import 'package:crud_factories/Backend/CSV/exportEmpleoyes.dart';
import 'package:crud_factories/Backend/CSV/exportSectors.dart';
import 'package:crud_factories/Backend/CSV/importEmpleoyes.dart';
import 'package:crud_factories/Backend/CSV/importSectors.dart';
import 'package:crud_factories/Backend/SQL/createEmpleoye.dart';
import 'package:crud_factories/Backend/SQL/createFactory.dart';
import 'package:crud_factories/Backend/SQL/createLine.dart';
import 'package:crud_factories/Backend/SQL/createMail.dart';
import 'package:crud_factories/Backend/SQL/createSector.dart';
import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Backend/CSV/exportConections.dart';
import 'package:crud_factories/Backend/CSV/exportFactories.dart';
import 'package:crud_factories/Backend/CSV/exportLines.dart';
import 'package:crud_factories/Backend/CSV/exportMails.dart';
import 'package:crud_factories/Backend/CSV/importConections.dart';
import 'package:crud_factories/Backend/CSV/importFactories.dart';
import 'package:crud_factories/Backend/CSV/importLines.dart';
import 'package:crud_factories/Backend/CSV/importMails.dart';
import 'package:crud_factories/Functions/createId.dart';
import 'package:crud_factories/Objects/Conection.dart';
import 'package:crud_factories/Objects/Empleoye.dart';
import 'package:crud_factories/Objects/Factory.dart';
import 'package:crud_factories/Objects/Mail.dart';
import 'package:crud_factories/Objects/LineSend.dart';
import 'package:crud_factories/Objects/Sector.dart';
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

    List<Sector> sectorsNew = [];
    List<Factory> factoriesNew =[];
    List<Empleoye> empleoyesNew = [];
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
                                      _pickFile(context, controllerDatePicker,sectorsNew,factoriesNew,empleoyesNew,mailsNew,linesNew,conectionsNew);
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 130.0,left: 400),
                            child: SizedBox(
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
                                      String current1 = '';
                                      bool repeat = false;
                                      int cantImport=0;

                                      if(sectorsNew.isNotEmpty)
                                      {
                                        repeat = false;

                                        for(int i = 0; i < sectorsNew.length; i++)
                                        {
                                          repeat = false;
                                          current = sectorsNew[i].name;

                                          for (int i = 0; i < sectors.length; i++)
                                          {
                                            if(sectors[i].name == current)
                                            {
                                              repeat = true;
                                            }

                                          }
                                            if(repeat == false)
                                            {
                                              if(sectors.isNotEmpty)
                                              {
                                                String idLast = sectors[sectors.length-1].id;
                                                sectorsNew[i].id = createId(idLast);
                                              }
                                              else
                                              {
                                                sectorsNew[i].id ="1";
                                              }

                                              cantImport++;
                                              sectors.add(sectorsNew[i]);
                                            }

                                          if(cantImport > 0)
                                          {
                                            action ='se importaron $cantImport sectors correctamente';
                                            confirm(context,action);
                                          }
                                          else
                                          {
                                            action = 'no hay ningun sector para importar';
                                            confirm(context, action);
                                          }
                                
                                          if(conn != null)
                                          {
                                            sqlCreateSector(sectorsNew);
                                          }
                                          else
                                          {
                                            csvExportatorSectors(sectors);
                                          }
                                        }
                                      }

                                      if(empleoyesNew.isNotEmpty)
                                      {

                                        for(int i = 0; i < empleoyesNew.length; i++)
                                        {
                                          current = empleoyesNew[i].idFactory;
                                          bool repeat = false;

                                          for(int x = 0; x < factories.length; x++)
                                          {
                                            if(current == factories[x].id)
                                            {

                                              repeat = true;
                                            }
                                          }

                                          if(repeat == false)
                                          {
                                            empleoyesNew.removeAt(i);
                                            String stringDialog ="El empleado $current no pertenece a la empresa";
                                            repeat = await noFind(context, true, stringDialog);
                                          }
                                        }

                                        for(int i = 0; i < empleoyesNew.length; i++)
                                        {
                                          repeat = false;
                                          current = empleoyesNew[i].name;
                                          current1 = empleoyesNew[i].idFactory;

                                          if(line.isNotEmpty)
                                          {
                                            for(int x = 0; x <empleoyes.length; x++)
                                            {
                                              if(empleoyes[x].name == current  && empleoyes[x].idFactory == current1)
                                              {
                                                repeat = true;
                                              }
                                            }
                                          }

                                          if(repeat == false)
                                          {
                                            if(empleoyes.isNotEmpty)
                                            {
                                              String idLast = empleoyes[empleoyes.length-1].id;
                                              empleoyesNew[i].id = createId(idLast);
                                            }
                                            else
                                            {
                                              empleoyesNew[i].id ="1";
                                            }

                                            cantImport++;
                                            empleoyes.add(empleoyesNew[i]);
                                          }

                                        }

                                        if(cantImport > 0)
                                        {
                                          action ='se importaron $cantImport empleados correctamente';
                                          confirm(context,action);
                                        }
                                        else
                                        {
                                          action = 'no hay ningun empleado para importar';
                                          confirm(context, action);
                                        }

                                        if(conn != null)
                                        {
                                          sqlCreateEmpleoye(empleoyesNew);
                                        }
                                        else
                                        {
                                          csvExportatorEmpleoyes(empleoyes);
                                        }

                                      }
                                      if(mailsNew.isNotEmpty)
                                      {
                                        for(int i = 0; i <mailsNew.length; i++)
                                        {
                                          repeat = false;
                                          current = mailsNew[i].addrres;

                                          for(int x = 0; x <mails.length; x++)
                                          {
                                            if(mails[x].addrres == current)
                                            {
                                              repeat = true;
                                            }
                                          }

                                          if(repeat == false)
                                          {
                                            if(mails.isNotEmpty)
                                            {
                                              String idLast = mails[mails.length-1].id;
                                              mailsNew[i].id = createId(idLast);
                                            }
                                            else
                                            {
                                              mailsNew[i].id ="1";
                                            }

                                            cantImport++;
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


                                        if(conn != null)
                                        {
                                          sqlCreateMail(mailsNew);
                                        }
                                        else
                                        {
                                          csvExportatorMails(mails);
                                        }
                                      }
                                      if(linesNew.isNotEmpty)
                                      {

                                        for(int i = 0; i < linesNew.length; i++)
                                        {
                                          current = linesNew[i].factory;
                                          repeat = false;

                                          for(int x = 0; x < factories.length; x++)
                                          {
                                            if(current == factories[x].name)
                                            {
                                              repeat = true;
                                            }
                                          }

                                          if(repeat == false)
                                          {
                                            linesNew.removeAt(i);
                                            String stringDialog ="La empresa $current no perdatos";
                                            repeat = await noFind(context, true, stringDialog);
                                          }
                                        }
                                        for(int i = 0; i < linesNew.length; i++)
                                        {
                                          repeat = false;
                                          current = linesNew[i].date;
                                          current1 = linesNew[i].factory;

                                          if(line.isNotEmpty)
                                          {
                                            for(int x = 0; x <line.length; x++)
                                            {
                                              if(line[x].date == current  && line[x].factory == current1)
                                              {
                                                repeat = true;
                                              }
                                            }
                                          }

                                          if(repeat == false)
                                          {
                                            if(line.isNotEmpty)
                                            {
                                              String idLast = line[line.length-1].id;
                                              linesNew[i].id = createId(idLast);
                                            }
                                            else
                                            {
                                              linesNew[i].id ="1";
                                            }
                                            cantImport++;
                                            line.add(linesNew[i]);
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

                                        if(conn != null)
                                        {
                                          sqlCreateLine(linesNew);
                                        }
                                        else
                                        {
                                          csvExportatorLines(line);
                                        }
                                      }
                                      if(conectionsNew.isNotEmpty)
                                      {
                                        repeat = false;

                                        for(int i = 0; i <conectionsNew.length; i++)
                                        {
                                          repeat = false;
                                          current = conectionsNew[i].database;

                                          for(int x = 0; x <conections.length; x++)
                                          {
                                            if(conections[x].database == current)
                                            {
                                              repeat= true;
                                            }
                                          }
                                          if(repeat == false)
                                          {
                                              if(conections.isNotEmpty)
                                              {
                                                String idLast = conections[conections.length-1].id;
                                                conectionsNew[i].id = createId(idLast);
                                              }
                                              else
                                              {
                                                conectionsNew[i].id ="1";
                                              }

                                              cantImport++;
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

                                        csvExportatorConections(conections);
                                      }
                                      if(factoriesNew.isNotEmpty)
                                      {
                                        print(factoriesNew.length);
                                        for(int i = 0; i < factoriesNew.length; i++)
                                        {
                                          current = factoriesNew[i].sector;
                                          repeat = false;

                                          for(int x = 0; x < sectors.length; x++)
                                          {
                                            if(current == sectors[x].id)
                                            {
                                              repeat = true;
                                            }
                                          }

                                          if(repeat == false)
                                          {
                                            factoriesNew.removeAt(i);
                                            String stringDialog ="no existe el sector";
                                            repeat = await noFind(context, true, stringDialog);
                                          }
                                        }

                                        for(int i = 0; i <factoriesNew.length; i++)
                                        {
                                          repeat = false;
                                          current = factoriesNew[i].name;

                                          for(int x = 0; x <factories.length; x++)
                                          {
                                            if(factories[x].name == current)
                                            {
                                              repeat= true;
                                            }

                                          }

                                          if(repeat == false)
                                          {
                                             if(factories.isNotEmpty)
                                             {
                                              String idLast = factories[factories.length-1].id;
                                              factoriesNew[i].id = createId(idLast);
                                            }
                                             else
                                             {
                                              factoriesNew[i].id ="1";
                                            }

                                            cantImport++;
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

                                        if(conn != null)
                                        {
                                          sqlCeateFactory(factoriesNew);
                                        }
                                        else
                                        {
                                          csvExportatorFactories(factories);
                                        }
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


void _pickFile(BuildContext context, TextEditingController controllerDatePicker,List<Sector> sectors, List<Factory> factories, List<Empleoye> empleoyes, List<Mail> mails, List<LineSend> lines, List<Conection> conections) async {


  FilePickerResult? result =  await FilePicker.platform.pickFiles(
    dialogTitle: 'Seleccionar archivo',
    type: FileType.custom,
    allowedExtensions: ['csv'],
  );

  if(result == null) return;

  PlatformFile file = result.files.single;

  controllerDatePicker.text =file.path!;

  sectors.clear();
  factories.clear();
  empleoyes.clear();
  mails.clear();
  lines.clear();
  conections.clear();

  File file1 =new File(file.path!);
  List<String> fileContent=[];
  fileContent = await file1.readAsLines();
  List <String> camps = [];


  for (int i = 0; i <fileContent.length; i++)
  {
    camps = fileContent[i].split(";");
  }
  print(camps.length);
     if(camps.length==2)
    {

       try {
         sectors.add(csvImportSectors(fileContent, sectors));
         } catch (Exeption) {

         }
    }
    else if(camps.length==3)
    {

      try {
             empleoyes.add(csvImportEmpleoyes(fileContent, empleoyes));
          } catch (Exeption) {

        }
    }
    else if(camps.length==4)
    {

      try {
        mails.add(csvImportMails(fileContent, mails));
      } catch (Exeption) {

      }
    }
    else if(camps.length==5)
    {

        try {
          lines.add(csvImportLines(fileContent, lines));
        } catch (Exeption) {

        }

    }
    else if(camps.length==6)
    {

      try {
        conections.add(csvImportConections(fileContent, conections));

      } catch (Exeption) {

      }

     }
     else if(camps.length==15)
     {
        try {
          factories.add(csvImportFactories(fileContent, factories));
       } catch (Exeption) {

         }
     }
     else
     {
        String action ="archivo no valido";
        error(context, action);
     }

  }



