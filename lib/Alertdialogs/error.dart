import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:flutter/material.dart';


Future<bool> error(BuildContext  context, String action, [format]) async {

  double WidthDialog = action.length.toDouble();

  bool? err = await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) => Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: SizedBox(
              width: WidthDialog > 53.0
                  ? 450
                  : 400,
              height: 175,
              child: Column(
                children: [
                  headAlert(title:"Error"),
                  Expanded(
                    child: Padding(
                      padding:  const EdgeInsets.only(left: 25,right: 15 ,top: 25, bottom: 15),
                      child: format == null
                        ? Row(
                        children: [
                          Expanded(
                            child: Text(action,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,),
                          ),
                        ],
                      )
                      :Row(
                        children: [
                          Expanded(
                            child: Text(action,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,),
                          ),

                          Expanded(
                            child: Text(format,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 150, right: 150),
                            child: MaterialButton(
                              color: Colors.lightBlue,
                              child: const Text(
                                "Aceptar",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                Navigator.of(context).pop(false);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

      },
    );
     return err ?? false;
}

