import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Frontend/factory.dart' show setState;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:show_platform_date_picker/show_platform_date_picker.dart' show ShowPlatformDatePicker;

Padding textfieldCalendar({
  required String nameCamp,
  required String campOld,
  required TextEditingController controllerCamp,
}){
  final ShowPlatformDatePicker platformDatePicker = ShowPlatformDatePicker(buildContext: context1);

  DateTime seletedDate =DateTime.now();

  return Padding(
    padding: const EdgeInsets.only(
        top: 20.0, left: 30.0, bottom: 30.0),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Text("dfxgh"),
        ),
        SizedBox(
          width: 200,
          height: 40,
          child: TextField(
            controller: controllerCamp,
            decoration:  InputDecoration(
              border: const OutlineInputBorder(),
              icon: const Icon(Icons.calendar_today)
            ),
            onTap: () async {

                DateTime? dateSelected = await  platformDatePicker.showPlatformDatePicker(
                  context1,
                  seletedDate,
                  DateTime(DateTime.now().year - 10),
                  DateTime(DateTime.now().year + 1),
                );
                if (dateSelected != null) {
                  final String formattedDate = DateFormat('dd-MM-yyyy').format(dateSelected);
                  controllerCamp.text = formattedDate;
                }
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 200.0),
          child: Text(campOld),
        ),

      ],
    ),
  );
}
