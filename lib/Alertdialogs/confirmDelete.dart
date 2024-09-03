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
                   Padding(
                     padding:  const EdgeInsets.only(left: 30,top: 25, bottom: 35),
                     child: Row(
                       children: [
                         Text("Desea eliminar la $action"),

                       ],
                     ),
                   ),
                   Row(
                     children: [
                       Padding(
                         padding: const EdgeInsets.only(left: 90, right: 15),
                         child: MaterialButton(
                             child: const Text("Si",style: const TextStyle(color: Colors.white),),
                             color: Colors.lightBlue,
                             onPressed:() async {
                               Navigator.of(context).pop(true);
                             }
                         ),
                       ),
                       MaterialButton(
                           child: const Text("No",style: const TextStyle(color: Colors.white),),
                           color: Colors.lightBlue,
                           onPressed:(){
                             Navigator.of(context).pop(false);
                           }
                       ),

                     ],
                   )
                 ],
               ),
             ),
           ),
         );
       });


   return regisDelete;
}


