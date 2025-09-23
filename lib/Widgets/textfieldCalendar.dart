import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:show_platform_date_picker/show_platform_date_picker.dart' show ShowPlatformDatePicker;

Padding textfieldCalendar({
  required String nameCamp,
  String? campOld,
  required TextEditingController controllerCamp,
}){
  final ShowPlatformDatePicker platformDatePicker = ShowPlatformDatePicker(buildContext: context1);

  DateTime seletedDate =DateTime.now();

  return Padding(
    padding: const EdgeInsets.only(left: 35.0, top: 20.0,right: 40.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: SizedBox(
            width: 100,
            child: Text(
              nameCamp,
            ),
          ),
        ),

        Expanded(
          child: SizedBox(
            height: 40,
            child: TextField(
              controller: controllerCamp,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                icon: const Icon(Icons.calendar_today),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              ),
              onTap: () async {
                DateTime? dateSelected = await platformDatePicker.showPlatformDatePicker(
                  context1,
                  seletedDate,
                  DateTime(DateTime.now().year - 10),
                  DateTime(DateTime.now().year + 1),
                );

                if (dateSelected != null) {
                  final String formattedDate =
                  DateFormat('dd-MM-yyyy').format(dateSelected);
                  controllerCamp.text = formattedDate;
                }
              },
            ),
          ),
        ),
      ],
    ),
  );

}

