

import 'package:flutter/material.dart';

class GenericSwitch extends StatelessWidget {

   final String text;
   final bool value;
   final ValueChanged<bool> onChanged;

   const GenericSwitch ({
        super.key,
        required this.text,
        required this.value,
        required this.onChanged
   });

  @override
  Widget build(BuildContext context) {
     return Padding(
        padding: const EdgeInsets.only(left: 35.0, top: 10.0, right: 40.0, bottom: 10.0),
        child: SizedBox(
           width: 300.0,
           child: Row(
              children: [
                 Expanded(
                    child: Text(this.text),
                 ),
                 Switch(
                     value: this.value,
                     onChanged: this.onChanged
                 ),
              ],
           ),
        ),
     );
  }
}
