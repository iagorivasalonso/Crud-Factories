import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Backend/CSV/exportSectors.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/SQL/deleteSector.dart';
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:crud_factories/Widgets/tableEditSector.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:crud_factories/Alertdialogs/createSector.dart';
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Alertdialogs/warning.dart';
import 'package:crud_factories/Widgets/materialButton.dart';


Future<void> adminSector(BuildContext context) async {

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState) => Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 400,
              maxHeight: 350,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                headDialog(title: S.of(context).sector_management),
                const SizedBox(height: 15.0),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                    child: tableEditSector(
                      sectors: sectors,
                      onEdit: (index) => _onEditSector(context, index, setState),
                      onDelete: (index) => _onDeleteSector(context, index, setState),
                    )
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
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

  final bool created = await createSector(context, "");

  if (created) {
    setState(() {});
  }

}

Future <void> _onEditSector(BuildContext context, int index, void Function(void Function()) setState) async {

   try {
         final String oldName = sectors[index].name;
         final bool edited = await createSector(context, oldName);

         if(edited)
         {
           setState((){});
         }
   } catch (e){
       String action = S.of(context).could_not_be_edited;
       error(context,action);
   }
}

Future <void> _onDeleteSector(BuildContext context, int index, void Function(void Function()) setState) async {

  if (sectors.isEmpty || index >= sectors.length) return;

  final String idToDelete = sectors[index].id;


  final bool? confirmed = await warning(
    context,
    S.of(context).confirm_delete_sector, // mensaje personalizado
  );

  if (confirmed != true) return;


  setState(() {
    sectors.removeAt(index);
  });

  await confirm(context, S.of(context).the_sector_has_been_successfully_removed);

  if (BaseDateSelected.isNotEmpty) {
    sqlDeleteSector(idToDelete);
  } else {
    await csvExportatorSectors(sectors);
  }

  if (sectors.isEmpty && Navigator.canPop(context)) {
    Navigator.of(context).pop(false);
  }
}