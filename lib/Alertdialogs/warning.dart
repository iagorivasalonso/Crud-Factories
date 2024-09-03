import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:flutter/material.dart';


Future<bool> warning(BuildContext  context,String nameCamp) async{


  Color Cexit = Colors.lightBlue;

 bool campEmpty = await showDialog(
     context: context,
     builder: (BuildContext context, ) {
       return StatefulBuilder(
         builder: (BuildContext context, void Function(void Function()) setState) => Dialog(
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
           child: SizedBox(
             width: 350,
             height: 175,
             child: Column(
               children: [
                 headAlert(title:"Cuidado"),
                 Padding(
                   padding:  const EdgeInsets.only(left: 30,top: 25, bottom: 35),
                   child: Row(
                     children: [
                       Text('el campo $nameCamp está vacio ¿Desea continuar?'),
                     ],
                   ),
                 ),
                 Row(
                   children: [
                     Padding(
                       padding: const EdgeInsets.only(left: 90, right: 15),
                       child: MaterialButton(
                           color: Colors.lightBlue,
                           onPressed:() async {
                             Navigator.of(context).pop(true);
                           },
                           child: const Text("Si",style: TextStyle(color: Colors.white),)
                       ),
                     ),
                     MaterialButton(
                         color: Colors.lightBlue,
                         onPressed:(){
                           Navigator.of(context).pop(false);
                         },
                         child: const Text("No",style: TextStyle(color: Colors.white),)
                     ),

                   ],
                 )
               ],
             ),
           ),
         ),
       );

     });

  return campEmpty;
}