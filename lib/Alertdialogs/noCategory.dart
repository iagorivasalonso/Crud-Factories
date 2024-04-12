
import 'package:flutter/material.dart';


Future<bool> noCategory(BuildContext  context, String array) async {

bool dato = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  const Text('Error'),
          content: Text('No tiene $array  en la base de datos ¿Que desea hacer?'),
          actions: [
            Center(
              child:Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 60, right: 60.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MaterialButton(
                        onPressed: () {

                          Navigator.of(context).pop(true);
                        },
                        color: Colors.lightBlue,
                        child: const Text('Crear',
                            style: TextStyle(color: Colors.white)
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        color: Colors.lightBlue,
                        child: const Text('Importar',
                            style: TextStyle(color: Colors.white)
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        color: Colors.lightBlue,
                        child:const Text('Cancelar',
                            style: TextStyle(color: Colors.white)
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );

      });
  return dato;
}


