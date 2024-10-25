import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:flutter/material.dart';


Future<bool> noFind(BuildContext context, bool noDat, String stringDialog) async {
  bool? result = await showDialog<bool>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState) => Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          child: SizedBox(
            width: 500,
            height: 190,
            child: Column(
              children: [
                headAlert(title: "Error"), // Supongo que este es tu encabezado personalizado
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 25, bottom: 35),
                  child: Row(
                    children: [
                      Text(stringDialog), // Este es el mensaje de error o advertencia
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      color: Colors.lightBlue,
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: const Text(
                        "Aceptar",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
  );


  return result ?? false;
}




