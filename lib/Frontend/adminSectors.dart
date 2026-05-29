import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Backend/Data/controlsMessagesError/errors.dart' show CreateResult, EditResult, DeleteResult;
import 'package:crud_factories/Backend/Providers/FactoryProvider.dart';
import 'package:crud_factories/Backend/Providers/SectorProvider.dart' show CreateResult, SectorProvider, EditResult, DeleteResult;
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



Future<void> adminSector(BuildContext context) async {

  return  showDialog(
    context: context,
    builder: (context) {
       return Dialog(
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
                 child: Consumer<SectorProvider>(
                   builder: (context,providerSector,_){
                     return Padding(
                         padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                         child: tableEditSector(
                           sectors: providerSector.sectors,
                           onEdit: (index) => editSector(context, index,providerSector),
                           onDelete: (index) => deleteSector(context, index),
                         )
                     );
                   },
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
                       function: () => newSector(context),
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
       );
    },
  );
}


Future<void> newSector(BuildContext context) async {

  final sector = await createSector(context);

  final result = await context.read<SectorProvider>().create(sector!);

  switch (result) {
    case CreateResult.success:
      await confirm(context,S.of(context).sector_created_successfully);
      break;
    case CreateResult.alreadyExists:
      await error(context,S.of(context).sector_already_exists);
      break;
    case CreateResult.invalidData:
      await error(context, S.of(context).not_valid);
      break;
  }
}

Future<void> editSector(BuildContext context, int index, SectorProvider providerSector) async {
  final old = providerSector.sectors[index];

  final updated = await createSector(context, old);

  if (updated == null) return;

  final result = await context.read<SectorProvider>().update(updated);

  switch (result) {
    case EditResult.success:
      await confirm(context,S.of(context).sector_edited_correctly);
      break;

    case EditResult.alreadyExists:
      await error(context, S.of(context).sector_already_exists);
      break;

    case EditResult.invalidData:
      await error(context, S.of(context).invalid_data);
      break;

    case EditResult.notFound:
      await error(context, S.of(context).sector_not_found);
      break;
    case EditResult.error:
      // TODO: Handle this case.
      throw UnimplementedError();
  }
}

Future<void> deleteSector(BuildContext context, int index) async {
  final confirmed = await warning(
    context,
    S.of(context).confirm_delete_sector,
  );

  if (confirmed != true) return;

  final provider = context.read<SectorProvider>();

  final result = await provider.delete(
    index,
    context.read<FactoryProvider>(),
  );

  switch (result) {
    case DeleteResult.success:
      await confirm(context,S.of(context).sector_delete_correctly);
      break;

    case DeleteResult.hasDependencies:
      await error(context, S.of(context).it_cannot_eliminate_the_sector_with_companies);
      break;

    case DeleteResult.notFound:
      await error(context,S.of(context).sector_not_found);
      break;

    case DeleteResult.error:
      // TODO: Handle this case.
      throw UnimplementedError();
  }
}