import 'package:flutter/material.dart';


Future<bool> noFind(BuildContext  context, bool noDat, String strindDialog) async {

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  const Text('No encontrado'),
          content: Text(strindDialog),
          actions: [
            Center(
              child:Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: MaterialButton(
                  onPressed: () {
                    noDat = true;
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
  return noDat;
}


