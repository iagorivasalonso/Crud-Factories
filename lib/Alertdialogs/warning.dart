import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/material.dart';


Future<bool> warning(BuildContext  context,String action) async{

 bool? campEmpty = await showDialog(
     context: context,
     barrierDismissible: true,
     builder: (BuildContext context, ) {
       return StatefulBuilder(
         builder: (BuildContext context, void Function(void Function()) setState) => Dialog(
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
           child: SizedBox(
             width: 380,
             height: action.length > 59
                     ? 220
                     : 175,
             child: Column(
               children: [
                 headAlert(title: S.of(context).cuidado),
                 Expanded(
                   child: Padding(
                     padding:  const EdgeInsets.only(left: 25,top: 25),
                     child: Text(action,
                       maxLines: 2,
                       overflow: TextOverflow.ellipsis,),
                   ),
                 ),
                 if(action.length >59)
                 SizedBox(height: 25,),
                 Expanded(
                   child: Row(
                     children: [
                       Expanded(
                         child: Padding(
                           padding: const EdgeInsets.only(left: 70, right: 15),
                           child: MaterialButton(
                               color: Colors.lightBlue,
                               child:  Text(S.of(context).si,
                                 style: TextStyle(color: Colors.white),),
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
                             child: Text(S.of(context).no,
                               style: TextStyle(color: Colors.white),),
                               color: Colors.lightBlue,
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

  return campEmpty ?? false;
}