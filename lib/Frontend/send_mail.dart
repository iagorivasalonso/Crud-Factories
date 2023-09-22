


import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';

import '../Widgets/table.dart';

class sendMail extends StatefulWidget {
  const sendMail({Key? key}) : super(key: key);

  @override
  State<sendMail> createState() => _sendMailState();


}

int _value =1;

List<String> cColumns = [];
int rows = 0;
bool selectable = false;

class _sendMailState extends State<sendMail> {

  @override
  Widget build(BuildContext context) {

    String  animal='dog';

    List<String> factoryList = ['uno', 'dos'];
    return Scaffold(
      body: Align(
        alignment: Alignment.topLeft,
        child:  Padding(
          padding: const EdgeInsets.only(left: 30.0,top: 30.0),
          child: Column(
            children: [
              const Row(
                children: [
                  Text('Envio de emails: ',
                    style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top:20.0, bottom: 30.0,left: 30.0),
                child: Row(
                  children: [
                    Text('Remitente:'),
                    SizedBox(
                      width: 450,
                      height: 40,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.00),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),

                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:5.0, bottom: 30.0, left: 30.0),
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
                                      groupValue: _value,
                                      onChanged: (value){
                                        setState(() {
                                           _value = 1;
                                        });
                                      }
                                  ),
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
                                      groupValue: _value,
                                      onChanged: (value){
                                        setState(() {
                                          _value = 2;
                                        });
                                      }
                                  ),
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
                            child: _value==1
                              ?const Row(
                                children: [
                                  Text("Enviar a:"),
                                  Padding(
                                  padding: EdgeInsets.only(left: 34.0),
                                  child: SizedBox(
                                    width: 450,
                                    height: 40,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),

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
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 50.0,right: 50.0),
                                                  child: DropdownButton<String>(
                                                      items: factoryList.map<DropdownMenuItem<String>>((String value){
                                                        return DropdownMenuItem<String>(
                                                          value: value,
                                                          child: SizedBox(
                                                              width: 150,
                                                              height: 30,
                                                              child: Text(value)
                                                          ),
                                                        );
                                                      }).toList(),

                                                      onChanged: (String? newValue){
                                                        setState(() {

                                                        });
                                                      }
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 30.0),
                                              child: Column(
                                                children: [
                                                  table(
                                                    cColumns = ['Empresa', 'Email',],
                                                    rows = 3,
                                                    selectable = false
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),

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
                padding: const EdgeInsets.only(top:40.0, bottom: 80.0, right: 10.0),
                child: Row(
                  children: [
                    const Text('Asunto:'),
                    const Padding(
                      padding: EdgeInsets.only(left: 39.0),
                      child: SizedBox(
                        width: 450,
                        height: 40,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),

                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 100.0),
                      child: ElevatedButton(
                        child: const Text("Adjuntar"),
                        onPressed:(){},
                      ),
                    ),
                  ],
                ),
              ),

              const Row(
                children: [
                  Text('Mensaje: ',
                    style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20.0,bottom: 30.0,left: 85.0),
                child: Row(
                  children: [
                  SizedBox(
                      width: 400,
                      height: 210,
                      child: TextField(
                        maxLines: 5,
                        minLines: 4,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),

                      ),
                    ),
                  ],
                ),

              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 600.0,right: 30.0),
                    child: ElevatedButton(
                      child: const Text('Enviar'),
                      onPressed: (){},
                    ),
                  ),
                  ElevatedButton(
                    child: const Text('Cancelar'),
                    onPressed: (){},
                  ),
                ],
              ),
            ],
          ),
        ),
        ]
      ),
    ),
    ),
    );

  }
}