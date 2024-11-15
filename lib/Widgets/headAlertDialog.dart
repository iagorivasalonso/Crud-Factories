import 'package:flutter/material.dart';

Container headAlert({

  required String title}) {

  Color Cexit = Colors.lightBlue;

  return Container(
    color: Colors.lightBlue,
    child: StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding:  EdgeInsets.only(left: 15),
            child: Text(title,
                style:  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          ),
          MouseRegion(
            child: Container(
              color: Cexit,
              height: 40,
              child: IconButton(
                icon: const Icon(Icons.close),
                color: Colors.white,
                onPressed: (){

                  if(title == "Error categoria")
                  {
                     Navigator.of(context).pop(3);
                  }
                  else
                 {
                   Navigator.of(context).pop(false);
                 }

                },
              ),
            ),
            onHover: (s){
              setState(() {
                Cexit = Colors.red;
              });

            },
            onExit: (s){
              setState(() {
                Cexit = Colors.lightBlue;
              });
            },
          )
        ],
      ),
    ),
  );

}

