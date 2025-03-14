import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/material.dart';


Future<bool> confirm(BuildContext  context, String action) async {


  double heightAlert = 185.0 + (2 * 15.0);
  double dialogHeight = heightAlert.clamp(185.0, 400.0);

  bool? conf = await showDialog(
       context: context,
       builder: (BuildContext context) {
         return StatefulBuilder(
           builder: (BuildContext context, void Function(void Function()) setState) => Dialog(
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
             child: SizedBox(
                 width:  320,
                 height: action.length > 60
                     ? 230
                     : dialogHeight,
                 child: Column(
                     children: [
                       headAlert(title:S.of(context).confirm),
                       Expanded(child: Padding(
                         padding: const EdgeInsets.only(left: 25,right: 15, top:25),
                         child: Text(action,
                           maxLines: 2,
                           overflow: TextOverflow.ellipsis,),
                       ),
                       ),

                       Expanded(
                         child: Row(
                           children: [
                             Expanded(
                               child: Padding(
                                 padding: const EdgeInsets.only(left: 110, right: 110),
                                 child: MaterialButton(
                                   color: Colors.lightBlue,
                                   child:  Text(
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
                     ]
                 )
             ),
           ),
         );

       });
   return conf ?? false;
}

