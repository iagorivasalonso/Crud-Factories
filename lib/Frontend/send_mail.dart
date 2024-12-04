
import 'dart:convert';
import 'dart:io';
import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Alertdialogs/warning.dart';
import 'package:crud_factories/Backend/CSV/exportLines.dart';
import 'package:crud_factories/Backend/SQL/modifyLines.dart';
import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Functions/validatorCamps.dart';
import 'package:crud_factories/Objects/Factory.dart';
import 'package:crud_factories/Objects/Mail.dart';
import 'package:crud_factories/Objects/LineSend.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';


class sendMail extends StatefulWidget {

  @override
  State<sendMail> createState() => _sendMailState();
}

class _sendMailState extends State<sendMail> {


  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();
  final ScrollController verticalScrollTable = ScrollController();

  late TextEditingController controllerMailFrom = TextEditingController();
  late TextEditingController controllerPass = TextEditingController();
  late TextEditingController controllerMailTo = TextEditingController();
  late TextEditingController controllerSubject = TextEditingController();
  late TextEditingController controllerMessage= TextEditingController();

  double widthBar = 10.0;

  List<Attachment> atach=[];

  List <String> columns = [];
  List <String> columnsTable = ['Empresa','Email'];
  List <LineSend> sends = [];
  List <LineSend> sendsDay = [];
  List <Factory> allFactories = [];
  List <Factory> selectedFactories = [];
  String? selectedSend;
  bool otherMail= false;
  bool mailSave = false;
  bool isList = false;
  Mail? selectedMail;
  int cantFactories = 0;
  double marginBox = 0;

  String nameRoute = "";

  @override
  Widget build(BuildContext context) {

    if(mails.isEmpty)
    {
        otherMail = true;
    }
    else
    {
           if (selectedMail==null)
           {
               controllerMailFrom.text = mails[0].addrres;
               controllerPass.text =  mails[0].password;
               mailSave = true;
           }

           if(otherMail == true)
           {
             controllerMailFrom.text ="";
             controllerPass.text = "";
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
                  height: isList == false
                            ? 835
                            : 1105,
                  width: 880,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30.0, top: 30.0),
                      child: Column(
                          children: [
                        const Row(
                          children: [
                            Text(
                              'Envio de emails: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 30.0),
                                  child: otherMail == false
                                    ? Row(
                                       children: [
                                          const Text('Remitente:'),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 120.0),
                                            child: SizedBox(
                                              width: 350,
                                              height: 40,
                                              child: Padding(
                                                   padding: const EdgeInsets.only(left: 20.00),
                                                      child: DropdownButtonHideUnderline(
                                                          child: DropdownButton2<Mail>(
                                                              hint:  Text(mails[0].addrres),
                                                              items: mails.map((Mail itemMail) => DropdownMenuItem<Mail>(
                                                                value:  itemMail,
                                                                child: Text(itemMail.addrres),
                                                )).toList(),
                                                value: selectedMail,
                                                onChanged: (Mail? mailChoose) {
                                                  setState(() {

                                                    selectedMail=mailChoose;
                                                    controllerMailFrom.text = mailChoose!.addrres;
                                                    controllerPass.text = mailChoose!.password;

                                                    mailSave = true;

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
                                          ),
                                    ],
                                  )
                                    : Row(
                                         children: [
                                            Row(
                                              children: [
                                                const Text("Email:"),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 49.0),
                                                  child: SizedBox(
                                                    width: 450,
                                                    height: 40,
                                                    child: TextField(
                                                      controller: controllerMailFrom,
                                                      decoration: const InputDecoration(
                                                        border: OutlineInputBorder(),
                                                      ),
                                                      onChanged: (s){
                                                        if(controllerMailFrom.text.isEmpty)
                                                        {
                                                          saveChanges = false;
                                                        }
                                                        else
                                                        {
                                                          saveChanges = true;
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),


                                         ],
                                      ),
                                ),
                              ],
                            ),
                            if(mails.isNotEmpty)
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 100.0),
                                  child:  Row(
                                    children: [
                                      MaterialButton(
                                          color: Colors.lightBlue,
                                          child: otherMail == false
                                                 ? const Text("Otro" ,
                                                      style: TextStyle(color: Colors.white),)
                                                 : const Text("Volver" ,
                                                            style: TextStyle(color: Colors.white),),
                                          onPressed: () async {
                                            setState(() {
                                              otherMail =! otherMail;
                                            });

                                          }
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        if(otherMail==true)
                        Padding(
                              padding: const EdgeInsets.only(top: 35.0, left: 30.0),
                              child: Row(
                                children: [
                                  const Text('Contraseña:'),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: SizedBox(
                                      width: 350,
                                      height: 40,
                                      child: TextField(
                                        controller: controllerPass,
                                        obscureText: true,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                        onChanged: (s) {
                                          if(controllerSubject.text.isEmpty)
                                          {
                                            saveChanges = false;
                                          }
                                          else
                                          {
                                            saveChanges = true;
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0, bottom: 30.0, left: 30.0),
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
                                                value: false,
                                                groupValue: isList,
                                                onChanged: (value) {
                                                  setState(() {
                                                    isList = false;
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
                                                value: true,
                                                groupValue: isList,
                                                onChanged: (value) {
                                                  setState(() {
                                                    isList = true;
                                                    saveChanges = false;
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
                                      child: isList == false
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
                                                controller: controllerMailTo,
                                                onChanged: (s){
                                                   if(controllerMailTo.text.isEmpty)
                                                   {
                                                     saveChanges = false;
                                                   }
                                                   else
                                                   {
                                                     saveChanges = true;
                                                   }
                                                },
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
                                                    const Text("Seleccionar envio: "),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 20.0),
                                                      child: DropdownButtonHideUnderline(
                                                        child: DropdownButton2<String>(
                                                          hint: const Text('Seleccionar envio',
                                                          ),
                                                          items: dateSends.map((String itemSend) => DropdownMenuItem<String>(
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
                                                              selectedSend = dateChoose;

                                                              for(int i = 0; i < lineSector.length; i++) {

                                                                if(lineSector[i].date==dateChoose) {
                                                                  sendsDay.add(lineSector[i]);

                                                                }
                                                              }

                                                              selectedFactories.clear();
                                                              String nameFactory = " ";

                                                              for(int i = 0; i <sendsDay.length; i++)
                                                              {
                                                                nameFactory=sendsDay[i].factory;

                                                                for(int x = 0 ; x < factories.length; x++)
                                                                {
                                                                  if(nameFactory == factories[x].name)
                                                                  {
                                                                    selectedFactories.add(factories[x]);
                                                                  }

                                                                }
                                                              }
                                                              cantFactories = selectedFactories.length;
                                                            });
                                                          },
                                                              
                                                          buttonStyleData: const ButtonStyleData(
                                                            height: 50,
                                                            width: 200,
                                                            padding: EdgeInsets.only(left: 14, right: 14),
                                                          ),
                                                          dropdownStyleData: DropdownStyleData(
                                                            maxHeight: 200,
                                                            width: 200,
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
                                                  alignment: Alignment.topLeft,
                                                  child: Padding(
                                                      padding: const EdgeInsets.only(top: 20.0, left: 150.0),
                                                      child: isList == true
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
                                padding: const EdgeInsets.only(top: 60.0, right: 10.0),
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
                                          onChanged: (s) {
                                            if(controllerSubject.text.isEmpty)
                                            {
                                              saveChanges = false;
                                            }
                                            else
                                            {
                                              saveChanges = true;
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 100.0),
                                      child: MaterialButton(
                                        color: Colors.lightBlue,
                                        child: const Text('Adjuntar',
                                          style:  TextStyle(color: Colors.white),),
                                        onPressed: () {
                                          setState(() {
                                            _pickFile();
                                          });

                                        },
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                             if(atach.isNotEmpty)
                             Padding(
                               padding: const EdgeInsets.only(left: 90.0,top: 10.0),
                               child: Align(
                                 alignment: Alignment.topLeft,
                                 child: Column(
                                   children: [
                                     Row(
                                       children: [
                                        const Icon(
                                             Icons.attach_file_rounded,
                                             size: 20,
                                         ),
                                         SizedBox(
                                           height: 40,
                                           width: 450,
                                           child: ListView.builder(
                                             physics: const BouncingScrollPhysics(),
                                             scrollDirection: Axis.horizontal,
                                               itemCount: atach.length,
                                              itemBuilder: (BuildContext context, index) {
                                                    return Padding(
                                                      padding: const EdgeInsets.all(2.0),
                                                      child: Container(
                                                          width: 130,
                                                          decoration: BoxDecoration(
                                                             color: Colors.lightBlue[100], //light blue
                                                             borderRadius: BorderRadius.circular(20.0)
                                                            ),
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 10.0),
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                  child: MouseRegion(
                                                                    child: Text(atach[index].fileName!,
                                                                      maxLines: 1,
                                                                      overflow: TextOverflow.ellipsis,),
                                                                      onHover: (s){
                                                                         setState(() {
                                                                           nameRoute = atach[index].fileName!;
                                                                           marginBox = 150.0 * index;
                                                                         });

                                                                     },
                                                                    onExit: (s){
                                                                      setState(() {
                                                                        nameRoute = "";
                                                                      });
                                                                    },
                                                                  ),
                                                                ),
                                                                IconButton(
                                                                  icon: const Icon(Icons.close,size: 15.0),
                                                                  onPressed: (){
                                                                    setState(() {
                                                                      atach.removeAt(index);
                                                                    });
                                                                  },
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          ),

                                                    );
                                              }
                                           ),
                                         ),

                                       ],
                                     ),
                                      Padding(
                                       padding: const EdgeInsets.only(left: 40),
                                       child: Row(
                                         children: [
                                            Padding(
                                              padding: EdgeInsets.only( left: marginBox),
                                              child: Text(" $nameRoute ",
                                                   style: const TextStyle(backgroundColor: Colors.amberAccent),
                                                 ),
                                            ),

                                         ],
                                       ),
                                     )
                                   ],
                                 ),
                               ),
                             ),
                             const Padding(
                                padding:  EdgeInsets.only(top: 40.0),
                                child:  Row(
                                  children: [
                                    Text(
                                      'Mensaje: ',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
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
                                        onChanged: (s) {
                                          if(controllerMessage.text.isEmpty)
                                          {
                                            saveChanges = false;
                                          }
                                          else
                                          {
                                            saveChanges = true;
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 600.0, right: 30.0),
                                    child: MaterialButton(
                                      color: Colors.lightBlue,
                                      child: const Text('Enviar',
                                      style: const TextStyle(color: Colors.white),),
                                      onPressed: () async {

                                        String action ='';
                                        int dat_correct = 2;
                                        bool validMailTo = true;
                                        bool validMailFrom = false;

                                        if(otherMail == true)
                                        {
                                            if(mailCorrect(controllerMailFrom.text) != true)
                                            {
                                              action ='su correo electronico no es valido';
                                              validMailFrom = await error(context,action);

                                            }
                                            else
                                            {
                                              validMailFrom = true;
                                            }
                                        }
                                        else
                                        {
                                          validMailFrom = true;
                                        }

                                        if(validMailFrom == true)
                                        {
                                          if(isList == false)
                                          {
                                            if(mailCorrect(controllerMailTo.text) != true)
                                            {
                                              action ='El destinatario no es un correo electronico';
                                              error(context,action);

                                              validMailTo = false;
                                            }
                                            sendsDay.clear();
                                          }
                                          else
                                          {
                                            if(sendsDay.isEmpty)
                                            {
                                              action ='Debe seleccionar una lista correcta';
                                              error(context,action);

                                              validMailTo = false;
                                            }
                                          }
                                        }

                                        if(validMailTo == true && validMailFrom == true)
                                        {
                                          String action1="";

                                          if(controllerSubject.text.isEmpty)
                                          {
                                            dat_correct=dat_correct-1;

                                             action1 ='el campo asunto está vacio ¿Desea continuar?';
                                             bool  correct= await warning(context, action1);

                                             if(correct)
                                             {
                                               dat_correct++;
                                             }

                                          }
                                          if(controllerMessage.text.isEmpty)
                                          {
                                            dat_correct=dat_correct-1;

                                            action1 ='el campo mensaje está vacio ¿Desea continuar?';
                                            bool  correct= await warning(context, action1);

                                            if(correct)
                                            {
                                              dat_correct++;
                                            }
                                          }
                                          if(dat_correct==2)
                                          {
                                            String username = controllerMailFrom.text;
                                            Codec<String, String> stringToBase64 = utf8.fuse(base64);
                                            String password = " ";

                                              if(otherMail == false)
                                              {
                                                password = stringToBase64.decode(controllerPass.text);
                                              }
                                              else
                                              {
                                                password = controllerPass.text;
                                              }

                                           saveChanges = false;
                                           sendingMail(username,password);
                                          }


                                        }
                                      }

                                      ),

                                  ),
                                  MaterialButton(
                                    color: Colors.lightBlue,
                                    child: const Text('Reiniciar',
                                      style: const TextStyle(color: Colors.white),),
                                    onPressed: () {
                                      setState(() {
                                        isList = false;
                                        saveChanges = false;
                                       controllerMailFrom.text = "";
                                       controllerPass.text ="";
                                       controllerMailTo.text = "";
                                       atach.clear();
                                       controllerSubject.text = "";
                                       controllerMessage.text = "";
                                      });
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
      ),
    );
  }
  void _pickFile() async {

    FilePickerResult? result =  await FilePicker.platform.pickFiles(
      dialogTitle: 'Seleccionar archivo',
      type: FileType.custom,
      allowedExtensions: ['csv','pdf'],
    );

    if(result == null) return;

    PlatformFile file = result.files.single;


    File file1 =new File(file.path!);

    setState(() {
      atach.add(FileAttachment(file1));
    });
    }


    Future<void> sendingMail(String username, String password) async {

    String action =" ";
    String sendCorrect = " ";
    String company =" ";

         try {
               List <String> separeAddrres = username.split("@");
               List <String> extCompany = separeAddrres[1].split(".");

                company = extCompany[0];

                if(sendsDay.isEmpty)
                {
                      final message = Message()
                        ..from = Address(username, separeAddrres[0])
                        ..recipients.add(controllerMailTo.text)
                        ..subject = controllerSubject.text
                        ..text = controllerMessage.text
                        ..attachments = atach;


                      if(company == "gmail")
                      {
                        final smtpServer = gmail(username,password);
                        final sendReport = await send(message,smtpServer);

                        sendCorrect = sendReport.toString();
                      }
                      else if (company == "hotmail")
                      {

                        final smtpServer = hotmail(username,password);
                        final sendReport = await send(message,smtpServer);

                        sendCorrect = sendReport.toString();
                      }

                      if(sendCorrect.contains("Message successfully sent"))
                      {
                        action="El email se ha enviado correctamente";
                        confirm(context,action);
                      }

                }
                else
                {
                      int cSended = 0;

                      do {
                        String currentSend = sendsDay[cSended].factory;
                        late Factory current;


                        for(int i = 0; i < factories.length; i++)
                        {
                            if(currentSend == factories[i].name)
                            {
                               current = factories[i];
                            }
                        }

                        final message = Message()
                          ..from = Address(username, separeAddrres[0])
                          ..recipients.add(current.mail)
                          ..subject = controllerSubject.text
                          ..text = controllerMessage.text
                          ..attachments = atach;


                           if(company == "gmail")
                           {
                              final smtpServer = gmail(username,password);
                              final sendReport = await send(message,smtpServer);

                              sendCorrect = sendReport.toString();
                           }
                           else if (company == "hotmail")
                           {
                               final smtpServer = hotmail(username,password);
                               final sendReport = await send(message,smtpServer);

                               sendCorrect = sendReport.toString();
                           }

                           if(sendCorrect.contains("Message successfully sent"))
                           {
                              sendsDay[cSended].state = "Enviado";
                              cSended++;
                           }

                      } while(cSended < sendsDay.length);

                      
                      if (cSended != 0)
                      {
                        action="Se han enviado $cSended emails";
                        confirm(context,action);
                      }
                      else
                      {
                        action = "No hay emails para enviar";
                        error(context, action);
                      }

                      if (conn != null)
                      {
                        sqlModifyLines(sendsDay);
                      }
                      else
                      {
                        csvExportatorLines(lineSector);
                      }
                    }

         }catch (e) {
           action="No hay conecxion con el email";
           error(context,action);
         }
     }
}