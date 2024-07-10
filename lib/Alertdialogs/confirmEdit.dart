import 'package:flutter/material.dart';


confirmEdit(BuildContext  context, String action) async {

  bool regisEdit = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          title:  const Text('Editado'),
          content: Text("La $action fue editada correctamente"),
          actions: [
            Center(
              child: MaterialButton(
                onPressed: () {

                  Navigator.of(context).pop(true);
                },
                color: Colors.lightBlue,
                child: Text('Aceptar',
                    style: TextStyle(color: Colors.white)
                ),
              ),
            ),
          ],
        );

      });


  return regisEdit;
}


