import 'package:flutter/material.dart';

typeConection (BuildContext  context,) async {

  bool regisEdit = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          title:  const Text('Tipo de fuente'),
          content: Text("Que tipo de base de datos desea utilizar"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: MaterialButton(
                onPressed: () {

                  Navigator.of(context).pop(true);
                },
                color: Colors.lightBlue,
                child: Text('SQL',
                    style: TextStyle(color: Colors.white)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: MaterialButton(
                onPressed: () {

                  Navigator.of(context).pop(false);
                },
                color: Colors.lightBlue,
                child: Text('CSV',
                    style: TextStyle(color: Colors.white)
                ),
              ),
            ),
          ],
        );

      });


  return regisEdit;
}

