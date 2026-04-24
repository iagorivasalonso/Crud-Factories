import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Functions/validatorCamps.dart' show ValidatorCamps;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:show_platform_date_picker/show_platform_date_picker.dart' show ShowPlatformDatePicker;

Padding textfieldCalendar({
  required BuildContext context,
  required String nameCamp,
  String? campOld,
  required TextEditingController controllerCamp,
}){

  BuildContext context = context1;

  final ShowPlatformDatePicker platformDatePicker = ShowPlatformDatePicker(buildContext: context1);

  DateTime dateCurrent = new DateTime.now();

 if(controllerCamp.text.isNotEmpty)
 {
   dateCurrent = DateFormat("dd-MM-yyyy").parse(controllerCamp.text);
 }
 else
 {
   controllerCamp.text = DateFormat("dd-MM-yyyy").format(dateCurrent);
 }

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
            child: TextFormField(
              validator: (value) => ValidatorCamps.dateValidate(value ?? '', context),
              controller: controllerCamp,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                icon: const Icon(Icons.calendar_today),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              ),
              onTap: () async {
                DateTime? dateSelected = await platformDatePicker.showPlatformDatePicker(
                  context,
                  dateCurrent,
                  DateTime(DateTime.now().year - 100),
                  DateTime(DateTime.now().year + 1),
                );

                if (dateSelected != null) {
                  final String formattedDate =
                  DateFormat('dd-MM-yyyy').format(dateSelected);
                  controllerCamp.text = formattedDate;
                }

                if (campOld!.isNotEmpty) {
                  saveChanges = controllerCamp.text != campOld;
                } else {
                  saveChanges = controllerCamp.text.isNotEmpty;
                }
              },
            ),
          ),
        ),
      ],
    ),
  );

}

