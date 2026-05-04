
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



Future<Sector?> createSector(BuildContext  context, [Sector? sectorOld]) async {

  final providerSector = context.read<SectorProvider>();

  final controllerSector = TextEditingController(
    text: sectorOld?.name ?? '',
  );

  final FocusNode focusNode = FocusNode();

  final isEdit = sectorOld != null;

  String title = isEdit
          ? S.of(context).edition_of_the_sector
          : S.of(context).creation_of_the_sector;

  String action = isEdit
      ? S.of(context).save_sector
      : S.of(context).create_sector;

focusNode.addListener(() {
        if (!focusNode.hasFocus) {
          saveChanges = controllerSector.text.trim().isNotEmpty &&
              controllerSector.text.trim() != (sectorOld?.name ?? '');
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
                           function: () => isEdit
                                    ? providerSector.create(context)
                                    : providerSector.edit(context,sectorOld!)
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
