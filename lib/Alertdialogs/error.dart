import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/material.dart';


Future<bool> error(BuildContext  context, String action, [format]) async {



  bool? err = await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) => Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: SizedBox(
              width: 400,
              height: action.length > 59
                  ? 185
                  : 175,
              child: Column(
                children: [
                  headAlert(title: S.of(context).error),
                  Expanded(
                    child: Padding(
                      padding:  const EdgeInsets.only(left: 25,top: 25,right: 20),
                      child: format == null
                        ? Row(
                        children: [
                          Expanded(
                            child: Text(action,
                              maxLines: 2,
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
                              child: Text(
                                S.of(context).aceptar,
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

