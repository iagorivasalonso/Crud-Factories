import 'package:flutter/material.dart';

Card defaultCard({
   required String title,
   required String description,
   required Color color,
}){

   return Card(
     color: color,
     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
     margin: const EdgeInsets.all(0),
     elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          height: 40,
          child: Column(
            children: [
               Align(
                   alignment: Alignment.topLeft,
                   child: Column(
                     children: [
                       Row(
                         children: [
                           Expanded(child: Text(title,
                             style: const TextStyle(fontWeight: FontWeight.bold),
                             maxLines: 1,
                             overflow: TextOverflow.ellipsis,),
                           )
                         ],
                       ),
                       Row(
                         children: [
                           Expanded(child: Text(description,
                             maxLines: 1,
                             overflow: TextOverflow.ellipsis,),
                           )
                         ],
                       ),

                     ],
                   ),
                   )

            ],
          ),
        ),
      ),

   );
}