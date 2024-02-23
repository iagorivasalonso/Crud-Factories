import 'dart:convert';
import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:flutter/material.dart';
import '../Alertdialogs/campRepeat.dart';
import '../Alertdialogs/confirm.dart';
import '../Backend/exportMails.dart';
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



  @override
  Widget build(BuildContext context) {

    mails = widget.mails;
    select = widget.select;

    String action = "";
    String title = "";

    if (select == -1) {
      title = "Nuevo ";
      action = "Crear";
    }
    else {
      controllerMail.text = mails[select].addrres;
      controllerCompany.text = mails[select].company;

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
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, top: 30.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('$title Email: ',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold),),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, top: 20.0, bottom: 30.0),
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
                                  onChanged: (value) {

                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, top: 20.0, bottom: 30.0),
                          child: Row(
                            children: [
                              const Text('Compañia: '),
                              SizedBox(
                                width: 200,
                                height: 40,
                                child: TextField(
                                  controller: controllerCompany,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, top: 20.0, bottom: 30.0),
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
                          padding: const EdgeInsets.only(
                              left: 30, top: 20.0, bottom: 20.0),
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


                                      bool repeat = false;
                                      bool correctPass = false;
                                      List<String> campSearch = [];

                                      for (int i = 0; i < mails.length; i++) {
                                        campSearch.add(mails[i].addrres);
                                      }

                                      bool repeat1 = avoidRepeteatCamp(context, repeat, campSearch, controllerMail, select);
                                      String encodedPass = " ";

                                      if (repeat1 == true) {
                                        action ='El correo electronico ya se encuentra en la base de datos';
                                        campRepeat(context, action);
                                      } else {

                                        if (controllerPas.text == controllerPasVerificator.text) {
                                          Codec<String,  String> stringToBase64 = utf8.fuse(base64);
                                          encodedPass = stringToBase64.encode(controllerPas.text);

                                          correctPass = true;
                                        }
                                        else {
                                          action =
                                          'Las contraseñas no coinciden';
                                          campRepeat(context, action);

                                          correctPass = false;
                                        }
                                      }


                                      if (select == -1 && correctPass == true) {
                                        mails.add(Mail(
                                            id: mails.length.toString(),
                                            company: controllerMail.text,
                                            addrres: controllerCompany.text,
                                            password: encodedPass
                                        ));

                                        String action = 'El correo se ha dado de alta correctamente';
                                        confirm(context, action);

                                      }else {
                                        mails[select].addrres = controllerMail.text;
                                        mails[select].company = controllerCompany.text;
                                        mails[select].password = encodedPass;

                                        String action = 'El correo se ha modificado correctamente';
                                        confirm(context, action);
                                      }

                                      csvExportator(mails, select);
                                    });
                                  }
                                ),
                                ElevatedButton(
                                  child: const Text('Cancelar'),
                                  onPressed: () {
                                    setState(() {

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
    );
  }
}

