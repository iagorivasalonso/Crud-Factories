import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Alertdialogs/confirmDelete.dart';
import 'package:crud_factories/Alertdialogs/confirmEdit.dart';
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Backend/CSV/chargueData%20csv.dart';
import 'package:crud_factories/Backend/SQL/createTables.dart';
import 'package:crud_factories/Backend/SQL/importFactories.dart';
import 'package:crud_factories/Backend/SQL/importLines.dart';
import 'package:crud_factories/Backend/SQL/importMail.dart';
import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Backend/CSV/exportConections.dart';
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

  Conection? selectedConection;

  bool modify= false;
  String action = "Nueva";
  int select = - 1;
  bool editText = true;

  @override
  Widget build(BuildContext context) {

    if(conn!=null)
    {
      action = "Desconectar";

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
           }
        }

       editText = false;
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
                                Text('Base de datos: '),
                                SizedBox(
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
                                          action = "Conectar";
                                          select=int.parse(conectionChoose!.id)-1;
                                          selectedConection = conectionChoose;
                                          controllerNameBD.text = conectionChoose!.database;
                                          controllerHost.text = conectionChoose!.host;
                                          controllerPort.text = conectionChoose!.port;
                                          controllerUser.text = conectionChoose!.user;
                                          controllerPas.text = conectionChoose!.password;

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
                                    onChanged: (s){
                                      modify = true;

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
                                    onChanged: (s){
                                      modify = true;

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
                                    onChanged: (s){
                                      modify = true;

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
                                    onChanged: (s){
                                      modify = true;

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
                                    onChanged: (s){
                                      modify = true;

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
                                      child: Text(action,
                                          style: TextStyle(color: Colors.white)
                                      ),
                                    onPressed: () async {
                                      if(action == "Desconectar")
                                      {
                                        setState(() {
                                          editText = true;
                                          action = "Conectar";
                                        });

                                        String action1 ='Ha cerrado la conexion';
                                        confirm(context,action1);

                                        conn = null;

                                        factories.clear();
                                        mails.clear();
                                        line.clear();

                                        chargueDataCSV();
                                      }
                                      else
                                      {
                                        setState(()  {
                                          if(modify == true || controllerNameBD.text !="")
                                          {

                                            if(action == "Nueva")
                                            {
                                              int idNew = conections.length +1;
                                              conections.add(Conection(
                                                  id: idNew.toString(),
                                                  database: controllerNameBD.text,
                                                  port: controllerPort.text,
                                                  host: controllerHost.text,
                                                  user: controllerUser.text,
                                                  password: controllerPas.text
                                              ));
                                              String action1 ='La conexion se ha creado correctamente';
                                              confirm(context,action1);
                                              modify = false;
                                            }
                                            else
                                            {
                                              if( modify == true)
                                              {
                                                conections[select].database = controllerNameBD.text;
                                                conections[select].port = controllerPort.text;
                                                conections[select].host = controllerHost.text;
                                                conections[select].user = controllerUser.text;
                                                conections[select].password = controllerPas.text;

                                              }
                                            }
                                          }
                                        });
                                        bool edit = false;

                                        if( modify == true)
                                        {
                                          String action1 ='conexion';
                                          edit = await confirmEdit(context,action1);
                                        }

                                        if(modify == false || edit ==true)
                                        {
                                          String host = controllerHost.text;
                                          int port = int.parse(controllerPort.text);
                                          String user = controllerUser.text;
                                          String password = controllerPas.text;
                                          String Bdata = controllerNameBD.text;
                                          
                                          try{
                                            var settings = ConnectionSettings(
                                                host: host,
                                                port: port,
                                                user: user,
                                                password: password,
                                                db: Bdata
                                            );

                                            conn = await MySqlConnection.connect(settings);

                                            if(conn != null)
                                            {
                                              String action1 ='connectado a $Bdata';
                                              confirm(context,action1);
                                              BaseDateSelected= Bdata;

                                              createSql();

                                              factories.clear();
                                              mails.clear();
                                              line.clear();

                                              sqlImportFactories();
                                              sqlImportMails();
                                              sqlImportLines();


                                              setState(() {
                                                editText = false;
                                                action ="Desconectar";
                                              });


                                            }

                                          } catch (SQLException){
                                            String action1 ="no se pudo realizar la conexion";
                                            error(context, action1);
                                          }


                                        }

                                      }

                                       //
                                      csvExportatorConections(conections);
                                       modify = false;


                                    },



                                  ),
                                  MaterialButton(
                                    color: Colors.lightBlue,
                                    child: const Text("Eliminar",
                                      style:  TextStyle(color: Colors.white),),
                                    onPressed: () async{

                                         if(action !=  "Nueva")
                                         {
                                           String action1="base de datos";
                                           bool confirm = await confirmDelete(context, action1);

                                            if(confirm == true)
                                            {
                                              setState(() {
                                                selectedConection=null;
                                              });

                                             conections.removeAt(select);
                                             csvExportatorConections(conections);
                                            }

                                         }

                                           controllerNameBD.text = "";
                                           controllerPort.text = "";
                                           controllerHost.text = "";
                                           controllerUser.text = "";
                                           controllerPas.text = "";




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