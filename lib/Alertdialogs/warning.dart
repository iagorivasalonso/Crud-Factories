import 'package:flutter/material.dart';


Future<bool> warning(BuildContext  context,String nameCamp) async{

 bool campEmpty = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          title:  const Text('cuidado'),
          content: Text('el campo $nameCamp está vacio ¿Desea continuar?'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: MaterialButton(
                onPressed: () {

                  Navigator.of(context).pop(true);
                },
                color: Colors.lightBlue,
                child: Text('Si',
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
                child: Text('no',
                    style: TextStyle(color: Colors.white)
                ),
              ),
            ),
          ],
        );

      });


  return campEmpty;
}