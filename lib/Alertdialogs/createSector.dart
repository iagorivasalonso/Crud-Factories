
import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Backend/CSV/exportSectors.dart';
import 'package:crud_factories/Backend/Providers/SectorProvider.dart' show SectorProvider;
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
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



Future<Sector?> createSector(BuildContext  context, String campOld) async {

  final provider = context.read<SectorProvider>();

  final controllerSector = TextEditingController(
    text: campOld.isNotEmpty ? campOld : '',
  );

  final FocusNode focusNode = FocusNode();

  String title = campOld.isEmpty ? S.of(context).creation_of_the_sector : S.of(context).edit;
  String action = campOld.isEmpty ? S.of(context).create_sector : S.of(context).save;


focusNode.addListener(() {
        if (!focusNode.hasFocus) {
              if (campOld.isNotEmpty) {
                   saveChanges = controllerSector.text != campOld;
              } else {
                 saveChanges = controllerSector.text.isNotEmpty;
              }
        }
  });

  Sector? sector = await showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 240,
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
                               focusNode: focusNode
                             ),
                           ),
                         ),
                       ),
                       const SizedBox(height: 30),
                       Flexible(
                         flex: 1,
                         child: materialButton(
                           nameAction: action,
                           function: () => saveSector(dialogContext,controllerSector,campOld,provider),
                         ),
                       ),
                     ],
                  ),
            )
        );
      });
     controllerSector.dispose();
     focusNode.dispose();
     return sector;

}

Future<void> saveSector(BuildContext dialogContext,TextEditingController controllerSector, String campOld, SectorProvider provider) async {

  Sector sector;

  final text = controllerSector.text
      .trim()
      .replaceAll(RegExp(r'\s+'), ' ');

  final old = campOld.trim().toLowerCase();

  if (text.isEmpty) {
    await error(dialogContext, S.of(dialogContext).the_field_cannot_be_blank);
    return;
  }

  if (text.toLowerCase() == old) {
    Navigator.of(dialogContext).pop(null);
    return;
  }


  if (provider.exist(text, exclude: campOld)) {
    await error(dialogContext, S.of(dialogContext).that_sector_already_exists);
    return;
  }



    if (campOld.isEmpty)
    {
      String idNew = provider.sectors.isNotEmpty
          ? createId(provider.sectors.last.id)
          : "1";

       sector = Sector(id: idNew, name: text);
      provider.addSector(sector);
      
      String action = LocalizationHelper.manage_array(dialogContext, S.of(dialogContext).sector, S.of(dialogContext).saved, S.of(dialogContext).theFemale);
      await confirm(dialogContext, action);

    }
    else
    {
      final existing = provider.sectors
          .where((s) => s.name.toLowerCase() == old)
          .cast<Sector?>()
          .firstOrNull;

      if (existing == null) {
        await error(dialogContext, "Sector no encontrado");
        return;
      }

      final updated = Sector(
        id: existing.id,
        name: text,
      );

      provider.updateSector(updated);
      sector = updated;

      await confirm(dialogContext, S.of(dialogContext).sector_edited_correctly);
    }
      saveChanges = false;
      bool showError = false;
      String? errorMsg;

      if (BaseDateSelected.isNotEmpty) {
        if (campOld.isEmpty) {
          sqlCreateSector(sector);
        } else {
          sqlModifySector(sector);
        }
      } else {
        bool errorExp = await csvExportatorSectors(provider.sectors);

        if (!kIsWeb && errorExp) {
          showError = true;
          errorMsg = LocalizationHelper.no_file(
            dialogContext,
            S.of(dialogContext).sectors,
          );
        }
      }

// 🔒 cerrar SIEMPRE una sola vez
  Navigator.of(dialogContext).pop(sector);

// ⚠️ mostrar error después
  if (showError) {
    await error(dialogContext, errorMsg!);
  }
   return;

}

