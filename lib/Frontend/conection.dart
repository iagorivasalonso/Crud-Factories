import 'dart:io';
import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Alertdialogs/confirmDelete.dart';
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Backend/CSV/chargueData%20csv.dart';
import 'package:crud_factories/Backend/Global/controllers/Conection.dart';
import 'package:crud_factories/Backend/Global/files.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/SQL/importEmpleoye.dart';
import 'package:crud_factories/Backend/SQL/importSector.dart';
import 'package:crud_factories/Backend/SQL/manageSQl.dart';
import 'package:crud_factories/Backend/SQL/importFactories.dart';
import 'package:crud_factories/Backend/SQL/importLines.dart';
import 'package:crud_factories/Backend/SQL/importMail.dart';
import 'package:crud_factories/Backend/SQL/serverConected.dart';
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Backend/CSV/exportConections.dart';
import 'package:crud_factories/Functions/createId.dart';
import 'package:crud_factories/Functions/validatorCamps.dart';
import 'package:crud_factories/Objects/Conection.dart';
import 'package:crud_factories/Widgets/headViewsAndroid.dart' show appBarAndroid;
import 'package:crud_factories/Widgets/layoutVariant.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:crud_factories/helpers/localization_helper.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

import '../Widgets/dropDownButton.dart';
import '../Widgets/headView.dart';
import '../Widgets/materialButton.dart';
import '../Widgets/textFieldPassword.dart';
import '../Widgets/textfield.dart';

class conection extends StatefulWidget {


   conection();


  State<conection> createState() => _conectionState();
}

class _conectionState extends State<conection> {


  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();

  double widthBar = 10.0;

   late ConectionControler controllers;

   @override
  void initState() {
    super.initState();
    controllers = ConectionControler(
        nameBD: TextEditingController(),
        host: TextEditingController(),
        port: TextEditingController(),
        user: TextEditingController(),
        password: TextEditingController()
    );
  }
  
  void dispose ()  {
     controllers.nameBD.dispose();
     controllers.host.dispose();
     controllers.port.dispose();
     controllers.user.dispose();
     controllers.password.dispose();
   }
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
  Widget build(BuildContext context0) {

    BuildContext context = Platform.isWindows ? context1 : context0;

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

          controllers.nameBD.text = conections[i].database;
          controllers.host.text = conections[i].host;
          controllers.port.text = conections[i].port;
          controllers.user.text = conections[i].user;
          controllers.password.text = conections[i].password;
          nameBDOld = conections[i].database;
          editText = false;
        }
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
          underSpacing: const EdgeInsets.only(bottom: 8),
          child: SingleChildScrollView(
            controller: verticalScroll,
            scrollDirection: Axis.vertical,
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
                        headView(
                            title: S.of(context).database_connection
                        ),

                    layoutVariant(
                        items:
                         [
                           Padding(
                             padding: const EdgeInsets.only(left: 30.0,top: 30.0),
                             child: SizedBox(
                               width: 700,
                               height: 40,
                               child: GenericDropdown<Conection>(
                                 items: conections,
                                 camp: S.of(context).database_connection,
                                 selectedItem: selectedConection,
                                 hint: S.of(context).newFemale,
                                 itemLabel: (Conection) => Conection.database,
                                 onChanged: (conectionChoose) => _onConectionChanged(context,conectionChoose),
                               ),
                             ),
                           ),

                           Padding(
                             padding: const EdgeInsets.only(top: 30.0),
                             child: materialButton(
                               nameAction: S.of(context).edit,
                               function: () => _onSelectAction(context),

                             ),
                           ),
                         ]),

                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: SizedBox(
                              width: 350,
                              child: defaultTextfield(
                                nameCamp: S.of(context).data_base,
                                controllerCamp: controllers.nameBD,
                                campEdit:editText
                              ),
                            ),
                          ),
                        ),

                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: layoutVariant(
                            items:  [
                              Expanded(
                                child: defaultTextfield(
                                  nameCamp: S.of(context).host,
                                  controllerCamp: controllers.host,
                                  campEdit:editText
                                ),
                              ),
                              Expanded(
                                child: defaultTextfield(
                                  nameCamp: S.of(context).port,
                                  controllerCamp: controllers.port,
                                  campEdit:editText
                                ),
                              ),
                            ]
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: layoutVariant(
                            items:  [
                              Expanded(
                                child: defaultTextfield(
                                  nameCamp: S.of(context).user,
                                  controllerCamp: controllers.user,
                                  campEdit:editText
                                ),
                              ),
                              Expanded(
                                child: textfieldPassword(
                                  nameCamp: S.of(context).password,
                                  controllerCamp: controllers.password,
                                  campEdit:editText
                                ),
                              ),
                            ]),
                      ),

                        Padding(
                          padding: const EdgeInsets.only(left: 620.0,top:  20.0),
                          child: layoutVariant(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            items: [
                              materialButton(
                                nameAction: action1,
                                function: () => _onConect(context),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: materialButton(
                                  nameAction: action2,
                                  function: () => _onDelete(context),

                                ),
                              ),
                            ],
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
    )
      : Scaffold(
        appBar: appBarAndroid(context, name: S.of(context).database_connection),
         body: Text("conection"),
       );
  }


  Future<void> _onConectionChanged(BuildContext context, Conection? conectionChoose) async {

    setState(() {

      try{

        action1 = S.of(context).connect;
        select=int.parse(conectionChoose!.id)-1;

        selectedConection = conectionChoose;
        controllers.nameBD.text = conectionChoose.database;
        controllers.host.text = conectionChoose.host;
        controllers.port.text = conectionChoose.port;
        controllers.user.text = conectionChoose.user;
        controllers.password.text = conectionChoose.password;

        conectionLast = selectedConection;

        host = controllers.host.text;
        port = int.parse(controllers.port.text);
        user = controllers.user.text;
        password = controllers.password.text;
        bdName = controllers.nameBD.text;
        nameBDOld = conectionChoose.database;

      }catch(exeption){
        String err = S.of(context).database_connection;
        error(context, err);
        print(exeption);
      }

    });

  }
  Future<void> _onSelectAction(BuildContext context) async{

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
  }

  Future<void> _onConect(BuildContext context) async {

    String bd_action = "";
    String db = "";

    try{

      host = controllers.host.text;
      port = int.parse(controllers.port.text);
      user = controllers.user.text;
      password = controllers.password.text;
      bdName = controllers.nameBD.text;

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

        if (validatorCamps.primaryKeyCorrect(controllers.nameBD.text, nameCamp,allKeys, campOld, context) == true)
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
                database: controllers.nameBD.text,
                port: controllers.port.text,
                host: controllers.host.text,
                user: controllers.user.text,
                password: controllers.password.text
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

            conections[select].database = controllers.nameBD.text;
            conections[select].port = controllers.port.text;
            conections[select].host = controllers.host.text;
            conections[select].user = controllers.user.text;
            conections[select].password = controllers.password.text;

            bd_action = S.of(context).edit;

            db = nameBDOld;
          }
        }
      }
      else if(action1 == S.of(context).save)
      {
        bd_action = S.of(context).save;
        db = controllers.nameBD.text;

        setState(() {
          action0 = S.of(context).edit;
          action1 = S.of(context).disconnect;
          action2 = S.of(context).delete;
        });
      }

      if(conn != null && action0 != S.of(context).volver)
      {
        bd_action = S.of(context).disconnect;
        db = "";
      }
      else if(action1 == S.of(context).connect)
      {
        bd_action = S.of(context).connection;
        db = controllers.nameBD.text;
      }

      actionsDB(bd_action,db, context);
      saveChanges = false;

    }catch(Exception){

      String action = "";

      if (controllers.nameBD.text.isEmpty || controllers.host.text.isEmpty || controllers.port.text.isEmpty || controllers.user.text.isEmpty || controllers.password.text.isEmpty)
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

  }
 Future<void> _onDelete(BuildContext context) async {

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

                controllers.nameBD.text = "";
                controllers.port.text = "";
                controllers.host.text = "";
                controllers.user.text = "";
                controllers.password.text = "";

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
          sqlImportLines(context);

          setState(() {
            action1 = S.of(context).connect;
          });
        }
      }
    }
    else if (bd_action==S.of(context).save)
    {
      String NameBDNew = controllers.nameBD.text;
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

