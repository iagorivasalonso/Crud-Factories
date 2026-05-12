
import 'package:crud_factories/Alertdialogs/warning.dart';
import 'package:crud_factories/Frontend/send_mail.dart';
import 'package:crud_factories/Objects/Sector.dart';
import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:crud_factories/Widgets/headView.dart';
import 'package:crud_factories/Widgets/materialButton.dart';
import 'package:crud_factories/Widgets/textfield.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/material.dart';


Future<Sector?> createSector(BuildContext  context, [Sector? sectorOld]) async {



  final controllerSector = TextEditingController(
    text: sectorOld?.name ?? '',
  );


  final isEdit = sectorOld != null;

  String title = isEdit
          ? S.of(context).edition_of_the_sector
          : S.of(context).creation_of_the_sector;

  String action = isEdit
      ? S.of(context).save_sector
      : S.of(context).create_sector;


  Sector? sector = await showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult:(didPop,result) async {

            if (didPop) return;

            final hasChanges = controllerSector.text.trim() != (sectorOld?.name ?? '');

            if (hasChanges) {
              final confirmExit = await warning(
                context, S.of(context).unsaved_changes,
              );
              if (confirmExit == true) {
                Navigator.of(context).pop();
              }
            } else {
              Navigator.of(context).pop();
            }
            },
          child: Dialog(
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
                               ),
                             ),
                           ),
                         ),
                         const SizedBox(height: 30),
                         Flexible(
                           flex: 1,
                           child: materialButton(
                             nameAction: action,
                             function:  () {
                               final name = controllerSector.text.trim();

                               if (name.isEmpty) return;

                               Navigator.pop(
                                 dialogContext,
                                 Sector(
                                   id: sectorOld?.id ?? '',
                                   name: name,
                                 ),
                               );
                             },
                           ),
                         ),
                       ],
                    ),
              )
          ),
        );
      });
     return sector;

}

