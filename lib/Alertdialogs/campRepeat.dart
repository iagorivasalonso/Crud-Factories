import 'package:flutter/material.dart';


 campRepeat(BuildContext  context, String action) async {

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          title:  const Text('Campo Repetido'),
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


