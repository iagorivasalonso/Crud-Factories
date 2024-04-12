import 'package:flutter/material.dart';


Future<bool> noDat(BuildContext  context, String nameCamp) async {

  bool campRepeat = false;

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  const Text('Error'),
          content: Text('el $nameCamp ya existe en nuestra base de datos'),
          actions: [
            Center(
              child:Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: MaterialButton(
                  onPressed: () {
                    campRepeat = true;
                    Navigator.of(context).pop(false);
                  },
                  color: Colors.lightBlue,
                  child: Text('Aceptar',
                         style: TextStyle(color: Colors.white)
                         ),
                ),
              ),
            ),
          ],
        );

      });
  return campRepeat;
}


