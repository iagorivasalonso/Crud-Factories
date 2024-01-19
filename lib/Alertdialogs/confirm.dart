import 'package:flutter/material.dart';


 confirm(BuildContext  context, String action) async {



  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  const Text('Confirmar'),
          content: Text(action),
          actions: [
            Center(
              child:Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: MaterialButton(
                  onPressed: () {

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

}


