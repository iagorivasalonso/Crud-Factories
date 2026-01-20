import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/material.dart';


Future<bool> error(BuildContext  context, String action, [format]) async {

  double heightAlert = 185.0 + (2 * 15.0);
  double dialogHeight = heightAlert.clamp(185.0, 400.0);

  bool? err = await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) => Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: SizedBox(
              width: 400,
              height: format == null
                  ? action.length < 55
                      ? 175
                      : 200
                  : dialogHeight,
              child: Column(
                children: [
                  headDialog(title: S.of(context).error),
                  Expanded(
                    child: Padding(
                      padding:  const EdgeInsets.only(left: 25,top: 20, bottom: 10.0 ,right: 20),
                      child: format == null
                        ? Column(
                        children: [
                          Expanded(
                            child: Text(action,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,),
                          ),
                        ],
                      )
                      :Column(
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
                                S.of(context).acept,
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

