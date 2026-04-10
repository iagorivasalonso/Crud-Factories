
import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Backend/CSV/exportSectors.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/SQL/createSector.dart';
import 'package:crud_factories/Backend/SQL/modifySector.dart';
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Functions/createId.dart';
import 'package:crud_factories/Objects/Sector.dart';
import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:crud_factories/Widgets/headView.dart';
import 'package:crud_factories/Widgets/materialButton.dart' show materialButton;
import 'package:crud_factories/Widgets/textfield.dart' show defaultTextfield;
import 'package:crud_factories/generated/l10n.dart';
import 'package:crud_factories/helpers/localization_helper.dart' show LocalizationHelper;
import 'package:flutter/material.dart';



Future<bool> createSector(BuildContext  context, String campOld) async {

  final TextEditingController controllerSector = TextEditingController();

  String title = campOld.isEmpty ? S.of(context).creation_of_the_sector : S.of(context).edit;
  String action = campOld.isEmpty ? S.of(context).create_sector : S.of(context).save;

  if (campOld.isNotEmpty) controllerSector.text = campOld;

  bool? sector = await showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.4,
                  maxWidth: 400,
                ),
                child: Column(
                     children: [
                       headDialog(title: title),
                       Padding(
                         padding: const EdgeInsets.only(top:20.0,left: 40.0),
                         child: headView(
                             title: S.of(context).name_sector
                         ),
                       ),
                       Flexible(
                         flex:1,
                         child: SizedBox(
                           width: 350.0,
                           child: Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 35.0),
                             child: defaultTextfield(
                               nameCamp:"",
                               controllerCamp: controllerSector,
                             ),
                           ),
                         ),
                       ),
                       const SizedBox(height: 30),
                       Flexible(
                         flex: 1,
                         child: materialButton(
                           nameAction: action,
                           function: () => saveSector(dialogContext, dialogContext,controllerSector,campOld),
                         ),
                       ),
                     ],
                  ),
            )
        );
      });
     controllerSector.dispose();
     return sector?? false;

}

Future<void> saveSector(BuildContext context,  BuildContext dialogContext,TextEditingController controllerSector, String campOld) async {

  final text = controllerSector.text
      .trim()
      .replaceAll(RegExp(r'\s+'), ' ');

  final old = campOld.trim().toLowerCase();

  if (text.isEmpty) {
    await error(context, S.of(context).the_field_cannot_be_blank);
    return;
  }

  if (text.toLowerCase() == old) {
    Navigator.of(context).pop(false);
    return;
  }

  bool repeat = sectors.any((sector) =>
  sector.name.toLowerCase() == text.toLowerCase() &&
      sector.name.toLowerCase() != old);

  if (repeat) {
    await error(context, S.of(context).that_sector_already_exists);
    return;
  }

    List<Sector> currentSector = [];

    if (campOld.isEmpty)
    {
      String idNew = sectors.isNotEmpty ? createId(sectors.last.id) : "1";
      Sector newSector = Sector(id: idNew, name: text);
      sectors.add(newSector);
      currentSector.add(newSector);

      String action = LocalizationHelper.manage_array(context, S.of(context).sector, S.of(context).saved, S.of(context).theFemale);
      Navigator.pop(dialogContext, true);
      await confirm(context, action);

    }
    else
    {
      // Editar sector existente¡
      final sectorList = sectors.where((s) =>
      s.name.toLowerCase() == old);

      if (sectorList.isEmpty) return;

      final sector = sectorList.first;


      sector.name = text;
      currentSector.add(sector);
      Navigator.of(context).pop(true);
      await confirm(context, S.of(context).sector_edited_correctly);
    }

    // Persistencia
    if (BaseDateSelected.isNotEmpty) {
      if (campOld.isEmpty) {
        sqlCreateSector(currentSector);
      } else {
        sqlModifySector(currentSector);
      }
    } else {
      await csvExportatorSectors(sectors);
    }
   return;

}
