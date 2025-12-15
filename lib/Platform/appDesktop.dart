import 'package:crud_factories/Alertdialogs/closeApp.dart';
import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Alertdialogs/errorList.dart';
import 'package:crud_factories/Alertdialogs/noCategory.dart';
import 'package:crud_factories/Alertdialogs/typeconnection.dart';
import 'package:crud_factories/Alertdialogs/warning.dart';
import 'package:crud_factories/Backend/CSV/chargueData%20csv.dart';
import 'package:crud_factories/Backend/CSV/exportSectors.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/_selection_view.dart';
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Frontend/adminRoutes.dart';
import 'package:crud_factories/Frontend/adminSectors.dart';
import 'package:crud_factories/Functions/changesNoSave.dart';
import 'package:crud_factories/Objects/RouteCSV.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:crud_factories/helpers/localization_helper.dart';
import 'package:flutter/material.dart';
import 'package:menu_bar/menu_bar.dart';

import '../Alertdialogs/createSector.dart';

class appDesktop extends StatefulWidget {
  const appDesktop({super.key});

  @override
  State<appDesktop> createState() => _appDesktopState();
}

class _appDesktopState extends State<appDesktop> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) async {

          String action = "";
          List<RouteCSV> routesCurrent = [];

          bool isChargue = await chargueDataCSV(context);

          bool sqlBd = await typeConection(context);


          if (sqlBd == true)
          {
                String name = '';

                for(int i = 0; i < routesCSV.length; i++)
                {
                   name = routesCSV[i].name;

                   for (int y = 0; y < SQLRoutes.length; y++)
                   {
                      if(SQLRoutes[y] == name)
                      {
                        routesCurrent.add(routesCSV[i]);
                      }
                   }
                }

                setState(() {
                  itenSelect = 2;
                  subIten1Select = 1;
                });
          }
          else
          {
             routesCurrent = routesCSV;
          }



          if (isChargue == true)
          {
               bool fileFail = false;

               for(int i = 0; i < routesCurrent.length; i++)
               {
                   if(routesCurrent[i].route.isEmpty)
                   {
                        fileFail = true;
                   }
               }
               if(errorFiles.isNotEmpty)
               {
                 errors(context, errorFiles);

                 setState(() {
                   itenSelect = 0;
                   subIten1Select = 1;
                   subIten2Select = -1;
                 });
               }

               if(fileFail == true)
               {
                    String no_rutes = S.of(context).you_do_not_have_a_complete_route_file;
                    String want_complete = S.of(context).want_to_complete_it;

                    action = "$no_rutes \n $want_complete";
                    bool rutesComplete = await warning(context, action);

                    if(rutesComplete == true)
                    {
                      setState(() {
                        itenSelect = 0;
                        subIten1Select = 1;
                        subIten2Select = -1;
                      });
                    }
               }
          }


     });

  }

  @override
  Widget build(BuildContext context) {

    double mWidth = MediaQuery.of(context).size.width;
    double mHeight = MediaQuery.of(context).size.height;

    context1 = context;

    double wItem= 80;
    double wItemMax= 120;
    Color colorBar =Colors.white;

    List<BarButton> _menuBarButtons() {
      return [
        BarButton (
            text:   SizedBox(
                child: Text(S.of(context).file,
                  style: TextStyle(color:colorBar),)),
            submenu: SubMenu(
                menuItems:[
                  MenuButton(
                      text: SizedBox(
                          width: wItem,
                          child: Text(S.of(context).newMale)
                      ),
                      submenu: SubMenu(
                          menuItems: [
                            MenuButton(
                                text: SizedBox(
                                    width:wItem,
                                    child: Text(S.of(context).company)),
                                onTap: () async {

                                    if (saveChanges == false)
                                    {
                                      setState(() {
                                        itenSelect = 0;
                                        subIten1Select = 0;
                                        subIten2Select = 0;
                                      });
                                    }
                                    else
                                    {
                                      saveChanges =! await changesNoSave(context);

                                      if(saveChanges == false)
                                      {
                                        setState(() {
                                          itenSelect = 0;
                                          subIten1Select = 0;
                                          subIten2Select = 0;
                                        });
                                      }
                                    }

                                }
                            ),
                            MenuButton(
                                text: SizedBox(
                                    width: wItem,
                                    child: Text(S.of(context).mail)),
                                onTap: () async {

                                  if (saveChanges == false)
                                  {
                                    setState(() {
                                      itenSelect = 0;
                                      subIten1Select = 0;
                                      subIten2Select = 1;
                                    });
                                  }
                                  else
                                  {
                                    saveChanges =! await changesNoSave(context);

                                    if(saveChanges == false)
                                    {
                                      setState(() {
                                        itenSelect = 0;
                                        subIten1Select = 0;
                                        subIten2Select = 1;
                                      });
                                    }
                                  }

                                }
                            ),
                            MenuButton(
                                text: SizedBox(
                                    width: wItem,
                                    child: Text(S.of(context).shipment)),
                                onTap: () async {

                                 bool go = false;
                                 if (saveChanges == false)
                                 {
                                   go = true;
                                 }
                                 else
                                 {
                                   saveChanges =! await changesNoSave(context);

                                   if(saveChanges == false)
                                   {
                                     go = true;
                                   }
                                 }
                                 if(go == true)
                                 {
                                   if(allFactories.isNotEmpty)
                                   {
                                     setState(() {
                                       itenSelect = 0;
                                       subIten1Select = 0;
                                       subIten2Select = 2;
                                     });
                                   }
                                   else
                                   {
                                     String action =S.of(context).you_can_not_make_the_shipping_because_you_do_not_have_companies_in_your_database;
                                     error(context,action);

                                     setState(() {
                                       itenSelect = -1;
                                       subIten1Select = -1;
                                       subIten2Select = -1;
                                     });
                                   }
                                 }

                                }
                            ),
                          ]
                      )
                  ),
                  MenuButton(
                      text: SizedBox(
                          width: wItem,
                          child: Text(S.of(context).routes)),
                      onTap: () async {

                        showDialog(
                          context: context,
                          builder: (context) => const adminRoutes(),
                        );

                      }
                  ),
                  MenuButton(
                      text: SizedBox(
                          width: wItem,
                          child: Text(S.of(context).import)),
                      onTap: () async {

                        if (saveChanges == false)
                        {
                          setState(() {
                            itenSelect = 0;
                            subIten1Select = 2;
                            subIten2Select = -1;
                          });
                        }
                        else
                        {
                          saveChanges =! await changesNoSave(context);

                          if(saveChanges == false)
                          {
                            setState(() {
                              itenSelect = 0;
                              subIten1Select = 2;
                              subIten2Select = -1;
                            });
                          }
                        }

                      }
                  ),
                  MenuButton(
                      text:  SizedBox(
                          width: wItem,
                          child: Text(S.of(context).go_out)
                      ),
                      onTap: (){
                        closeAlert(context);
                      }
                  ),

                ]
            )
        ),
        BarButton (
            text:   SizedBox(
                child: Text(S.of(context).lists,
                  style: TextStyle(color:colorBar),)),
            submenu: SubMenu(
                menuItems:[
                  MenuButton(
                      text: SizedBox(
                          width: wItem,
                          child:  Text(S.of(context).sectors)),
                      onTap: () async {
                              if(sectors.isNotEmpty)
                              {
                                setState(() {
                                  adminSector(context);
                                });
                              }
                              else
                              {
                                String modif = S.of(context).newMale.toLowerCase();

                                bool create = await createSector(context,modif);

                                if(create == true)
                                {

                                  bool errorExp = await csvExportatorSectors(sectors);


                                  if(errorExp == false)
                                  {
                                    String action = S.of(context).the_sector_has_been_created_successfully;
                                    await confirm(context, action);
                                  }
                                  else
                                  {
                                    String array = S.of(context).sectors;
                                    String action = LocalizationHelper.no_file(context, array);
                                    error(context, action);
                                  }
                                }
                              }
                      }
                  ),
                  if(sectors.length < 2 || allFactories.isEmpty)
                    MenuButton(
                        text: SizedBox(
                            width: wItem,
                            child: Text(S.of(context).companies)),
                            onTap: () async {
                              bool go = false;
                              if (saveChanges == false)
                              {
                                go = true;
                              }
                              else
                              {
                                saveChanges =! await changesNoSave(context);

                                if(saveChanges == false)
                                {
                                  go = true;
                                }
                              }
                              if(go == true)
                              {

                                if(allFactories.isNotEmpty)
                                {
                                  setState(() {
                                    itenSelect = 1;
                                    subIten1Select = 1;
                                    subIten2Select = 0;
                                  });
                                }
                                else
                                {
                                  String array = S.of(context).companies;
                                  int dat = await noCategory(context, array);

                                  if(dat == 1)
                                  {
                                    setState(() {
                                      itenSelect = 0;
                                      subIten1Select = 1;
                                      subIten2Select = 0;
                                    });
                                  }
                                  else
                                  {
                                    setState(() {
                                      itenSelect = 0;
                                      subIten1Select = 2;
                                      subIten2Select = 0;
                                    });
                                  }
                                }
                              }

                            }
                    ),
                  if(sectors.length > 1 && allFactories.isNotEmpty)
                  MenuButton(
                        text: SizedBox(
                            width: wItem,
                            child: Text(S.of(context).companies)),
                        submenu: SubMenu(
                            menuItems:
                            [
                              MenuButton(
                                  text: SizedBox(
                                      width:  wItem,
                                      child: Text(S.of(context).allFemale)),
                                  onTap: () async {
                                    controllerSearchSend.clear();
                                    if (saveChanges == false)
                                    {
                                      setState(() {
                                        itenSelect = 1;
                                        subIten1Select = 1;
                                        subIten2Select = 0;
                                      });
                                    }
                                    else
                                    {
                                      saveChanges =! await changesNoSave(context);

                                      if(saveChanges == false)
                                      {
                                        setState(() {
                                          itenSelect = 1;
                                          subIten1Select = 1;
                                          subIten2Select = 0;
                                        });
                                      }
                                    }
                                  }
                              ),
                              const MenuDivider(),
                              for(int i = 0 ; i < sectors.length; i++)
                                MenuButton(
                                    text: SizedBox(
                                        width: sectors[i].name.length > 3
                                            ? sectors[i].name.length * 8
                                            : wItem,
                                        child: Text(sectors[i].name)),
                                    onTap: (){
                                      setState(() {
                                        itenSelect = 1;
                                        subIten1Select = 1;
                                        subIten2Select = i + 1;
                                      });
                                    }
                                ),
                            ]
                        )
                    ),

                  MenuButton(
                      text: SizedBox(
                          width: wItem,
                          child: Text(S.of(context).mails)),
                      onTap: () async {

                               bool go = false;
                              if (saveChanges == false)
                              {
                                go = true;
                              }
                              else
                              {
                                saveChanges =! await changesNoSave(context);

                                if(saveChanges == false)
                                {
                                  go = true;
                                }
                              }

                              if(go == true)
                              {
                                if(mails.isNotEmpty)
                                {
                                  setState(() {
                                    itenSelect = 1;
                                    subIten1Select = 2;
                                  });
                                }
                                else
                                {
                                  String array = S.of(context).mails;
                                  int dat = await noCategory(context, array);

                                  if(dat == 1)
                                  {
                                    setState(() {
                                      itenSelect = 0;
                                      subIten1Select = 0;
                                      subIten2Select = 1;
                                    });
                                  }
                                  else if(dat == 2)
                                  {
                                    setState(() {
                                      itenSelect = 0;
                                      subIten1Select = 2;
                                      subIten2Select = 1;
                                    });
                                  }
                                  else
                                  {
                                    setState(() {
                                      itenSelect = -1;
                                      subIten1Select = -1;
                                      subIten2Select = -1;
                                    });
                                  }
                                }
                              }


                      }
                  ),
                  if(sectors.length < 2 || allLines.isEmpty)
                  MenuButton(
                      text: SizedBox(
                          width: wItem,
                          child: Text(S.of(context).shipments)
                      ),
                      onTap: () async {
                            bool go = false;
                            if (saveChanges == false)
                            {
                              go = true;
                            }
                            else
                            {
                              saveChanges =! await changesNoSave(context);

                              if(saveChanges == false)
                              {
                                go = true;
                              }
                            }

                             if(go == true)
                             {
                               if(allLines.isNotEmpty)
                               {
                                 setState(() {
                                   itenSelect = 1;
                                   subIten1Select = 3;
                                   subIten2Select = 0;
                                 });
                               }
                               else
                               {
                                 if(allFactories.isNotEmpty)
                                 {
                                   String array = S.of(context).shipments;
                                   int dat = await noCategory(context, array);


                                   if(dat == 1)
                                   {
                                     setState(() {
                                       itenSelect = 0;
                                       subIten1Select = 0;
                                       subIten2Select = 3;
                                     });
                                   }
                                   else if(dat == 2)
                                   {
                                     setState(() {
                                       itenSelect = 0;
                                       subIten1Select = 2;
                                       subIten2Select = 1;
                                     });

                                   }
                                   else
                                   {
                                     setState(() {
                                       itenSelect = -1;
                                       subIten1Select = -1;
                                       subIten2Select = -1;
                                     });
                                   }
                                 }
                                 else
                                 {
                                   String array = S.of(context).shipments;
                                   await noCategory(context, array);
                                 }
                               }
                             }


                      }
                  ),
                  if(sectors.length > 1 && allLines.isNotEmpty)
                   MenuButton(
                        text: SizedBox(
                            width: wItem,
                            child: Text(S.of(context).shipments)
                        ),
                        submenu:SubMenu(
                            menuItems:
                            [
                              MenuButton(
                                  text: SizedBox(
                                      width:  wItem,
                                      child: Text(S.of(context).allMale)),
                                  onTap: () async {
                                    controllerSearchSend.clear();
                                    if (saveChanges == false)
                                    {
                                      setState(() {
                                        itenSelect = 1;
                                        subIten1Select = 3;
                                        subIten2Select = 0;
                                      });
                                    }
                                    else
                                    {
                                      saveChanges =! await changesNoSave(context);

                                      if(saveChanges == false)
                                      {
                                        setState(() {
                                          itenSelect = 1;
                                          subIten1Select = 3;
                                          subIten2Select = 0;
                                        });
                                      }
                                    }
                                  }
                              ),
                              const MenuDivider(),
                              for(int i = 0 ; i < sectors.length; i++)
                                MenuButton(
                                    text: SizedBox(
                                        width: sectors[i].name.length > 3
                                            ? sectors[i].name.length * 8
                                            : wItem,
                                        child: Text(sectors[i].name)),
                                    onTap: (){
                                      controllerSearchSend.clear();
                                      setState(() {
                                        itenSelect = 1;
                                        subIten1Select = 3;
                                        subIten2Select = i + 1;

                                      });
                                    }
                                ),
                            ]
                        ) ,

                    ),

                ]
            )
        ),
        BarButton (
            text:   SizedBox(
                child: Text(S.of(context).utilities,
                  style: TextStyle(color:colorBar),)),
            submenu: SubMenu(
                menuItems:[
                  MenuButton(
                      text: SizedBox(
                          width: wItemMax,
                          child: Text(S.of(context).sending_mails)),
                      onTap: () async {
                        if(mails.isEmpty)
                        {
                          String action =S.of(context).no_have_registered_mails;
                          error(context,action);
                        }

                        if (saveChanges == false)
                        {
                          setState(() {
                            itenSelect = 2;
                            subIten1Select = 0;
                            subIten2Select = -1;
                          });
                        }
                        else
                        {
                          saveChanges =! await changesNoSave(context);

                          if(saveChanges == false)
                          {
                            setState(() {
                              itenSelect = 2;
                              subIten1Select = 0;
                              subIten2Select = -1;
                            });
                          }
                        }

                      }
                  ),
                  MenuButton(
                      text: SizedBox(
                          width: wItemMax,
                          child: Text(S.of(context).DB_connection)),
                      onTap: () async {

                        if (saveChanges == false)
                        {
                          setState(() {
                            itenSelect = 2;
                            subIten1Select = 1;
                            subIten2Select = -1;
                          });
                        }
                        else
                        {
                          saveChanges =! await changesNoSave(context);

                          if(saveChanges == false)
                          {
                            setState(() {
                              itenSelect = 2;
                              subIten1Select = 1;
                              subIten2Select = -1;
                            });
                          }
                        }
                      }
                  ),
                ]
            )
        ),
      ];
    }
    return mHeight>50.0
    ? MaterialApp(
      theme: ThemeData(
          menuTheme: const MenuThemeData(
            style: MenuStyle(
              padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 16)),
            ),
          )
      ),
      home: MenuBarWidget(
        barButtons: _menuBarButtons(),
        barStyle: const MenuStyle(
          backgroundColor: MaterialStatePropertyAll(Color(0xca0347f3)),
        ),
        child:Container(
          width: mWidth,
          height:  mHeight,
            color: Colors.white,
          child:  FuntionSeleted(itenSelect, subIten1Select, subIten2Select,mWidth, mHeight,context),
        ),
      )

    )
        :Container(
        width: mWidth,
        height:  mHeight,
        color: Colors.white,
        child:  FuntionSeleted(itenSelect, subIten1Select, subIten2Select,mWidth, mHeight,context)
    );
  }


}
