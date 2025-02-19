import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:crud_factories/generated/l10n.dart';
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
                headAlert(title: S.of(context).error),
                Expanded(child: Padding(
                    padding: const EdgeInsets.only(left: 30, top: 25, bottom: 15),
                    child:  Text(stringDialog,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding:  const EdgeInsets.only(left: 170, right: 170),
                          child: MaterialButton(
                            color: Colors.lightBlue,
                            child: Text(
                              S.of(context).aceptar,
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
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




