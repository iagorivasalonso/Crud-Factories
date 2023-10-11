
import 'package:flutter/material.dart';

class newEmail extends StatefulWidget {
  const newEmail({super.key});

  @override
  State<newEmail> createState() => _newEmailState();
}

class _newEmailState extends State<newEmail> {

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
                  Text('Email: ',
                    style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top:20.0, bottom: 80.0),
                child: Row(
                  children: [
                    Text('Nuevo email: '),
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
                padding: EdgeInsets.only(top:20.0, bottom: 30.0),
                child: Row(
                  children: [
                    Text('Contraseña: '),
                    SizedBox(
                      width: 400,
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
                padding: EdgeInsets.only(top:20.0, bottom: 20.0),
                child: Row(
                  children: [
                    Text('Verificar contraseña: '),
                    SizedBox(
                      width: 400,
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
                padding: EdgeInsets.only(bottom: 30.0),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 130.0),
                      child: Text('Las contraseñas no coinciden ',
                        style: TextStyle(color: Colors.red),),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 600.0,right: 30.0),
                    child: ElevatedButton(
                      child: const Text('Nuevo'),
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
