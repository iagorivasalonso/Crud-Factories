import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:flutter/material.dart';


Future<bool> confirm(BuildContext  context, String action) async {

  bool? err = await showDialog(
       context: context,
       builder: (BuildContext context) {
         return StatefulBuilder(
           builder: (BuildContext context, void Function(void Function()) setState) => Dialog(
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
             child: SizedBox(
                 width:  320,
                 height: action.length > 60
                     ? 230
                     : 175,
                 child: Column(
                     children: [
                       headAlert(title:"Confirmar"),
                       Expanded(child: Padding(
                         padding: const EdgeInsets.only(left: 25,right: 15, top:15),
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
                     ]
                 )
             ),
           ),
         );

       });
   return err ?? false;
}

