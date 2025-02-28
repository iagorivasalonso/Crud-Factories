import 'dart:io';

import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Alertdialogs/confirmDelete.dart';
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Backend/CSV/chargueData%20csv.dart';
import 'package:crud_factories/Backend/SQL/importEmpleoye.dart';
import 'package:crud_factories/Backend/SQL/importSector.dart';
import 'package:crud_factories/Backend/SQL/manageSQl.dart';
import 'package:crud_factories/Backend/SQL/importFactories.dart';
import 'package:crud_factories/Backend/SQL/importLines.dart';
import 'package:crud_factories/Backend/SQL/importMail.dart';
import 'package:crud_factories/Backend/SQL/serverConected.dart';
import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Backend/CSV/exportConections.dart';
import 'package:crud_factories/Functions/createId.dart';
import 'package:crud_factories/Functions/validatorCamps.dart';
import 'package:crud_factories/Objects/Conection.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:crud_factories/helpers/localization_helper.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

class conection extends StatefulWidget {

  BuildContext context;

   conection(this.context);


  State<conection> createState() => _conectionState();
}

class _conectionState extends State<conection> {


  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();

  double widthBar = 10.0;

  late TextEditingController controllerNameBD = new TextEditingController();
  late TextEditingController controllerHost = new TextEditingController();
  late TextEditingController controllerPort = new TextEditingController();
  late TextEditingController controllerUser = new TextEditingController();
  late TextEditingController controllerPas = new TextEditingController();



  int select = - 1;
  String action0 = "";
  String action1 = "";
  String action2 = "";

  String bdName = "";
  String host = "";
  int port = 0;
  String user = "";
  String password = "";
  String nameBDOld = "";
  bool serverconnected = false;
  bool editText = true;
  bool modify= false;
  Conection? selectedConection;
  Conection? conectionLast;
  bool conectNew = false;


  @override
  Widget build(BuildContext context) {

    BuildContext context = widget.context;

    if(action0.isEmpty)
    {
      action0 = S.of(context).edit;
    }

    if (!conections.contains(selectedConection))
    {
      selectedConection = null;
    }

     if(action1.isEmpty)
     {
       action1 = S.of(context).newFemale;
     }

    if(action2.isEmpty)
    {
      action2 = S.of(context).delete;
    }


    if(conn != null && action0 == S.of(context).edit)
    {
      action1 = S.of(context).disconnect;

      for(int i = 0; i <conections.length; i++)
      {

        if(BaseDateSelected==conections[i].database)
        {
          selectedConection= conections[i];

          controllerNameBD.text = conections[i].database;
          controllerHost.text = conections[i].host;
          controllerPort.text = conections[i].port;
          controllerUser.text = conections[i].user;
          controllerPas.text = conections[i].password;
          nameBDOld = conections[i].database;
          editText = false;
        }
      }
    }

    return Scaffold(
      body: AdaptiveScrollbar(
        controller: verticalScroll,
        width: widthBar,
        child: AdaptiveScrollbar(
          controller: horizontalScroll,
          width: widthBar,
          position: ScrollbarPosition.bottom,
          underSpacing: const EdgeInsets.only(bottom: 8),
          child: SingleChildScrollView(
            controller: verticalScroll,
            scrollDirection: Axis.vertical,
            child: SizedBox(
              width: 2000,
              child: SingleChildScrollView(
                controller: horizontalScroll,
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  height: 478,
                  width: 850,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child:  Padding(
                      padding: const EdgeInsets.only(left: 30.0,top: 30.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Text(S.of(context).database_connection,
                                  style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top:20.0, bottom: 30.0,left: 20.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Text(S.of(context).database_connection),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0, right: 120.0),
                                  child: SizedBox(
                                    width: 350,
                                    height: 40,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2<Conection>(
                                        hint:  Text(S.of(context).newFemale),
                                        items: conections.map((Conection itemConection) => DropdownMenuItem<Conection>(
                                          value:  itemConection,
                                          child: Text(itemConection.database),
                                        )).toList(),
                                        value: selectedConection,
                                        onChanged: (Conection? conectionChoose) {
                                          setState(() {

                                            try{

                                              action1 = S.of(context).connect;
                                              select=int.parse(conectionChoose!.id)-1;

                                              selectedConection = conectionChoose;
                                              controllerNameBD.text = conectionChoose!.database;
                                              controllerHost.text = conectionChoose!.host;
                                              controllerPort.text = conectionChoose!.port;
                                              controllerUser.text = conectionChoose!.user;
                                              controllerPas.text = conectionChoose!.password;

                                              conectionLast = selectedConection;

                                              host = controllerHost.text;
                                              port = int.parse(controllerPort.text);
                                              user = controllerUser.text;
                                              password = controllerPas.text;
                                              bdName = controllerNameBD.text;
                                              nameBDOld = conectionChoose!.database;

                                            }catch(exeption){
                                              String err = S.of(context).database_connection;
                                              error(context, err);
                                              print(exeption);
                                            }

                                          });
                                        },
                                        buttonStyleData: const ButtonStyleData(
                                          height: 50,
                                          width: 350,
                                          padding: EdgeInsets.only(left: 14, right: 14),
                                        ),
                                        dropdownStyleData: DropdownStyleData(
                                          maxHeight: 200,
                                          width: 330,
                                          scrollbarTheme: ScrollbarThemeData(
                                            thickness: MaterialStateProperty.all(6),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                MaterialButton(
                                    color: Colors.lightBlue,
                                    child: Text(action0,
                                      style: TextStyle(color: Colors.white),),
                                    onPressed: (){
                                      setState(() {

                                        if(conn != null)
                                        {

                                              if(action0==S.of(context).volver)
                                              {
                                                  editText = false;
                                                  action0 = S.of(context).edit;
                                                  action1 = S.of(context).disconnect;
                                                  action2 = S.of(context).delete;
                                              }
                                              else
                                              {
                                                  editText = true;
                                                  action0 = S.of(context).volver;
                                                  action1 = S.of(context).save;
                                                  action2 = S.of(context).cancel;
                                              }
                                        }
                                        else
                                        {
                                          String action1 = S.of(context).not_connected_to_any_database;
                                          error(context, action1);
                                        }
                                      });
                                    })
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top:20.0, bottom: 30.0,left: 20.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Text(S.of(context).data_base),
                                ),
                                SizedBox(
                                  width: 170,
                                  height: 40,
                                  child: TextField(
                                    controller: controllerNameBD,
                                    enabled: editText,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:20.0, bottom: 30.0,left: 20.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Text(S.of(context).host),
                                ),
                                SizedBox(
                                  width: 170,
                                  height: 40,
                                  child: TextField(
                                    controller: controllerHost,
                                    enabled: editText,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                    onChanged: (s) {
                                      if(saveChanges == false)
                                      {
                                        if(select != -1)
                                        {
                                          if(controllerHost.text == conections[select].host)
                                          {
                                            saveChanges = false;
                                          }
                                          else
                                          {
                                            saveChanges = true;
                                          }
                                        }
                                        else
                                        {
                                          if(controllerHost.text.isEmpty)
                                          {
                                            saveChanges = false;
                                          }
                                          else
                                          {
                                            saveChanges = true;
                                          }
                                        }
                                      }
                                    },
                                  ),
                                ),
                               Padding(
                                  padding: EdgeInsets.only(right: 10.0, left: 190.0),
                                  child: Text(S.of(context).port),
                                ),
                                SizedBox(
                                  width: 100,
                                  height: 40,
                                  child: TextField(
                                    controller: controllerPort,
                                    enabled: editText,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                    onChanged: (s) {
                                      if(saveChanges == false)
                                      {
                                        if(select != -1)
                                        {
                                          if(controllerPort.text == conections[select].port)
                                          {
                                            saveChanges = false;
                                          }
                                          else
                                          {
                                            saveChanges = true;
                                          }
                                        }
                                        else
                                        {
                                          if(controllerPort.text.isEmpty)
                                          {
                                            saveChanges = false;
                                          }
                                          else
                                          {
                                            saveChanges = true;
                                          }
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:20.0, bottom: 30.0,left: 20.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Text(S.of(context).user),
                                ),
                                SizedBox(
                                  width: 170,
                                  height: 40,
                                  child: TextField(
                                    controller: controllerUser,
                                    enabled: editText,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                    onChanged: (s) {
                                      if(saveChanges == false)
                                      {
                                        if(select != -1)
                                        {
                                          if(controllerUser.text == conections[select].user)
                                          {
                                            saveChanges = false;
                                          }
                                          else
                                          {
                                            saveChanges = true;
                                          }
                                        }
                                        else
                                        {
                                          if(controllerUser.text.isEmpty)
                                          {
                                            saveChanges = false;
                                          }
                                          else
                                          {
                                            saveChanges = true;
                                          }
                                        }
                                      }
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 10.0, left: 170.0),
                                  child: Text(S.of(context).password),
                                ),
                                SizedBox(
                                  width: 170,
                                  height: 40,
                                  child: TextField(
                                    controller: controllerPas,
                                    enabled: editText,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                    onChanged: (s) {
                                      if(saveChanges == false)
                                      {
                                        if(select != -1)
                                        {
                                          if(controllerPas.text == conections[select].password)
                                          {
                                            saveChanges = false;
                                          }
                                          else
                                          {
                                            saveChanges = true;
                                          }
                                        }
                                        else
                                        {
                                          if(controllerPas.text.isEmpty)
                                          {
                                            saveChanges = false;
                                          }
                                          else
                                          {
                                            saveChanges = true;
                                          }
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 600, top: 8),
                            child: SizedBox(
                              width: 190,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  MaterialButton(
                                    color: Colors.lightBlue,
                                    child: Text(action1,
                                        style: TextStyle(color: Colors.white)
                                    ),
                                    onPressed: () async {
                                      String bd_action = "";
                                      String db = "";

                                      try{

                                        host = controllerHost.text;
                                        port = int.parse(controllerPort.text);
                                        user = controllerUser.text;
                                        password = controllerPas.text;
                                        bdName = controllerNameBD.text;

                                        if(action1 == S.of(context).newFemale)
                                        {
                                          List <String> allKeys = [];

                                          String nameCamp = S.of(context).data_base;

                                          for (int i = 0; i < conections.length; i++)
                                          {
                                            allKeys.add(conections[i].database);
                                          }


                                          String campOld = " ";

                                          if(action1 != S.of(context).newFemale)
                                          {
                                            campOld =conections[select].database;
                                          }

                                          if (primaryKeyCorrect(controllerNameBD.text, nameCamp,allKeys, campOld, context) == true)
                                          {
                                            String idNew = "";

                                            if(action1 == S.of(context).newFemale)
                                            {
                                              if(conections.isNotEmpty)
                                              {
                                                String idLast = conections[conections.length-1].id;
                                                idNew = createId(idLast);
                                              }
                                              else
                                              {
                                                idNew ="1";
                                              }

                                              conections.add(Conection(
                                                  id: idNew,
                                                  database: controllerNameBD.text,
                                                  port: controllerPort.text,
                                                  host: controllerHost.text,
                                                  user: controllerUser.text,
                                                  password: controllerPas.text
                                              ));


                                              modify = false;

                                              ///create bd
                                              bd_action = S.of(context).newFemale;
                                              db = "test";
                                              
                                              setState(() {
                                                action1 = S.of(context).connect;
                                              });


                                            }
                                            if(action1 == S.of(context).save)
                                            {

                                              conections[select].database = controllerNameBD.text;
                                              conections[select].port = controllerPort.text;
                                              conections[select].host = controllerHost.text;
                                              conections[select].user = controllerUser.text;
                                              conections[select].password = controllerPas.text;

                                              bd_action = S.of(context).edit;

                                              db = nameBDOld;
                                            }
                                          }
                                        }
                                        else if(action1 == S.of(context).save)
                                        {
                                          bd_action = S.of(context).save;
                                          db = controllerNameBD.text;
                                        }

                                        if(conn != null && action0 != S.of(context).volver)
                                        {
                                          bd_action = S.of(context).disconnect;
                                          db = "";
                                        }
                                        else if(action1 == S.of(context).connect)
                                        {
                                          bd_action = S.of(context).connection;
                                          db = controllerNameBD.text;
                                        }

                                        actionsDB(bd_action,db, context);
                                        saveChanges = false;

                                      }catch(Exception){

                                            String action = "";

                                            if (controllerNameBD.text.isEmpty || controllerHost.text.isEmpty || controllerPort.text.isEmpty || controllerUser.text.isEmpty || controllerPas.text.isEmpty)
                                            {
                                              action = S.of(context).can_not_go_blank_fields;
                                              error(context, action);
                                            }
                                            else
                                            {
                                              action = S.of(context).sql_error;
                                              error(context, action);
                                            }
                                      }
                                    },
                                  ),
                                  MaterialButton(
                                    color: Colors.lightBlue,
                                    child:  Text(action2,
                                      style:  TextStyle(color: Colors.white),),
                                    onPressed: () async{
                                      String err ="";
                                      try{

                                        if(conn != null)
                                        {
                                          if(action2 == S.of(context).delete)
                                          {
                                            String nameBD = conections[select].database;
                                            String title = S.of(context).data_base;
                                            String action1="$title $nameBD";
                                            bool confirm1 = await confirmDelete(context, action1);


                                            if(confirm1 == true)
                                            {

                                              err = await deleteDB(context, nameBD,conn);

                                              if(err.isEmpty)
                                              {

                                                setState(() {
                                                  conn = null;
                                                  action1 =  S.of(context).newFemale;

                                                  selectedConection = null;

                                                  controllerNameBD.text = "";
                                                  controllerPort.text = "";
                                                  controllerHost.text = "";
                                                  controllerUser.text = "";
                                                  controllerPas.text = "";

                                                  editText = true;

                                                });

                                                conections.removeAt(select);
                                                action1 = S.of(context).connection_has_been_successfully_deleted;
                                                confirm(context,action1);
                                              }

                                            }
                                          }

                                        }
                                        else
                                        {
                                          String action1 = S.of(context).not_connected_to_any_database;
                                          error(context, action1);
                                        }

                                        saveChanges = false;

                                      }catch(Exeption){
                                        err = S.of(context).could_not_be_deleted;
                                        error(context, err);
                                      }


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
  actionsDB(String bd_action, String db, BuildContext context) async {

    var settings;

    try {

      settings = ConnectionSettings(
        host: host,
        port: port,
        user: user,
        password: password,
        db: db,
      );
      conn = await MySqlConnection.connect(settings);

    } on Exception catch( e){

      if(bd_action == S.of(context).newFemale ||  bd_action == S.of(context).connection)
      {
            if(await fServer.exists())
            {
                serverconnect();
            }
            else
            {
                String action = S.of(context).has_no_server_connected;
                error(context, action);
            }

      }

      try{
        sleep(Duration(seconds:5));
        conn = await MySqlConnection.connect(settings);

      } catch(exeption){

        if(bd_action == S.of(context).newFemale ||  bd_action == S.of(context).connection)
        {
          String err = S.of(context).There_is_no_connection_to_the_server;
          error(context, err);
        }

      }


    } catch(SQLExeption){


      String type = S.of(context).sql_error;

      if(SQLExeption.toString().contains("Unknown database"))
      {
        if(bd_action != S.of(context).save)
        {
          String nName =  S.of(context).there_is_no_database_with_that_name;
          type = "$nName $db";
        }
      }
      if(SQLExeption.toString().contains("is not allowed to connect to this MySQL server"))
      {
        type =  S.of(context).could_not_connect_with_the_server;
      }
      if(SQLExeption.toString().contains("SocketException: El equipo remoto rechazó la conexión de red."))
      {
        type =  S.of(context).the_port_is_not_correct;
      }
      if(SQLExeption.toString().contains(" Access denied for user"))
      {
        type =  S.of(context).the_user_or_password_are_incorrect;
      }
      if(type.isNotEmpty)
      {
        error(context, type);
      }

    }

    if (bd_action == S.of(context).newFemale) {
      String err = await createDB(context, bdName, conn);
      conn = null;

      if (err.isEmpty) {
        setState(() {
          action1 = S.of(context).connect;
        });
      }
    } else if (bd_action ==S.of(context).disconnect)
    {
      String action = S.of(context).has_closed_the_connection;
      confirm(context, action);
      editText = true;
      conn = null;

      sectors.clear();
      allFactories.clear();
      empleoyes.clear();
      mails.clear();
      allLines.clear();

      setState(() {
        action1 = S.of(context).connect;
      });

      chargueDataCSV(context);
      
    } else if (bd_action == S.of(context).connection)
    {
      if (conn != null)
      {
        String conected = S.of(context).is_connected_to;
        String action1 = '$conected $bdName';
        BaseDateSelected = bdName;


        String err = await createTables(context);
        if (err.isEmpty) {
          confirm(context, action1);
          editText = false;

          sectors.clear();
          allFactories.clear();
          empleoyes.clear();
          mails.clear();
          allLines.clear();

          sqlImportSetors();
          sqlImportFactories();
          sqlImportEmpleoyes();
          sqlImportMails();
          sqlImportLines();

          setState(() {
            action1 = S.of(context).connect;
          });
        }
      }
    }
    else if (bd_action==S.of(context).save)
    {
      String NameBDNew = controllerNameBD.text;
      String err = await editDB(context, nameBDOld, NameBDNew);

      int idSelect = -1;

      for (int i = 0; i < conections.length; i++) {
        if (nameBDOld == conections[i].database) {
          idSelect = i;
        }
      }

      if (err.isEmpty)
      {
          setState(() {
            conections[idSelect].database = NameBDNew;
            csvExportatorConections(conections);
          });

          String array = S.of(context).connection;
          String actionArray = S.of(context).modifiedFemale;
          String action1 = LocalizationHelper.manage_array(context, array, actionArray);

          confirm(context, action1);
          conn = null;

          setState(() {
            editText = false;
            action0 = S.of(context).edit;
            action1 = S.of(context).connect;
            action2 = S.of(context).delete;
          });
      }
    }
  }
}

