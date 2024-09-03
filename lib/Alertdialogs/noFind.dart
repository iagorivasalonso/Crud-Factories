import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:flutter/material.dart';


Future<bool> noFind(BuildContext  context, bool noDat, String strindDialog) async {

  noDat = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) => Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: SizedBox(
              width: 500,
              height: 190,
              child: Column(
                children: [
                  headAlert(title:"Error"),
                  Padding(
                    padding:  const EdgeInsets.only(left: 30,top: 25, bottom: 35),
                    child: Row(
                      children: [
                        Text('$strindDialog no pertenece \n a nuestra base de datos'),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                          color: Colors.lightBlue,
                          onPressed:(){
                            Navigator.of(context).pop(true);
                          },
                          child: const Text("Aceptar",style: TextStyle(color: Colors.white),)
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );

      });

  return noDat;
}


