import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

void closeAlert(BuildContext  context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Salida de la aplicación"),
          content: Text("¿Desea salir de la aplicación?"),
          actions: [
            ElevatedButton(
                child: Text("Si"),
                onPressed: () async {
                   Navigator.of(context).pop(true);
                   await windowManager.destroy();
                },
            ),
            ElevatedButton(
                child: Text("No"),
                onPressed: (){
                   Navigator.of(context).pop(false);
              },
            )
          ],
        );

      });
}




