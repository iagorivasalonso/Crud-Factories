import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:flutter/material.dart';


Future<bool> confirmDelete(BuildContext  context, String action) async {

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
                   headAlert(title:"Eliminar"),
                   Expanded(
                     child: Padding(
                       padding:  const EdgeInsets.only(left: 25,top: 25, bottom: 15),
                       child: Text("¿Desea eliminar la $action ?",
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
                                 onPressed:() async {
                                   Navigator.of(context).pop(true);
                                 },
                                 child: const Text("Si",style: TextStyle(color: Colors.white),)
                             ),
                           ),
                         ),
                         Expanded(
                           child: Padding(
                             padding:  const EdgeInsets.only(left: 5, right: 70),
                             child: MaterialButton(
                                 color: Colors.lightBlue,
                                 onPressed:(){
                                   Navigator.of(context).pop(false);
                                 },
                                 child: const Text("No",style:  TextStyle(color: Colors.white),)
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


