import 'package:flutter/material.dart';


error(BuildContext  context, String action, [format]) async {

  bool err = false;

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          title:  const Text('Error'),
          content: format != null
                  ? SizedBox(
                     height: 45,
                     child: Column(
                       children: [
                          Text(action),
                         Text(format,
                           style: TextStyle(fontStyle: FontStyle.italic),),
                         ],
            ),
            )
            :Text(action),
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
     return err;
}

