
import 'dart:convert';
import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Alertdialogs/warning.dart';
import 'package:crud_factories/Functions/validatorCamps.dart';
import 'package:crud_factories/Objects/Factory.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import '../Objects/Mail.dart';
import '../Objects/lineSend.dart';


class sendMail extends StatefulWidget {

  List<String> datesSends;
  List<lineSend> line;
  List <Factory> Factories;
  List<Mail> mails;

  sendMail(this.datesSends,this.line,this.Factories,this.mails);

  @override
  State<sendMail> createState() => _sendMailState();
}



class _sendMailState extends State<sendMail> {


  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();
  final ScrollController verticalScrollTable = ScrollController();

  late TextEditingController controllerMailTo = TextEditingController();
  late TextEditingController controllerPass = TextEditingController();
  late TextEditingController controllerCompany = TextEditingController();
  late TextEditingController controllerMailFrom = TextEditingController();
  late TextEditingController controllerSubject = TextEditingController();
  late TextEditingController controllerMessage= TextEditingController();

  double widthBar = 10.0;

  int _tMails = 1;
  List <String> columns = [];
  int rows = 0;
  List <String> columnsTable = ['Empresa','Email'];
  List <String> mailList = [];
  List <lineSend> sends = [];
  List <lineSend> sendsDay = [];
  List <Factory> allFactories = [];
  List <Factory> selectedFactories = [];
  String? selectedSend;
  Mail? selectedMail;
  int cantFactories = 0;



  @override
  Widget build(BuildContext context) {

    List<String> datesSends = widget.datesSends;
    List<lineSend> lines = widget.line;
    List<Mail> mails = widget.mails;
    allFactories = widget.Factories;

    String itenDefaultMail =mails[0].addrres;

    return AdaptiveScrollbar(
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
                height: _tMails == 1
                    ? 713
                    : 973,
                width: 880,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, top: 30.0),
                    child: Column(children: [
                      const Row(
                        children: [
                          Text(
                            'Envio de emails: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 30.0),
                        child: Row(
                          children: [
                            const Text('Remitente:'),
                            SizedBox(
                              width: 350,
                              height: 40,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.00),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2<Mail>(
                                    hint:  Text(itenDefaultMail),
                                    items: mails.map((Mail itemMail) => DropdownMenuItem<Mail>(
                                      value:  itemMail,
                                      child: Text(itemMail.addrres),
                                    )).toList(),
                                    value: selectedMail,
                                    onChanged: (Mail? mailChoose) {
                                      setState(() {
                                        selectedMail=mailChoose;
                                        controllerMailTo.text = mailChoose!.addrres;
                                        controllerCompany.text = mailChoose!.company;
                                        controllerPass.text = mailChoose!.password;

                                      });
                                    },
                                    buttonStyleData: const ButtonStyleData(
                                      height: 50,
                                      width: 250,
                                      padding: EdgeInsets.only(left: 14, right: 14),
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: 200,
                                      width: 300,
                                      scrollbarTheme: ScrollbarThemeData(
                                        thickness: MaterialStateProperty.all(6),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 30.0, left: 30.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Column(
                                  children: [
                                    Text('Para:'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 50.0),
                                      child: Row(
                                        children: [
                                          Radio(
                                              value: 1,
                                              groupValue: _tMails,
                                              onChanged: (value) {
                                                setState(() {
                                                  _tMails = 1;
                                                });
                                              }),
                                          const Text('Un destinatario'),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 50.0),
                                      child: Row(
                                        children: [
                                          Radio(
                                              value: 2,
                                              groupValue: _tMails,
                                              onChanged: (value) {
                                                setState(() {
                                                  _tMails = 2;
                                                });
                                              }),
                                          const Text('Varios destinatarios'),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: Column(
                                children: [
                                  Container(
                                    child: _tMails == 1
                                        ?  Row(
                                      children: [
                                        Text("Enviar a:"),
                                        Padding(
                                          padding: EdgeInsets.only(left: 34.0),
                                          child: SizedBox(
                                            width: 450,
                                            height: 40,
                                            child: TextField(
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                              ),
                                              controller: controllerMailFrom,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                        : Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  const Text("Seleccionar Envio: "),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 20.0),
                                                    child: DropdownButtonHideUnderline(
                                                      child: DropdownButton2<String>(
                                                        hint: const Text('Seleccionar envio',
                                                        ),
                                                        items: datesSends.map((String itemSend) => DropdownMenuItem<String>(
                                                          value:  itemSend,
                                                          child: Text( itemSend,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ))
                                                            .toList(),
                                                        value: selectedSend,
                                                        onChanged: (String? dateChoose) {
                                                          setState(() {
                                                            sendsDay.clear();
                                                            mailList.clear();
                                                            selectedSend = dateChoose;

                                                            for(int i = 0; i < lines.length; i++) {
                                                              if(lines[i].date==dateChoose) {
                                                                sendsDay.add(lines[i]);
                                                              }
                                                            }

                                                            cantFactories = sendsDay.length;

                                                            selectedFactories.clear();
                                                            String nameFactory = " ";

                                                            for(int i = 0; i <sendsDay.length; i++)
                                                            {
                                                                nameFactory=sendsDay[i].factory;
                                                                for(int x = 0 ; x < allFactories.length; x++)
                                                                {
                                                                     if(nameFactory == allFactories[x].name)
                                                                     {
                                                                         selectedFactories.add(allFactories[x]);
                                                                     }
                                                                }
                                                            }

                                                            for(int y= 0 ; y < selectedFactories.length; y++) {
                                                                   mailList.add(selectedFactories[y].mail);
                                                            }
                                                            print(mailList);

                                                          });
                                                        },
                                                        buttonStyleData: const ButtonStyleData(
                                                          height: 50,
                                                          width: 250,
                                                          padding: EdgeInsets.only(left: 14, right: 14),
                                                        ),
                                                        dropdownStyleData: DropdownStyleData(
                                                          maxHeight: 200,
                                                          width: 220,
                                                          scrollbarTheme: ScrollbarThemeData(
                                                            thickness: MaterialStateProperty.all(6),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Align(
                                                alignment:
                                                Alignment.topLeft,
                                                child: Padding(
                                                    padding: const EdgeInsets.only(top: 20.0, left: 150.0),
                                                    child: sendsDay.isNotEmpty
                                                        ?  Column(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 40.0),
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                height: 200,
                                                                child: Scrollbar(
                                                                  controller: verticalScrollTable,
                                                                  child: SingleChildScrollView(
                                                                    controller: verticalScrollTable,
                                                                    scrollDirection: Axis.vertical,
                                                                    child: DataTable(
                                                                      columns: <DataColumn>[
                                                                        for(int i=0 ; i < columnsTable.length; i++)
                                                                          DataColumn(
                                                                            label: SizedBox(
                                                                                width: 110,
                                                                                child: Text(columnsTable[i])
                                                                            ),
                                                                          ),

                                                                      ],
                                                                      rows: List<DataRow>.generate(selectedFactories.length,
                                                                            (int index) =>  DataRow(
                                                                            cells: <DataCell>[
                                                                              DataCell(
                                                                                Text(selectedFactories[index].name),
                                                                              ),
                                                                              DataCell(
                                                                                Text(selectedFactories[index].mail),
                                                                              ),
                                                                            ]
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.only(top: 20.0),
                                                              child: Text("El envio tiene $cantFactories empresas"),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                        : const Text("no hay ningún envio seleccionado",
                                                      style: TextStyle(color: Colors.red),)
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 60.0, bottom: 60.0, right: 10.0),
                              child: Row(
                                children: [
                                  const Text('Asunto:'),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 39.0),
                                    child: SizedBox(
                                      width: 450,
                                      height: 40,
                                      child: TextField(
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                        controller: controllerSubject,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 100.0),
                                    child: ElevatedButton(
                                      child: const Text("Adjuntar"),
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Row(
                              children: [
                                Text(
                                  'Mensaje: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0, left: 85.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 500,
                                    height: 210,
                                    child: TextField(
                                      maxLines: 20,
                                      minLines: 6,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                      controller: controllerMessage,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 600.0, right: 30.0),
                                  child: ElevatedButton(
                                    child: const Text('Enviar'),
                                    onPressed: (){
                                      String action ='';

                                      if(mailCorrect(controllerMailFrom.text) != true)
                                      {
                                        action ='No es un correo electronico valido';
                                        error(context,action);
                                      }
                                      else
                                      {
                                         sendingMail();
                                      }

                                    }
                                      ),
                                      ),
                                      ElevatedButton(
                                      child: const Text('Cancelar'),
                                  onPressed: () {
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> sendingMail() async {

    String action ="";
    bool sendToMail = false;
     if(_tMails == 1)
     {
         if(controllerMailFrom.text.isNotEmpty)
         {
              sendToMail = true;
         }
     }
     else
     {
       if(mailList.isEmpty)
       {
         action ='Debe seleccionar una lista correcta';
         error(context,action);
       }
       else
       {
         sendToMail = true;
       }
     }

     if(sendToMail == true)
     {
         try {

               String username = controllerMailTo.text;
               Codec<String, String> stringToBase64 = utf8.fuse(base64);
               String password = stringToBase64.decode(controllerPass.text);
               print(password);

               final message = Message()
                    ..from = Address(username, 'Your name')
                    ..recipients.add(controllerMailFrom.text)
                    ..ccRecipients.addAll(mailList)
                    ..subject = controllerSubject.text
                    ..text = controllerMessage.text;

               if(controllerCompany.text == "Gmail")
               {
                 final smtpServer = gmail(username,password);
                 final sendReport = await send(message,smtpServer);
                 print('Message sent: ' + sendReport.toString());
               }
               else if (controllerCompany.text == "Hotmail")
               {
                 final smtpServer = hotmail(username,password);
                 final sendReport = await send(message,smtpServer);
                 print('Message sent: ' + sendReport.toString());
               }


               action ='El email se ha enviado correctamente';
               confirm(context,action);

         } catch (e) {
           action ='No configurado';
           error(context,action);
            print('${e.toString()}');
       }
     }


  }
}