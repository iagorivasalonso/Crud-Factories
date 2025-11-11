
import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/material.dart';

Future<bool> errors(BuildContext context, List<String> errorFiles) async {

  double heightAlert = 185.0 + (errorFiles.length * 15.0);
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
            height: dialogHeight,
            child: Column(
              children: [
                headDialog(title: S.of(context).error),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding:  const EdgeInsets.only(left: 25,top: 25,right: 20, bottom: 10.0
                    ),
                    child: ListView.builder(
                      itemCount: errorFiles.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: [
                            Expanded(
                              child: Text(
                                errorFiles[index],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding:  const EdgeInsets.only(left: 150, right: 150, bottom: 15),
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
              ],
            ),
          ),
        ),
      );
    },
  );
  return err ?? false;
}