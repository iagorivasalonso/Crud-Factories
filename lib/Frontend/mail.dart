
import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:flutter/material.dart';

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
  late TextEditingController controllerPas1 = new TextEditingController();
  late TextEditingController controllerPas2 = new TextEditingController();
  late List<Mail> mails;
  late int select;


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
                height: 505,
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
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      Padding(
                          padding: EdgeInsets.only(left:30, top:20.0, bottom: 30.0),
                          child: Row(
                            children: [
                              Text('Contraseña: '),
                              SizedBox(
                                width: 400,
                                height: 40,
                                child: TextField(
                                  controller: controllerPas1,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                       ),
                       Padding(
                          padding: EdgeInsets.only(left:30, top:20.0, bottom: 20.0),
                          child: Row(
                            children: [
                              Text('Verificar contraseña: '),
                              SizedBox(
                                width: 400,
                                height: 40,
                                child: TextField(
                                  controller: controllerPas2,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),

                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 30.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 160.0),
                                child: Text('Las contraseñas no coinciden ',
                                  style: TextStyle(color: Colors.red),),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 600),
                          child: Container(
                            width: 200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  child: Text(action),
                                  onPressed: () {
                                    setState(() {
                                      print(controllerMail.text);
                                      print(controllerCompany.text);
                                    });
                                  },
                                ),
                                ElevatedButton(
                                  child: const Text('Cancelar'),
                                  onPressed: () {},
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
