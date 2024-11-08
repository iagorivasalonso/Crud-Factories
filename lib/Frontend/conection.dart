import 'dart:io';

import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Alertdialogs/confirmDelete.dart';
import 'package:crud_factories/Alertdialogs/confirmEdit.dart';
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Backend/CSV/chargueData%20csv.dart';
import 'package:crud_factories/Backend/SQL/importEmpleoye.dart';
import 'package:crud_factories/Backend/SQL/importSector.dart';
import 'package:crud_factories/Backend/SQL/manageSQl.dart';
import 'package:crud_factories/Backend/SQL/importFactories.dart';
import 'package:crud_factories/Backend/SQL/importLines.dart';
import 'package:crud_factories/Backend/SQL/importMail.dart';
import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Backend/CSV/exportConections.dart';
import 'package:crud_factories/Functions/createId.dart';
import 'package:crud_factories/Functions/validatorCamps.dart';
import 'package:crud_factories/Objects/Conection.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

class conection extends StatefulWidget {


  @override
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
  String action0 = "Editar";
  String action1 = "Nueva";
  String action2 = "Eliminar";

  String bdName = "";
  String host = "";
  int port = 0;
  String user = "";
  String password = "";
  String nameBDOld = "";
  bool serverConnected = false;
  bool editText = true;
  bool modify= false;
  Conection? selectedConection;




  bool conectNew = false;


  @override
  Widget build(BuildContext context) {

    if(conn != null && action0 == "Editar")
    {
      action1 = "Desconectar";

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
                          const Row(
                            children: [
                              Text('Conexion base de datos: ',
                                style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top:20.0, bottom: 30.0,left: 20.0),
                            child: Row(
                              children: [
                                Text('Conexion: '),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0, right: 120.0),
                                  child: SizedBox(
                                    width: 350,
                                    height: 40,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2<Conection>(
                                        hint:  Text("Nueva"),
                                        items: conections.map((Conection itemConection) => DropdownMenuItem<Conection>(
                                          value:  itemConection,
                                          child: Text(itemConection.database),
                                        )).toList(),
                                        value: selectedConection,
                                        onChanged: (Conection? conectionChoose) {
                                          setState(() {
                                            try{

                                              action1 = "Conectar";
                                              select=int.parse(conectionChoose!.id)-1;
                                              selectedConection = conectionChoose;
                                              controllerNameBD.text = conectionChoose!.database;
                                              controllerHost.text = conectionChoose!.host;
                                              controllerPort.text = conectionChoose!.port;
                                              controllerUser.text = conectionChoose!.user;
                                              controllerPas.text = conectionChoose!.password;

                                              host = controllerHost.text;
                                              port = int.parse(controllerPort.text);
                                              user = controllerUser.text;
                                              password = controllerPas.text;
                                              bdName = controllerNameBD.text;
                                              nameBDOld = conectionChoose!.database;

                                            }catch(exeption){
                                              String err ="Conexion no valida";
                                              error(context, err);
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
                                             if(action0=="Volver")
                                             {
                                               action0 = "Editar";
                                               editText = false;
                                               action1 = "Desconectar";
                                               action2 = "Eliminar";
                                             }
                                             else
                                             {
                                                 action0 = "Volver";
                                                 editText = true;
                                                 action1 = "Guardar";
                                                 action2 = "Cancelar";
                                             }


                                           }
                                           else
                                           {
                                             String action1 ="No esta conectado a ninguna base de datos";
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
                                Text('Base de datos: '),
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
                               const Text('Host: '),
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
                                const Padding(
                                  padding: EdgeInsets.only(left: 190.0),
                                  child: Text('Puerto: '),
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
                                const Text('Usuario: '),
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
                                const Padding(
                                  padding: EdgeInsets.only(left: 170.0),
                                  child: Text('Contraseña: '),
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

                                        if(action1 == "Nueva")
                                        {
                                             List <String> allKeys = [];

                                             String nameCamp = "base de datos";

                                             for (int i = 0; i < conections.length; i++)
                                             {
                                               allKeys.add(conections[i].database);
                                             }


                                             String campOld = " ";

                                             if(action1 != "Nueva")
                                             {
                                                campOld =conections[select].database;
                                             }

                                             if (primaryKeyCorrect(controllerNameBD.text, nameCamp,allKeys, campOld, context) == true)
                                             {
                                               String idNew = "";

                                               if(action1 == "Nueva")
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
                                                   String action1 ='La conexion se ha creado correctamente';
                                                   confirm(context,action1);

                                                   modify = false;

                                                   ///create bd
                                                     bd_action ="Nueva";
                                                     db = "test";
                                                     actionsDB(bd_action,db);

                                                      setState(() {
                                                        action1 ="Conectar";
                                                      });


                                               }
                                               if(action1 == "Guardar")
                                               {

                                                   conections[select].database = controllerNameBD.text;
                                                   conections[select].port = controllerPort.text;
                                                   conections[select].host = controllerHost.text;
                                                   conections[select].user = controllerUser.text;
                                                   conections[select].password = controllerPas.text;

                                                   bd_action ="Edition";
                                                   db = nameBDOld;
                                                  actionsDB(bd_action,db);


                                               }
                                            }
                                        }
                                        else if(action1 == "Guardar") {
                                          bd_action = "Guardar";
                                          db = controllerNameBD.text;
                                          actionsDB(bd_action, db);
                                        }

                                       if(conn != null && action0 != "Volver")
                                       {
                                            bd_action = "Desconection";
                                            db = "";
                                           actionsDB(bd_action,db);
                                       }
                                       else
                                       {
                                          bd_action = "Conection";
                                          db = controllerNameBD.text;
                                          actionsDB(bd_action, db);
                                       }
                                       saveChanges = false;
                                    }catch(Exception ){

                                          String action="No pueden ir campos en blanco";
                                          error(context, action);
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
                                               if(action2 == "Eliminar")
                                               {
                                                 String nameBD = conections[select].database;
                                                 String action1="base de datos $nameBD";
                                                 bool confirm1 = await confirmDelete(context, action1);


                                                 if(confirm1 == true)
                                                 {

                                                   err = await deleteDB(context, nameBD,conn);

                                                   if(err.isEmpty)
                                                   {

                                                     setState(() {
                                                       conn = null;
                                                       action1 = "Nueva";

                                                       selectedConection = null;

                                                       controllerNameBD.text = "";
                                                       controllerPort.text = "";
                                                       controllerHost.text = "";
                                                       controllerUser.text = "";
                                                       controllerPas.text = "";

                                                       editText = true;

                                                     });

                                                     conections.removeAt(select);
                                                     action1 ='Se ha eliminado correctamente la conexion';
                                                     confirm(context,action1);
                                                   }

                                                 }
                                               }

                                          }
                                          else
                                          {
                                            String action1 ="No esta conectado a ninguna base de datos";
                                            error(context, action1);
                                          }
                                          saveChanges = false;
                                        }catch(Exeption ){
                                          err= "no Se pudo eliminar";
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
 actionsDB(String bd_action, String db) async {

    var settings;
    bool connect = true;

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

      if(bd_action == "Nueva" ||bd_action == "Conection")
      {
        serverConnect();
      }

      try{
        sleep(Duration(seconds:5));
        conn = await MySqlConnection.connect(settings);

      } catch(exeption){

        if(bd_action == "Nueva" || bd_action == "Conection")
        {
          String err = "No hay conexion con el servidor";
          error(context, err);
        }

      }


    } catch(SQLExeption){

        String type = "Error Sql";

         if(SQLExeption.toString().contains("Unknown database"))
         {
               if(bd_action != "Guardar")
               {
                 type = "No  base de datos con el nombre $db";
               }
         }
         if(SQLExeption.toString().contains("is not allowed to connect to this MySQL server"))
         {
             type = "No se pudo conectar con el servidor";
         }
         if(SQLExeption.toString().contains("SocketException: El equipo remoto rechazó la conexión de red."))
         {
            type ="El puerto no es correcto";
         }
        if(SQLExeption.toString().contains(" Access denied for user"))
        {
           type = "El usuario o la contraseña son incorrectos";
        }
        if(type.isNotEmpty)
        {
          error(context, type);
        }

    }

       switch(bd_action)
       {
         case "Nueva":

                 String err = await createDB(context, bdName,conn);
                 conn = null;

                 if(err.isEmpty)
                 {
                   setState(() {
                     action1 = "Conectar";
                   });
                 }

           break;

         case "Desconection":

            String action ='Ha cerrado la conexion';
            confirm(context,action);
            editText = true;
            conn = null;

            sectors.clear();
            factories.clear();
            empleoyes.clear();
            mails.clear();
            line.clear();

            setState(() {
              action1 = "Conectar";
            });

            chargueDataCSV();



          break;

         case "Conection":

           if(conn != null)
           {
             String action1 ='Esta conectado a $bdName';
             BaseDateSelected= bdName;
             csvExportatorConections(conections);
             String err = await createTables(context);

             if(err.isEmpty)
             {
               confirm(context,action1);
               editText =false;

               sectors.clear();
               factories.clear();
               empleoyes.clear();
               mails.clear();
               line.clear();

               sqlImportSetors();
               sqlImportFactories();
               sqlImportEmpleoyes();
               sqlImportMails();
               sqlImportLines();

               setState(() {
                 action1 = "Conectar";
               });
             }

           }
           break;

         case "Guardar":

              String NameBDNew = controllerNameBD.text;
              String err = await editDB(context,nameBDOld,NameBDNew);

              int idSelect=-1;

              for(int i = 0; i < conections.length; i++)
              {
                 if(nameBDOld == conections[i].database)
                 {
                    idSelect = i;
                 }
              }
              if(err.isEmpty)
              {
                setState(() {
                  conections[idSelect].database = NameBDNew;
                  csvExportatorConections(conections);
                });

                String action1 = "La conexion fue modificada correctamente";
                confirm(context,action1);
                conn = null;

                setState(() {
                  action0 = "Editar";
                  editText = false;
                  action1 = "Conectar";
                  action2 = "Eliminar";
                });
              }

           break;

       }
  }
}

serverConnect() async {

    var executable = 'D:/';

    if (Platform.isWindows) {
      executable = 'D:/USBWebserver v8.5/8.5/usbwebserver';
    }
    final arguments = <String>[];
    final process = await Process.start(
        executable, arguments, runInShell: true);

}

