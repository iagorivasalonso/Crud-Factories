import 'dart:io';
import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import '../Alertdialogs/campRepeat.dart';
import '../Alertdialogs/confirm.dart';
import '../Functions/avoidRepeatCamp.dart';
import '../Objects/Mail.dart';


class newMail extends StatefulWidget {

  List<Mail> mails;
  int select;

  newMail(this.mails, this.select);


  State<newMail> createState() => _newMailState();
}

class _newMailState extends State<newMail> {

  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();

  double widthBar = 10.0;

  late TextEditingController controllerMail = new TextEditingController();
  late TextEditingController controllerCompany = new TextEditingController();
  late TextEditingController controllerPas = new TextEditingController();
  late TextEditingController controllerPasVerificator = new TextEditingController();
  late List<Mail> mails;
  late int select;
  bool edit = false;

  @override
  Widget build(BuildContext context) {


    mails = widget.mails;
    select = widget.select;

    String action = "";
    String title = "";

    if(select == -1)
    {
      title = "Nuevo ";
      action = "Crear";
    }
    else
    {

        controllerMail.text = mails[select].addrres;
        controllerCompany.text = mails[select].company;
        controllerPas.text = mails[select].password;

      title = "Editar ";
      action = "Actualizar";
    }
    return AdaptiveScrollbar(
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
                height: 475,
                width: 890,
                child:  Align(
                  alignment: Alignment.topRight,
                  child:  Padding(
                    padding: const EdgeInsets.only(left: 30.0,top: 30.0),
                    child: Column(
                      children: [
                         Row(
                          children: [
                            Text('$title Email: ',
                              style: const TextStyle(fontWeight: FontWeight.bold),),
                          ],
                        ),
                      Padding(
                          padding: const EdgeInsets.only(left:30, top:20.0,bottom: 30.0),
                          child: Row(
                            children: [
                              const Text('Nuevo email: '),
                              SizedBox(
                                width: 450,
                                height: 40,
                                child: TextField(
                                  controller: controllerMail,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                  ),
                                  onChanged: (value){
                                    edit = true;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      Padding(
                          padding: const EdgeInsets.only(left:30, top:20.0,bottom: 30.0),
                          child: Row(
                            children: [
                              const Text('Compañia: '),
                              SizedBox(
                                width: 200,
                                height: 40,
                                child: TextField(
                                  controller: controllerCompany,
                                  decoration:const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      Padding(
                          padding: const EdgeInsets.only(left:30, top:20.0, bottom: 30.0),
                          child: Row(
                            children: [
                              const Text('Contraseña: '),
                              SizedBox(
                                width: 400,
                                height: 40,
                                child: TextField(
                                  //obscureText: true,
                                  controller: controllerPas,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                       ),
                       Padding(
                          padding: const EdgeInsets.only(left:30, top:20.0, bottom: 20.0),
                          child: Row(
                            children: [
                              const Text('Verificar contraseña: '),
                              SizedBox(
                                width: 400,
                                height: 40,
                                child: TextField(
                                  obscureText: true,
                                  controller: controllerPasVerificator,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 600),
                          child: SizedBox(
                            width: 200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  child: Text(action),
                                  onPressed: () {
                                    setState(() {
                                      bool repeat= false;
                                      bool correctPass= false;
                                      String encriptedPas="";
                                      List<String> campSearch=[];

                                      for(int i = 0; i <mails.length; i++)
                                      {
                                        campSearch.add(mails[i].addrres);
                                      }
                                      bool repeat1=avoidRepeteatCamp(context, repeat,campSearch, controllerMail, select);

                                      if(repeat1 == true)
                                      {
                                        action ='El correo electronico ya se encuentra en la base de datos';
                                        campRepeat(context,action);
                                      }
                                      else
                                      {
                                           if(controllerPas.text != controllerPasVerificator.text)
                                           {
                                               action ='Las contraseñas no coinciden';
                                               campRepeat(context,action);

                                               correctPass= false;
                                           }
                                           else
                                           {
                                             final plainText =controllerPas.text;
/*
                                             final key = encrypt.Key.fromLength(32);
                                             final iv = encrypt.IV.fromLength(16);
                                             final encrypter = encrypt.Encrypter(encrypt.AES(key));

                                             controllt =encrypter as String;
                                             final encrypted = encrypter.encrypt(plainText, iv: iv);

                                             encriptedPas= key.base64;
                                           //  final decrypted = encrypter.decrypt(encrypted, iv: iv);
                                             correctPass= true;
*/
                                           }
                                      }

                                      if(repeat==false && correctPass ==true)
                                      {
                                        if(select == -1)
                                        {
                                          mails.add(Mail(
                                              id: mails.length.toString(),
                                              company:controllerMail.text,
                                              addrres: controllerCompany.text,
                                              password:encriptedPas
                                          ));
                                          String action ='El correo se ha dado de alta correctamente';
                                          confirm(context,action);
                                        }
                                        else
                                        {
                                          mails[select].addrres = controllerMail.text;
                                          mails[select].company = controllerCompany.text;
                                          mails[select].password = controllerPas.text;


                                          String action ='El correo se ha modificado correctamente';
                                          confirm(context,action);
                                        }
                                      }

                                        csvExportator(mails,select);

                                    });
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
  csvExportator(List<Mail> mails, int select) async {

    File myFile = File('D:/mails.csv');

    List<dynamic> associateList = [

      for (int i = 0; i <mails.length;i++)
        {

          "id": mails[i].id,
          "addrres": mails[i].addrres,
          "company": mails[i].company,
          "password": mails[i].password

        },
    ];

    List<List<dynamic>> rows = [];
    List<dynamic> row = [];


    for (int i = 0; i < associateList.length; i++) {
      List<dynamic> row = [];

      row.add(associateList[i]["id"]);
      row.add(associateList[i]["addrres"]);
      row.add(associateList[i]["company"]);
      row.add(associateList[i]["password"]);
      rows.add(row);

    }

    String csv = const ListToCsvConverter().convert(rows);
   myFile.writeAsString(csv);


  }
}
