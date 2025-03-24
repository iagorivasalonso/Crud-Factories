import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Alertdialogs/create%20sector.dart';
import 'package:crud_factories/Alertdialogs/warning.dart';
import 'package:crud_factories/Backend/CSV/exportSectors.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/SQL/deleteSector.dart';
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:crud_factories/Widgets/headViewsAndroid.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:crud_factories/helpers/localization_helper.dart';
import 'package:flutter/material.dart';


Future<void> adminSector(BuildContext context) async {

  double mWidth = 400;

  return showDialog(
    context: context,
    builder: (BuildContext context) {

      final screenWith = MediaQuery.of(context).size.width;

      return StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState) => Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          child: SizedBox(
            width: mWidth,
            height: 350,
            child: Column(
              children: [
                headAlert(title: S.of(context).sector_management),
                const SizedBox(height: 60),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                    child: ListView.builder(
                      itemCount: sectors.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(sectors[index].name),
                          trailing: screenWith > 330.0
                              ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () async {

                                  String modif = sectors[index].name;
                                  bool? mod = await createSector(context, modif);

                                  if (mod == true) {
                                    setState(() {});
                                  }
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () async {

                                  String pr = S.of(context).he;
                                  String array0 = S.of(context).sector;
                                  String array = "$pr $array0";
                                  String action1 = LocalizationHelper.ask_confirm_supr(context, array);

                                  bool correct = await warning(context, action1);
                                  String search = sectors[index].name;
                                  String idSupr = "";

                                  if (correct)
                                  {

                                    if (sectors.length == 1)
                                    {
                                      Navigator.of(context).pop(false);
                                    }

                                    setState(() {
                                      sectors.removeAt(index);
                                      String action = S.of(context).the_sector_has_been_created_successfully;
                                      confirm(context, action);
                                    });
                                  }

                                  if (conn != null)
                                  {

                                    for (int i = 0; i < sectors.length; i++)
                                    {
                                      if (search == sectors[i].name)
                                      {
                                        idSupr = sectors[i].id;
                                      }
                                    }

                                    sqlDeleteSector(idSupr);
                                  }
                                  else
                                  {
                                     csvExportatorSectors(sectors);
                                  }
                                },
                              ),
                            ],
                          )
                              : null,
                        );
                      },
                    ),
                  ),
                ),
               Expanded(
                 child: Padding(padding: const EdgeInsets.only(left: 30.0, right: 10.0,top: 44),
                 child: Row(
                   children: [
                     Expanded(
                       child: Padding(
                         padding: const EdgeInsets.only(left: 70, right: 15),
                         child: MaterialButton(
                           color: Colors.lightBlue,
                           child:  Text(S.of(context).create,
                             style: TextStyle(color: Colors.white),
                           ),
                           onPressed: () async {
                             String modif = S.of(context).newMale;
                             bool create = await createSector(context, modif);

                             if (create == true) {
                               setState(() {});
                             }

                           }
                         ),
                       ),
                     ),

                     Expanded(
                       child: Padding(
                         padding: const EdgeInsets.only(left: 5, right: 70),
                         child: MaterialButton(
                           color: Colors.lightBlue,
                           onPressed: () {
                             Navigator.of(context).pop(false);
                           },
                           child: Text(S.of(context).close,
                             style: TextStyle(color: Colors.white),
                           ),
                         ),
                       ),
                     ),
                   ],
                 ),
                             ),
               )
              ],
            ),
          ),
        ),
      );
    },
  );

}

class adminSectorAndroid extends StatefulWidget {

 BuildContext context;

 adminSectorAndroid(this.context);

  @override
  State<adminSectorAndroid> createState() => _adminSectorAndroidState();
}

class _adminSectorAndroidState extends State<adminSectorAndroid> {
  @override
  Widget build(BuildContext context) {

    BuildContext context = widget.context;
    String title = S.of(context).sector_management;

    return Scaffold(
      appBar: appBarAndroid(context, name: title),
      body: Text("factori"),
    );
  }
}
