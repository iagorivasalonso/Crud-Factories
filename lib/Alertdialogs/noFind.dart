import 'package:flutter/material.dart';


Future<bool> noFind(BuildContext  context, bool noDat, String strindDialog) async {

  noDat = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          title:  const Text('No encontrado'),
          content: Text(strindDialog),
          actions: [
            Center(
              child:Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: MaterialButton(
                  onPressed: () {
                    noDat = true;
                    Navigator.of(context).pop(true);
                  },
                  color: Colors.lightBlue,
                  child: const Text('Aceptar',
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


