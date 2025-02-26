import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:crud_factories/helpers/localization_helper.dart';
import 'package:flutter/material.dart';


Future<int> noCategory(BuildContext  context, String array) async {

  int? dato = await showDialog(
      context: context,
      builder: (BuildContext context) {
       return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) => Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: SizedBox(
              width: 450,
              height: 175,
              child: Column(
                children: [
                  headAlert(title:S.of(context).category_error),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25,right: 15 ,top: 25, bottom: 15),
                      child: Text(LocalizationHelper.no_array_BD(context, array),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: MaterialButton(
                                child: Text(S.of(context).create,
                                  style: TextStyle(color: Colors.white),),
                                color: Colors.lightBlue,
                                onPressed:() async {
                                  Navigator.of(context).pop(1);
                                },

                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: MaterialButton(
                               child: Text(S.of(context).import,
                                 style: TextStyle(color: Colors.white),),
                                color: Colors.lightBlue,
                                onPressed:(){
                                  Navigator.of(context).pop(2);
                                },

                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:const EdgeInsets.only(left: 25, right: 25),
                            child: MaterialButton(
                              child: Text(S.of(context).cancel,
                                style: TextStyle(color: Colors.white),),
                                color: Colors.lightBlue,
                                onPressed:(){
                                  Navigator.of(context).pop(3);
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

      });
  return  dato ?? -3;
}


