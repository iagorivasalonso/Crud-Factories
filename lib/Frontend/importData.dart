import 'dart:convert';
import 'dart:io';
import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Alertdialogs/noFind.dart';
import 'package:crud_factories/Backend/CSV/exportEmpleoyes.dart';
import 'package:crud_factories/Backend/CSV/exportSectors.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/SQL/createEmpleoye.dart';
import 'package:crud_factories/Backend/SQL/createFactory.dart';
import 'package:crud_factories/Backend/SQL/createLine.dart';
import 'package:crud_factories/Backend/SQL/createMail.dart';
import 'package:crud_factories/Backend/SQL/createSector.dart';
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Backend/CSV/exportConections.dart';
import 'package:crud_factories/Backend/CSV/exportFactories.dart';
import 'package:crud_factories/Backend/CSV/exportLines.dart';
import 'package:crud_factories/Backend/CSV/exportMails.dart';
import 'package:crud_factories/Functions/createId.dart';
import 'package:crud_factories/Functions/manageState.dart';
import 'package:crud_factories/Objects/Conection.dart';
import 'package:crud_factories/Objects/Empleoye.dart';
import 'package:crud_factories/Objects/Factory.dart';
import 'package:crud_factories/Objects/Mail.dart';
import 'package:crud_factories/Objects/LineSend.dart';
import 'package:crud_factories/Objects/Sector.dart';
import 'package:crud_factories/Widgets/headViewsAndroid.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:crud_factories/helpers/localization_helper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class newImport extends StatefulWidget {

  BuildContext context;

    newImport(this.context);
  @override
  State<newImport> createState() => _newImportState();
}

class _newImportState extends State<newImport> {

  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();

  TextEditingController controllerDatePicker = new TextEditingController();

  double widthBar = 10.0;
  int idEndList = 0;

  @override
  Widget build(BuildContext context) {

    BuildContext context = widget.context;

    List<Sector> sectorsNew = [];
    List<Factory> factoriesNew =[];
    List<Empleoye> empleoyesNew = [];
    List<Mail> mailsNew = [];
    List<LineSend> linesNew = [];
    List<Conection> conectionsNew = [];

    if(idEndList == 0)
    {
      for(int i = 0; i < allFactories.length; i++)
      {
        idEndList = int.parse(allFactories[i].id);
      }
    }

    return Platform.isWindows
        ? Scaffold(
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
                          Row(
                            children: [
                              Text(S.of(context).import_data,
                                style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 15.00),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(S.of(context).Import_data_in_CSV_format),
                                  ],
                                ),
                              ],
                            ),

                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:80.0, bottom: 30.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right:10),
                                  child: Text(S.of(context).route),
                                ),
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
                                    child: Text(S.of(context).examine,
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
                                    child: Text(S.of(context).import_data,
                                      style:  const TextStyle(color: Colors.white) ,),
                                    onPressed: () async {

                                      String action = '';
                                      String current = '';
                                      String current1 = '';
                                      bool repeat = false;
                                      int cantImport = 0;

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
                                        }
                                        String array =  S.of(context).sectors;

                                        if(cantImport > 0)
                                        {
                                          action = LocalizationHelper.importData(context,array, cantImport);
                                          confirm(context,action);
                                        }
                                        else
                                        {
                                          action = LocalizationHelper.no_do_import(context, array);
                                          confirm(context, action);
                                        }

                                        if(conn != null)
                                        {
                                          sqlCreateSector(sectorsNew);
                                        }
                                        else
                                        {
                                          await csvExportatorSectors(sectors);
                                        }

                                      }

                                      if(empleoyesNew.isNotEmpty)
                                      {
                                        if(allFactories.isNotEmpty)
                                        {
                                          for(int i = 0; i < empleoyesNew.length; i++)
                                          {
                                            current = empleoyesNew[i].idFactory;
                                            bool repeat = false;

                                            for(int x = 0; x < allFactories.length; x++)
                                            {
                                              if(current == allFactories[x].id)
                                              {
                                                repeat = true;
                                              }
                                            }

                                            if(repeat == false)
                                            {
                                              empleoyesNew.removeAt(i);
                                              String stringDialog = LocalizationHelper.empleoyesBeFactory(context, current);
                                              repeat = await noFind(context, true, stringDialog);
                                            }
                                          }

                                          for(int i = 0; i < empleoyesNew.length; i++)
                                          {
                                            repeat = false;
                                            current = empleoyesNew[i].name;
                                            current1 = empleoyesNew[i].idFactory;

                                            if(lineSector.isNotEmpty)
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

                                              int idFactEmp = int.parse(empleoyesNew[i].idFactory)+idEndList;
                                              empleoyesNew[i].idFactory = idFactEmp.toString();

                                              cantImport++;
                                              empleoyes.add(empleoyesNew[i]);
                                            }


                                          }
                                          String array =  S.of(context).employees;

                                          if(cantImport > 0)
                                          {
                                            action = LocalizationHelper.importData(context,array, cantImport);
                                            confirm(context,action);
                                          }
                                          else
                                          {
                                            action = LocalizationHelper.no_do_import(context, array);
                                            confirm(context, action);
                                          }

                                          if(conn != null)
                                          {
                                            sqlCreateEmpleoye(empleoyesNew);
                                          }
                                          else
                                          {
                                            await csvExportatorEmpleoyes(empleoyes);
                                          }
                                        }
                                        else
                                        {
                                          String array =S.of(context).employees;
                                          action = LocalizationHelper.no_companies_without(context, array);
                                          error(context, action);
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
                                        String array =  S.of(context).mails;

                                        if(cantImport > 0)
                                        {

                                          action = LocalizationHelper.importData(context,array, cantImport);
                                          confirm(context,action);
                                        }
                                        else
                                        {
                                          action = LocalizationHelper.no_do_import(context, array);
                                          confirm(context, action);
                                        }


                                        if(conn != null)
                                        {
                                          sqlCreateMail(mailsNew);
                                        }
                                        else
                                        {
                                          await  csvExportatorMails(mails);
                                        }
                                      }
                                      if(linesNew.isNotEmpty)
                                      {
                                        if(allFactories.isNotEmpty)
                                        {
                                          for(int i = 0; i < linesNew.length; i++)
                                          {
                                            current = linesNew[i].factory;
                                            repeat = false;

                                            for(int x = 0; x < allFactories.length; x++)
                                            {
                                              if(current == allFactories[x].name)
                                              {
                                                repeat = true;
                                              }
                                            }

                                            if(repeat == false)
                                            {
                                              linesNew.removeAt(i);
                                              String stringDialog = LocalizationHelper.factorybeBD(context, current);
                                              repeat = await noFind(context, true, stringDialog);
                                            }
                                          }
                                          for(int i = 0; i < linesNew.length; i++)
                                          {
                                            repeat = false;
                                            current = linesNew[i].date;
                                            current1 = linesNew[i].factory;

                                            if(lineSector.isNotEmpty)
                                            {
                                              for(int x = 0; x <lineSector.length; x++)
                                              {
                                                if(lineSector[x].date == current  && lineSector[x].factory == current1)
                                                {
                                                  repeat = true;
                                                }
                                              }
                                            }

                                            if(repeat == false)
                                            {
                                              if(lineSector.isNotEmpty)
                                              {
                                                String idLast = lineSector[lineSector.length-1].id;
                                                linesNew[i].id = createId(idLast);
                                              }
                                              else
                                              {
                                                linesNew[i].id ="1";
                                              }
                                              cantImport++;
                                              lineSector.add(linesNew[i]);
                                            }

                                          }
                                          String array =  S.of(context).lines;

                                          if(cantImport > 0)
                                          {
                                            action = LocalizationHelper.importData(context,array, cantImport);
                                            confirm(context,action);
                                          }
                                          else
                                          {
                                            action = LocalizationHelper.no_do_import(context, array);
                                            confirm(context, action);
                                          }

                                          if(conn != null)
                                          {
                                            sqlCreateLine(linesNew,context);
                                          }
                                          else
                                          {
                                            await  csvExportatorLines(lineSector);;
                                          }
                                        }
                                        else
                                        {
                                          String array = S.of(context).lines;
                                          action = LocalizationHelper.no_companies_without(context, array);
                                          error(context, action);
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
                                        String array =  S.of(context).connections;
                                        if(cantImport > 0)
                                        {

                                          action = LocalizationHelper.importData(context,array, cantImport);
                                          confirm(context, action);
                                        }
                                        else
                                        {
                                          action = LocalizationHelper.no_do_import(context, array);
                                          confirm(context, action);
                                        }

                                        await csvExportatorConections(conections);

                                      }
                                      if(factoriesNew.isNotEmpty)
                                      {
                                        if(sectors.isNotEmpty)
                                        {
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
                                              String stringDialog =S.of(context).The_sector_does_not_exist;
                                              repeat = await noFind(context, true, stringDialog);
                                            }
                                          }

                                          for(int i = 0; i <factoriesNew.length; i++)
                                          {
                                            repeat = false;
                                            current = factoriesNew[i].name;

                                            for(int x = 0; x <allFactories.length; x++)
                                            {
                                              if(allFactories[x].name == current)
                                              {
                                                repeat= true;
                                              }

                                            }

                                            if(repeat == false)
                                            {
                                              if(allFactories.isNotEmpty)
                                              {
                                                String idLast = allFactories[allFactories.length-1].id;
                                                factoriesNew[i].id = createId(idLast);
                                              }
                                              else
                                              {
                                                factoriesNew[i].id ="1";
                                              }

                                              cantImport++;
                                              allFactories.add(factoriesNew[i]);

                                            }

                                          }
                                          if(cantImport > 0)
                                          {
                                            String array =  S.of(context).companies;
                                            action = LocalizationHelper.importData(context,array, cantImport);
                                            confirm(context, action);
                                          }
                                          else
                                          {
                                            action = S.of(context).there_is_no_companies_to_import;
                                            confirm(context, action);
                                          }

                                          if(conn != null)
                                          {
                                            sqlCeateFactory(factoriesNew);
                                          }
                                          else
                                          {
                                            await csvExportatorFactories(allFactories);
                                          }
                                        }
                                        else
                                        {
                                          action =action = S.of(context).Cannot_Load_Companies_because_it_does_not_have_sectors;
                                          error(context, action);
                                        }
                                      }
                                    },
                                  ),
                                  MaterialButton(
                                    color: Colors.lightBlue,
                                    child: Text(S.of(context).delete,
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
    )
        : Scaffold(
            appBar: appBarAndroid(context, name: S.of(context).import_data),
            body: Text("conection"),
       );
  }

}


void _pickFile(BuildContext context, TextEditingController controllerDatePicker,List<Sector> sectors, List<Factory> factories, List<Empleoye> empleoyes, List<Mail> mails, List<LineSend> line, List<Conection> conections) async {


  FilePickerResult? result =  await FilePicker.platform.pickFiles(
    dialogTitle: 'select file',
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
  lineSector.clear();
  conections.clear();

  File file1 =new File(file.path!);
  List<String> fileContent=[];
  final content = await file1.readAsString(encoding: utf8);

  final lines = const LineSplitter().convert(content);

  List <String> camps = [];

  for(int i = 0; i < lines.length; i++)
  {
    camps = lines[i].split(";");
  }

    if(camps.length==2)
    {
       try {

          for(int i = 0; i < lines.length; i++)
          {
            camps = lines[i].split(";");
            sectors.add(Sector(
                id: camps[0],
                name: camps[1]
            ));
          }

         } catch (Exeption) {

         }
    }
    else if(camps.length==3)
    {

      try {

              for(int i = 0; i < lines.length; i++)
              {
                camps = lines[i].split(";");
                empleoyes.add(Empleoye(
                  id: camps[0],
                  name: camps[1],
                  idFactory: camps[2],
                ));
              }
           
          } catch (Exeption) {

        }
    }
    else if(camps.length==4)
    {
            try{
                    for(int i = 0; i < lines.length; i++)
                    {
                      camps = lines[i].split(";");
                      mails.add(Mail(
                          id: camps[0],
                          addrres: camps[1],
                          company: camps[2],
                          password: camps[3]));
                    }
      
          } catch (Exeption) {
      
        }
    }
    else if(camps.length==5)
    {

        try {

          for(int i = 0; i < lines.length; i++)
          {
            camps = lines[i].split(";");
            line.add(LineSend(
                id: camps[0],
                date:camps[1],
                factory:camps[2] ,
                observations: camps[3] ,
                state: manageState.parseState(camps[4],context,true),)
                );
          }
         
        } catch (Exeption) {

        }

    }
    else if(camps.length==6)
    {

      try {

        for(int i = 0; i < lines.length; i++)
        {
          camps = lines[i].split(";");
          conections.add(Conection(
              id: camps[0],
              database: camps[1],
              host: camps[2],
              port: camps[3],
              user: camps[4],
              password: camps[5]
          ));
        }
        
      } catch (Exeption) {

      }


     }
     else if(camps.length==14)
     {
        try {
          for(int i = 0; i < lines.length; i++) {
            camps = lines[i].split(";");
            factories.add(Factory(
              id: camps[0],
              name: camps[1],
              highDate: camps[2],
              sector: camps[3],
              thelephones: [camps[4], camps[5]],
              mail: camps[6],
              web: camps[7],
              address: {
                'street': camps[8],
                'number': camps[9],
                'apartament': camps[10],
                'city': camps[11],
                'postalCode': camps[12],
                'province': camps[13],
              },
            ));
          }
       } catch (Exeption) {

         }
     }
     else
     {
        String action =S.of(context).file_not_found;
        error(context, action);
     }

  }





