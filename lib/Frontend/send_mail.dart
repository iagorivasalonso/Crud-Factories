


import 'package:flutter/material.dart';

class sendMail extends StatelessWidget {
  const sendMail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    Text('Remitente:   '),
                    SizedBox(
                      width: 450,
                      height: 40,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),

                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top:20.0, bottom: 30.0, left: 30.0),
                child: Row(
                  children: [
                    Text('Para:          '),
                    SizedBox(
                      width: 450,
                      height: 40,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),

                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top:20.0, bottom: 30.0, left: 30.0),
                child: Row(
                  children: [
                    Text('Asunto:      '),
                    SizedBox(
                      width: 450,
                      height: 40,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),

                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0,bottom: 30.0,left: 20.0),
                child: Row(
                  children: [
                    ElevatedButton(
                      child: const Text("Adjuntar"),
                      onPressed:(){},
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
                padding: EdgeInsets.only(top: 20.0,bottom: 30.0,left: 100.0),
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
      ),
    );

  }
}