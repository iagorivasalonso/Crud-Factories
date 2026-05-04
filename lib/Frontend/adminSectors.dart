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
                      onEdit: (index) => createSector(context,providerSector.sectors[index]),//modo edicion
                      onDelete: (index) => providerSector.delete(context, index, providerFactory),
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
                        function: () => createSector(context),
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


