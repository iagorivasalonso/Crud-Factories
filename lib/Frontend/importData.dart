import 'package:flutter/material.dart';

class newImport extends StatefulWidget {
  const newImport({Key? key}) : super(key: key);

  @override
  State<newImport> createState() => _newImportState();
}

class _newImportState extends State<newImport> {
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
                  Text('Importar datos: ',
                    style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15.00),
                child: Row(
                  children: [
                    Text('Importar datos en formato CSV.'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:50.0, bottom: 30.0),
                child: Row(
                  children: [
                    const Text('Ruta: '),
                    const SizedBox(
                      width: 400,
                      height: 40,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: ElevatedButton(
                        child: const Text('Examinar'),
                        onPressed: (){},
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top:10.0, bottom: 30.0),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 45.0),
                      child: Text('El archivo a importar debe estar en formato csv ',
                           style: TextStyle(color: Colors.red),),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 400.0,right: 30.0),
                      child: ElevatedButton(
                        child: const Text('Importar datos'),
                        onPressed: (){},
                      ),
                    ),
                    ElevatedButton(
                      child: const Text('Cancelar'),
                      onPressed: (){},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}