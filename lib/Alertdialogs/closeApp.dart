import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

void closeAlert(BuildContext  context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Salida de la aplicación'),
          content: const Text('¿Desea salir de la aplicación?'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0,bottom: 10.0),
              child: MaterialButton(
                onPressed: () async {
                     Navigator.of(context).pop(true);
                     await windowManager.destroy();
                      },
                 color: Colors.lightBlue,
                 child: const Text('Si',
                           style: TextStyle(color: Colors.white)
                       ),
                   ),
            ),

            Padding(
              padding: const EdgeInsets.only(right: 10.0,bottom: 10.0),
              child: MaterialButton(
                onPressed: () async {
                  Navigator.of(context).pop(false);
                },
                color: Colors.lightBlue,
                child: const Text('no',
                    style: TextStyle(color: Colors.white)
                ),
              ),
            ),
          ],
        );

      });
}




