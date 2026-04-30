import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Backend/CSV/exportSectors.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/Providers/FactoryProvider.dart';
import 'package:crud_factories/Backend/Providers/SectorProvider.dart' show SectorProvider;
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
import 'package:provider/provider.dart';

import '../Objects/Sector.dart';


Future<void> adminSector(BuildContext context) async {

  final providerSector = context.watch<SectorProvider>();
  final providerFactory = context.watch<FactoryProvider>();

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
                      sectors: providerSector.sectors,
                      onEdit: (index) => _onEditSector(context, index, setState,providerSector),
                      onDelete: (index) => _onDeleteSector(context, index, setState,providerSector,providerFactory),
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
                          saveChanges = false;
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

  final created = await createSector(context, "");

}

Future <void> _onEditSector(BuildContext context, int index, void Function(void Function()) setState, SectorProvider provider) async {

   try {
         final String oldName = provider.sectors[index].name;
         final Sector?  edited = await createSector(context, oldName);

   } catch (e){
       String action = S.of(context).could_not_be_edited;
       error(context,action);
   }
}

Future <void> _onDeleteSector(BuildContext context, int index, void Function(void Function()) setState, SectorProvider providerSector, FactoryProvider providerFactory) async {

  if (providerSector.sectors.isEmpty || index >= providerSector.sectors.length) return;

  final String idToDelete = providerSector.sectors[index].id;

  final bool hasFactories = providerFactory.factories.any(
        (factory) => factory.sector == idToDelete,
  );

  if (hasFactories) {
    await warning(
      context,
      S.of(context).it_cannot_eliminate_the_sector_with_companies,
    );
    return;
  }

  final bool? confirmed = await warning(
    context,
    S.of(context).confirm_delete_sector, // mensaje personalizado
  );

  if (confirmed != true) return;



    providerSector.removeSector(idToDelete);


  await confirm(context, S.of(context).the_sector_has_been_successfully_removed);

  if (BaseDateSelected.isNotEmpty) {
    sqlDeleteSector(idToDelete);
  } else {
    await csvExportatorSectors(providerSector.sectors);
  }

  if (providerSector.sectors.isEmpty && Navigator.canPop(context)) {
    Navigator.of(context).pop(false);
  }
}