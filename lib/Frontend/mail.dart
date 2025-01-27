import 'dart:convert';
import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Backend/SQL/createMail.dart';
import 'package:crud_factories/Backend/SQL/importMail.dart';
import 'package:crud_factories/Backend/SQL/modifyMail.dart';
import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Backend/CSV/exportMails.dart';
import 'package:crud_factories/Functions/createId.dart';
import 'package:crud_factories/Functions/validatorCamps.dart';
import 'package:crud_factories/Objects/Mail.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:mailer/smtp_server/hotmail.dart';


class newMail extends StatefulWidget {

  int select;

  newMail(this.select);


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


  @override
  Widget build(BuildContext context) {

    int select = widget.select;

    void campCharge() {
          if(saveChanges == false)
          {
              controllerMail.text = mails[select].addrres;
              controllerCompany.text = mails[select].company;
              controllerPas.text = "";
              controllerPasVerificator.text = "";
          }
    }

    String action = "";
    String action2 = "";
    String title = "";

    if (select == -1) {
      title = "Nuevo ";
      action = "Crear";
      action2 = "Borrar";
    }
    else {
      campCharge();
      title = "Editar ";
      action = "Actualizar";
      action2 = "Deshacer";
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
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                    onChanged: (s){
                                      if(saveChanges == false)
                                      {
                                            if(select != -1)
                                            {
                                                if(controllerMail.text == mails[select].addrres)
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
                                                if(controllerMail.text.isEmpty)
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
                            padding: const EdgeInsets.only(
                                left: 30, top: 20.0, bottom: 30.0),
                            child: Row(
                              children: [
                                const Text('Contraseña: '),
                                SizedBox(
                                  width: 400,
                                  height: 40,
                                  child: TextField(
                                    controller: controllerPas,
                                    obscureText: true,
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
                                    controller: controllerPasVerificator,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 600, top: 80),
                            child: SizedBox(
                              width: 200,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  MaterialButton(
                                      color: Colors.lightBlue,
                                      child: Text(action,
                                          style: const TextStyle(
                                              color: Colors.white)
                                      ),
                                      onPressed: () async {

                                        String action = "";

                                        if(controllerMail.text.isEmpty)
                                        {
                                           action = "El campo email no puede ir vacio";
                                           error(context, action);
                                        }
                                        else if(controllerPas.text.isEmpty)
                                        {
                                          action = "El campo contraseña no puede ir vacio";
                                          error(context, action);
                                        }
                                        else if(controllerPasVerificator.text.isEmpty)
                                        {
                                          action = "El campo verificar contraseña no puede ir vacio";
                                          error(context, action);
                                        }
                                        else
                                        {

                                                 final result = await testMail();

                                                 if (result == false)
                                                 {
                                                     String action = "No se puede establecer conexion";
                                                     error(context, action);
                                                 }
                                                 else
                                                 {
                                                      setState(() {
                                                        List <Mail> current = [];
                                                        List <String> allKeys = [];
                                                        String nameCamp = "email";
                                                        for (int i = 0; i < mails.length; i++)
                                                          allKeys.add(mails[i].addrres);

                                                        String campOld = "";
                                                        String pas1 = controllerPas.text;
                                                        String pas2 = controllerPasVerificator.text;

                                                        if (select != -1) {
                                                          campOld = mails[select].addrres;
                                                        }

                                                        if (primaryKeyCorrect(controllerMail.text, nameCamp,allKeys, campOld, context) == true)
                                                        {
                                                          if (mailCorrect(controllerMail.text) != true)
                                                          {
                                                            action = 'No es un correo electronico valido';
                                                            error(context, action);
                                                          }
                                                          else if (passwordCorrect(pas1, pas2, context) == true)
                                                          {
                                                            Codec<String, String> stringToBase64 = utf8.fuse(base64);
                                                            String encodedPass = stringToBase64.encode(controllerPas.text);

                                                            List <String> separeAddrres = controllerMail.text.split("@");
                                                            List <String> extCompany = separeAddrres[1].split(".");

                                                            controllerCompany.text = extCompany[0];

                                                            if (select == -1)
                                                            {
                                                              String idNew = "";

                                                              if(mails.isNotEmpty)
                                                              {
                                                                String idLast = mails[mails.length-1].id;
                                                                idNew = createId(idLast);
                                                              }
                                                              else
                                                              {
                                                                idNew ="1";
                                                              }

                                                              current.add(Mail(
                                                                  id: idNew,
                                                                  company: controllerCompany.text,
                                                                  addrres: controllerMail.text,
                                                                  password: encodedPass
                                                              ));
                                                            }
                                                            else
                                                            {
                                                                 if(saveChanges == true)
                                                                 {
                                                                     mails[select].addrres = controllerMail.text;
                                                                     mails[select].company = controllerCompany.text;
                                                                     mails[select].password = encodedPass;

                                                                 }
                                                            }
                                                            saveChanges = false;

                                                            if (result == true)
                                                            {


                                                              if (select == -1)
                                                              {
                                                                action = 'El correo se ha dado de alta correctamente';
                                                                confirm(context, action);
                                                              }
                                                              else
                                                              {
                                                                action = 'El correo se ha modificado correctamente';
                                                                confirm(context, action);
                                                              }
                                                            }
                                                            else
                                                            {
                                                              action = 'Compruebe su usuario o contraseña';
                                                              error(context, action);
                                                            }
                                                          }
                                                        }

                                                        if (conn != null) {
                                                          if (select == -1) {
                                                            sqlCreateMail(current);
                                                          }
                                                          else {
                                                            current.add(mails[select]);
                                                            sqlModifyMail(current);
                                                          }
                                                        }
                                                        else {
                                                          mails = mails + current;
                                                          csvExportatorMails(mails);
                                                        }
                                                      });
                                                 }
                                        }

                                      }
                                  ),
                                  MaterialButton(
                                    color: Colors.lightBlue,
                                    child: Text(action2,
                                      style: const TextStyle(
                                          color: Colors.white),),
                                    onPressed: () async {
                                      setState(() {
                                        if (select == -1) {
                                          controllerMail.text = "";
                                          controllerPas.text = "";
                                          controllerPasVerificator.text = "";
                                        }
                                        else {
                                          campCharge();
                                        }
                                        saveChanges = false;
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

  Future<bool> testMail() async {
    bool connectEmail = true;
    String username = controllerMail.text;
    String password = "";

    if (controllerPas.text == controllerPasVerificator.text) {
      password = controllerPas.text;
    }

    List <String> separeAddrres = controllerMail.text.split("@");

    try {
      final message = Message()
        ..from = Address(username, separeAddrres[0])
        ..recipients.add(username)
        ..subject = 'Prueba de conexion'
        ..text = 'Esto es una prueba de conexion desde la aplicacion';


      if (controllerCompany.text == "gmail") {
        final smtpServer = gmail(username, password);
        final sendReport = await send(message, smtpServer);
        print('Message sent: ' + sendReport.toString());
      }
      else if (controllerCompany.text == "hotmail") {
        final smtpServer = hotmail(username, password);
        final sendReport = await send(message, smtpServer);
        print('Message sent: ' + sendReport.toString());
      }
      String action ='Conexion establecida';
      confirm(context,action);
    } catch (e) {
      print(e);
      connectEmail = false;
    }

    return connectEmail;
  }
}