import 'package:flutter/material.dart';

Future<bool> warning(BuildContext  context,String nameCamp) async{
  bool campEmpty = false;

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  const Text('cuidado'),
          content: Text('el $nameCamp está vacio'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: MaterialButton(
                onPressed: () {

                  Navigator.of(context).pop(false);
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