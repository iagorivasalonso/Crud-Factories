
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
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/material.dart';

import '../Widgets/materialButton.dart';
import '../Widgets/textfield.dart' show defaultTextfield;


Future<bool> createSector(BuildContext  context, String campOld) async {

  late TextEditingController controllerSector = TextEditingController();

  String titleAlert = "";
  String action = "";


  if(campOld.isNotEmpty)
  {
     titleAlert = S.of(context).edit;
     controllerSector.text=campOld!;

     action = S.of(context).save;

  }
  else
  {
    titleAlert = S.of(context).creation_of_the_sector;

    action = S.of(context).create_sector;
  }

  bool? sector = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) => Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.4,
                  maxWidth: 400,
                ),
                child: Column(
                     children: [
                       headDialog(title: titleAlert),
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
                           function: () => importSector(context,controllerSector,campOld),
                         ),
                       ),
                     ],
                  ),
            )
          ),
        );
      });

     return sector?? false;

}

Future<void> importSector(BuildContext context,TextEditingController controllerSector, String campOld) async {

  List<Sector> currentSector = [];

    if(campOld.isEmpty)
    {
      if(controllerSector.text.isNotEmpty)
      {
        bool repeat = sectors.any((sector) => sector.name == controllerSector.text);

        if(repeat == true)
        {
          String action = S.of(context).that_sector_already_exists;
          await error(context, action);
        }
        else
        {

          String idNew = "";

          if(sectors.isNotEmpty)
          {
            String idLast = sectors[sectors.length-1].id;
            idNew = createId(idLast);
          }
          else
          {
            idNew ="1";
          }

          currentSector.add(Sector(
            id: idNew,
            name: controllerSector.text,
          ));

          Navigator.of(context).pop(true);

          if(conn != null)
          {
            sqlCreateSector(currentSector);
          }
          else
          {
            sectors += currentSector;
            csvExportatorSectors(sectors);
          }

          String action = S.of(context).the_sector_has_been_created_successfully;
          confirm(context, action);
        }
      }
      else
      {
        String action = S.of(context).the_field_cannot_be_blank;
        await error(context,action);
      }
    }
    else
    {
      if (campOld != controllerSector.text)
      {
        bool repeat = sectors.any((sector) => sector.name == controllerSector.text);

        if(repeat)
        {
          String action = S.of(context).that_sector_already_exists;
          await error(context, action);
        }
        else
        {

          final sector1 = sectors.firstWhere((s) => s.name == campOld);

          if (sector1 == null) {
            final action = S.of(context).sector;
            await error(context, action);
            return;
          }
          sector1.name = controllerSector.text;
          currentSector = [sector1];

          if(conn != null)
          {
            sqlModifySector(currentSector);
          }
          else
          {
            csvExportatorSectors(sectors);
          }
          String action = S.of(context).sector_edited_correctly;
          await confirm(context, action);
        }
        Navigator.of(context).pop(true);
      }
    }


}
