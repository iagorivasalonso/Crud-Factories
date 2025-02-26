import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/material.dart';

StatefulBuilder headAlert({

  required String title}) {

  Color Cexit = Colors.lightBlue;

  return  StatefulBuilder(
    builder: (BuildContext context, void Function(void Function()) setState) =>Flexible(
      child: Container(
        color: Colors.lightBlue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(title,
                  maxLines: 1,
                  style:  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,),
              ),
            ),
            MouseRegion(
              child: Container(
                color: Cexit,
                height: 40,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  color: Colors.white,
                  onPressed: (){

                    if(title == S.of(context).category_error)
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
    ),
  );

}