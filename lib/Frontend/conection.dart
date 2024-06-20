import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Alertdialogs/confirmDelete.dart';
import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Backend/exportConections.dart';
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

  String BaseDateSelected ="Nuevo";
  Conection? selectedConection = null;

  bool modify= false;
  String action = "Nueva";
  int select = - 1;

  @override
  Widget build(BuildContext context) {

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
                                          action = "Modificar";
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
                                       setState(()  {

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
                                                   String action ='La conexion se ha creado correctamente';
                                                   confirm(context,action);
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

                                                       String action ='La conexion se ha modificado correctamente';
                                                       confirm(context,action);

                                                    }
                                               }

                                       });
                                       /*
                                       var settings = ConnectionSettings(
                                           host: 'localhost',
                                           port: 3307,
                                           user: 'root',
                                           password:'usbw',
                                           db:'bd_factories'
                                       );
                                       print(conn);
                                      conn = await MySqlConnection.connect(settings);

                                       await conn.query('CREATE TABLE IF NOT EXISTS factories '
                                           '(id int NOT NULL AUTO_INCREMENT PRIMARY KEY,'
                                           ' name varchar(255) NOT NULL, '
                                           ' date varchar(12) NOT NULL,'
                                           ' telephone1 varchar(9) NOT NULL,'
                                           ' telephone2 varchar(9) NOT NULL,'
                                           ' email varchar(50) NOT NULL,'
                                           ' web varchar(100) NOT NULL,'
                                           ' address varchar(255) NOT NULL, '
                                           ' number varchar(4) NOT NULL,'
                                           ' apartament varchar(10) NOT NULL,'
                                           ' city varchar(10) NOT NULL, '
                                           ' postalcode varchar(5) NOT NULL, '
                                           ' empleoyes varchar(4))'
                                       );

                                      await conn.query('CREATE TABLE IF NOT EXISTS mails '
                                          '(id int NOT NULL AUTO_INCREMENT PRIMARY KEY,'
                                          ' email varchar(255) NOT NULL, '
                                          ' company varchar(12) NOT NULL,'
                                          ' password varchar(100) NOT NULL)'
                                      );

                                       await conn.query('CREATE TABLE IF NOT EXISTS lineSends '
                                           '(id int NOT NULL AUTO_INCREMENT PRIMARY KEY,'
                                           ' date varchar(12) NOT NULL, '
                                           ' factory varchar(255) NOT NULL,'
                                           ' state varchar(20) NOT NULL,'
                                           ' observations varchar(100) NOT NULL)'
                                       );*/
                                       print(conections);
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