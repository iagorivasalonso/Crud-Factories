import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:crud_factories/helpers/localization_helper.dart';
import 'package:flutter/material.dart';


Future<bool> confirmDelete(BuildContext  context, String array) async {

   bool regisDelete = await showDialog(
       context: context,
       builder: (BuildContext context) {
         return StatefulBuilder(
           builder: (BuildContext context, void Function(void Function()) setState) => Dialog(
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
             child: SizedBox(
               width: 350,
               height: 175,
               child: Column(
                 children: [
                   headAlert(title:S.of(context).delete),
                   Expanded(
                     child: Padding(
                       padding:  const EdgeInsets.only(left: 25,top: 25, bottom: 15),
                       child: Text(LocalizationHelper.supr_array(context, array),
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
                                 child: Text(S.of(context).yes,style: TextStyle(color: Colors.white),),
                               onPressed:() async {
                                 Navigator.of(context).pop(true);
                               },
                             ),
                           ),
                         ),
                         Expanded(
                           child: Padding(
                             padding:  const EdgeInsets.only(left: 5, right: 70),
                             child: MaterialButton(
                                 color: Colors.lightBlue,
                                 child: Text(S.of(context).no,style:  TextStyle(color: Colors.white),),
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


   return regisDelete;
}


