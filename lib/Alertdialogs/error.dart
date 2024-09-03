import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:flutter/material.dart';


Future<bool> error(BuildContext  context, String action, [format]) async {

  bool err = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) => Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: SizedBox(
              width: 400,
              height: 175,
              child: Column(
                children: [
                  headAlert(title:"Error"),
                  Padding(
                    padding:  EdgeInsets.only(left: 30,top: 25, bottom: 35),
                    child: format == null
                      ? Row(
                      children: [
                        Text(action),
                      ],
                    )
                    :Row(
                      children: [
                        Text('$action '),
                        Text(format)

                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                          child: const Text("Aceptar",style: const TextStyle(color: Colors.white),),
                          color: Colors.lightBlue,
                          onPressed:(){
                            Navigator.of(context).pop(false);
                          }
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );

      });
     return err;
}

