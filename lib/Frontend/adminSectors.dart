import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Backend/CSV/exportSectors.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/SQL/deleteSector.dart';
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:crud_factories/Widgets/tableEditSector.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/material.dart';

import '../Alertdialogs/createSector.dart';
import '../Alertdialogs/error.dart';
import '../Widgets/materialButton.dart';


Future<void> adminSector(BuildContext context) async {

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState) => Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.6,
              maxWidth: 400,
            ),
            child: Column(
              children: [
                headDialog(title: S.of(context).sector_management),
                const SizedBox(height: 60),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                    child: tableEditSector(
                      sectors: sectors,
                      onEdit: (index) => _onEditSector(context, index, setState),
                      onDelete: (index) => _onDeleteSector(context, index, setState),
                    )
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 110.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      materialButton(
                        nameAction: S.of(context).create,
                        function: () => _onCreateSector(context, setState),
                      ),
                      const SizedBox(width: 20),
                      materialButton(
                        nameAction: S.of(context).close,
                        function:  () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      );
    },
  );

}

Future <void> _onCreateSector(BuildContext context, void Function(void Function()) setState) async {

      String modif = "";
      bool create = await createSector(context, modif);

      if (create == true) {
        setState(() {});
      }

}

Future <void> _onEditSector(BuildContext context, int index, void Function(void Function()) setState) async {

   try {
         String modif = sectors[index].name;
         bool? mod = await createSector(context, modif);

         if( mod == true)
         {
           setState((){});
         }

   } catch (e){
       String action = S.of(context).could_not_be_edited;
       error(context,action);
   }
}

Future <void> _onDeleteSector(BuildContext context, int index, void Function(void Function()) setState) async {
  String idSupr = sectors[index].id;


  if (sectors.length == 1) {
    Navigator.of(context).pop(false);
  }

  setState(() {
    sectors.removeAt(index);
  });

  confirm(context, S
      .of(context)
      .the_sector_has_been_successfully_removed);

  if (BaseDateSelected.isNotEmpty) {
    sqlDeleteSector(idSupr);
  }
  else {
    csvExportatorSectors(sectors);
  }
}