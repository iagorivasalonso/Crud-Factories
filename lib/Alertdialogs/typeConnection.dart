import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/material.dart';

enum FuentData {
  csv,
  sql,
  empty,
}

Future<FuentData?> TypeConnectionDialog (BuildContext  context) async {

  return await  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context, ) {
        return StatefulBuilder(
          builder: (BuildContext context0, void Function(void Function()) setState) => Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: SizedBox(
              width: 340,
              height: 175,
              child: Column(
                children: [
                  headDialog(title: S.of(context).font_type),
                  Expanded(
                    child: Padding(
                      padding:  EdgeInsets.only(left: 25,top: 25, bottom: 15),
                      child: Text(S.of(context).what_type_of_database_do_you_want_to_use,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,),
                    ),
                  ),

                  const SizedBox( height: 10,),

                  Padding(
                      padding: const EdgeInsetsGeometry.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                            color: Colors.lightBlue,
                            child: Text(
                              S.of(context).csv,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(
                                context,
                                FuentData.csv,
                              );
                            },
                          ),
                          const SizedBox(width: 15),
                          MaterialButton(
                            color: Colors.lightBlue,
                            child: Text(
                              S.of(context).sql,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(
                                context,
                                FuentData.sql,
                              );
                            },
                          ),
                          const SizedBox(width: 15),
                          MaterialButton(
                            color: Colors.lightBlue,
                            child: Text(
                              S.of(context).new_male,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(
                                context,
                                FuentData.empty,
                              );
                            },
                          ),
                        ],
                      ),
                  )

                ],
              ),
            ),
          ),
        );

      });

}


