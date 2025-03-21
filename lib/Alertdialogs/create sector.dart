
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
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/material.dart';


Future<bool> createSector(BuildContext  context, String modif) async {

  late TextEditingController controllerSector = TextEditingController();

  bool repeat = false;
  String titleAlert="";
  bool edit = false;

  if(modif!=S.of(context).newMale.toLowerCase())
  {
     titleAlert = S.of(context).modification_of_the_sector;
     controllerSector.text=modif!;

     edit = true;
  }
  else
  {
    titleAlert = S.of(context).creation_of_the_sector;
    modif = S.of(context).newMale;

    edit = false;
  }

  bool? sector = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) => Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: SizedBox(
              width: 350,
              height: 230,
              child: Column(
                children: [
                  headAlert(title: titleAlert),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 120,top: 25),
                      child: Text(S.of(context).name_sector,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Expanded(
                      child: SizedBox(
                        height: 40,
                        width: 200,
                        child: TextField(
                          controller: controllerSector,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()
                          ),
                        ),
                      )
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 110, right: 110),
                            child: MaterialButton(
                                child: Text(S.of(context).acept,
                                  style: const TextStyle(color: Colors.white),),
                                color: Colors.lightBlue,
                                onPressed:() async {
                                  List<Sector> currentSector = [];

                                  if(controllerSector.text.isNotEmpty)
                                  {
                                    if(edit == false)
                                    {
                                      for(int i = 0; i < sectors.length; i++)
                                      {
                                        if(controllerSector.text == sectors[i].name)
                                        {
                                          repeat = true ;
                                        }

                                      }

                                      if(repeat == false)
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
                                      else
                                      {
                                        String action = S.of(context).that_sector_already_exists;
                                        await error(context, action);
                                      }

                                    }
                                    else
                                    {

                                      for(int i = 0; i < sectors.length; i++)
                                      {
                                        if(modif == sectors[i].name)
                                        {
                                          sectors[i].name = controllerSector.text;
                                          currentSector.add(sectors[i]);
                                        }
                                      }

                                      Navigator.of(context).pop(true);

                                      if(conn != null)
                                      {
                                        sqlModifySector(currentSector);
                                      }
                                      else
                                      {
                                        csvExportatorSectors(sectors);
                                      }
                                    }


                                  }
                                  else
                                  {
                                     String action = S.of(context).the_field_cannot_be_blank;
                                     await error(context,action);
                                  }




                                }
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });

     return sector?? false;

}

