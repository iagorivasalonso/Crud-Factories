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
            TextButton(
                child: const Text('Si'),
                onPressed: () async {
                  Navigator.of(context).pop(true);
                  await windowManager.destroy();
                },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () async {
                Navigator.of(context).pop(false);

              },
            ),

          ],
        );

      });
}


