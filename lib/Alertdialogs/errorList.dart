
import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/material.dart';

Future<bool> errors(BuildContext context, List<String> errorFiles) async {

  double heightAlert = errorFiles.length * 28.0;

  bool? err = await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState) => Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          child: SizedBox(
            width: 400,
            height: 200 + heightAlert,
            child: Column(
              children: [
                headAlert(title: S.of(context).error),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40.0,left: 60.0),
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
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
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
        ),
      );
    },
  );
  return err ?? false;
}