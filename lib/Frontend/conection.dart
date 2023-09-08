import 'package:flutter/material.dart';

class conection extends StatefulWidget {
  const conection({Key? key}) : super(key: key);

  @override
  State<conection> createState() => _conectionState();
}

class _conectionState extends State<conection> {
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
                  Text('Conexion: ',
                    style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),
            ],
          ),
        ),
      ),
    );

  }
}