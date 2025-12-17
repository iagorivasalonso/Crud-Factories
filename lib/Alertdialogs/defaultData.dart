import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/material.dart';

Future<bool> defaultData (BuildContext  context) async {

  bool? dataDefault  = await   showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context, ) {
        return StatefulBuilder(
          builder: (BuildContext context0, void Function(void Function()) setState) => Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: SizedBox(
              width: 500,
              height: 175,
              child: Column(
                children: [
                  headDialog(title: S.of(context).data_not_found),
                  Expanded(
                    child: Padding(
                      padding:  EdgeInsets.only(left: 25,top: 25, bottom: 15),
                      child: Text(S.of(context).no_data_in_memory,

                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,),
                    ),
                  ),

                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 70, right: 15),
                            child: MaterialButton(
                              color: Colors.lightBlue,
                              child:  Text(S.of(context).view_demo,style:  TextStyle(color: Colors.white),),
                              onPressed:() async {
                                Navigator.of(context).pop(true);
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5, right: 78),
                            child: MaterialButton(
                              color: Colors.lightBlue,
                              child:  Text(S.of(context).load_data,style:  TextStyle(color: Colors.white),),
                              onPressed:(){
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

      });


  return dataDefault ?? false;
}