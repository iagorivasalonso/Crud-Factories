import 'package:crud_factories/Alertdialogs/closeApp.dart';
import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Alertdialogs/create%20sector.dart';
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Alertdialogs/noCategory.dart';
import 'package:crud_factories/Alertdialogs/typeConnection.dart';
import 'package:crud_factories/Backend/CSV/chargueData%20csv.dart';
import 'package:crud_factories/Backend/CSV/importConections.dart';
import 'package:crud_factories/Backend/_selection_view.dart';
import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Frontend/adminSector.dart';
import 'package:crud_factories/Functions/changesNoSave.dart';
import 'package:flutter/material.dart';
import 'package:menu_bar/menu_bar.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    chargueDataCSV();

    conections.clear();

    try {
      conections.add(csvImportConections(fileContent, conections));

    } catch (Exeption) {

    }
    WidgetsBinding.instance?.addPostFrameCallback((_) async {



          bool SQLbd = await typeConection(context);

          if(SQLbd == true)
          {
            setState(() {
              itenSelect = 2;
              subIten1Select = 1;
            });
          }

    });

  }

  @override
  Widget build(BuildContext context) {

    double mWidth = MediaQuery.of(context).size.width;
    double mHeight = MediaQuery.of(context).size.height;

    double wItem= 80;
    double wItemMax= 120;
    Color colorBar =Colors.white;

    List<BarButton> _menuBarButtons() {
      return [
        BarButton (
            text:   SizedBox(
                child: Text('Archivo',
                  style: TextStyle(color:colorBar),)),
            submenu: SubMenu(
                menuItems:[
                  MenuButton(
                      text: SizedBox(
                          width: wItem,
                          child: const Text("Nuevo")
                      ),
                      submenu: SubMenu(
                          menuItems: [
                            MenuButton(
                                text: SizedBox(
                                    width:wItem,
                                    child: const Text("Empresa")),
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
                                    child: const Text("Email")),
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
                                    child: const Text("Envio")),
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
                                   if(factories.isNotEmpty)
                                   {
                                     setState(() {
                                       itenSelect = 0;
                                       subIten1Select = 0;
                                       subIten2Select = 2;
                                     });
                                   }
                                   else
                                   {
                                     String action ='No puede hacer el envio porque no tiene empresas en su base de datos';
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
                          child: const Text("Importar")),
                      onTap: () async {

                        if (saveChanges == false)
                        {
                          setState(() {
                            itenSelect = 0;
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
                              itenSelect = 0;
                              subIten1Select = 1;
                              subIten2Select = -1;
                            });
                          }
                        }

                      }
                  ),
                  MenuButton(
                      text:  SizedBox(
                          width: wItem,
                          child: const Text("Salir")
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
                child: Text('Listas',
                  style: TextStyle(color:colorBar),)),
            submenu: SubMenu(
                menuItems:[
                  MenuButton(
                      text: SizedBox(
                          width: wItem,
                          child: const Text("Sectores")),
                      onTap: () async {
                              if(sectors.isNotEmpty)
                              {
                                setState(() {
                                  adminSector(context);
                                });
                              }
                              else
                              {
                                String modif = "nuevo";
                                bool create = await createSector(context,modif);

                                if(create == true)
                                {
                                  setState((){
                                    String action = 'El sector se ha creado correctamente';
                                    confirm(context, action);
                                  });
                                }
                              }


                      }
                  ),
                  if(sectors.length < 2 || factories.isEmpty)
                    MenuButton(
                        text: SizedBox(
                            width: wItem,
                            child: const Text("Empresas")),
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

                                if(factories.isNotEmpty)
                                {
                                  setState(() {
                                    itenSelect = 1;
                                    subIten1Select = 0;
                                    subIten2Select = 0;
                                  });
                                }
                                else
                                {
                                  String array = "empresas";
                                  int dat = await noCategory(context, array);

                                  if(dat == 1)
                                  {
                                    setState(() {
                                      itenSelect = 0;
                                      subIten1Select = 0;
                                      subIten2Select = 0;
                                    });
                                  }
                                  else
                                  {
                                    setState(() {
                                      itenSelect = 0;
                                      subIten1Select = 1;
                                      subIten2Select = 0;
                                    });
                                  }
                                }
                              }

                            }
                    ),
                  if(sectors.length>1 && factories.isNotEmpty)
                  MenuButton(
                        text: SizedBox(
                            width: wItem,
                            child: const Text("Empresas")),
                        submenu: SubMenu(
                            menuItems:
                            [
                              MenuButton(
                                  text: SizedBox(
                                      width:  wItem,
                                      child: Text("Todas")),
                                  onTap: () async {
                                    if (saveChanges == false)
                                    {
                                      setState(() {
                                        itenSelect = 1;
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
                                          itenSelect = 1;
                                          subIten1Select = 0;
                                          subIten2Select = 0;
                                        });
                                      }
                                    }
                                  }
                              ),
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
                                        subIten1Select = 0;
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
                          child: const Text("Emails")),
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
                                    subIten1Select = 1;
                                  });
                                }
                                else
                                {
                                  String array = "emails";
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
                                      subIten1Select = 1;
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

                  if(sectors.length<2)
                  MenuButton(
                      text: SizedBox(
                          width: wItem,
                          child: const Text("Envios")
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
                               if(line.isNotEmpty)
                               {
                                 setState(() {
                                   itenSelect = 1;
                                   subIten1Select = 2;
                                 });
                               }
                               else
                               {
                                 if(factories.isNotEmpty)
                                 {
                                   String array = "envios";
                                   int dat = await noCategory(context, array);


                                   if(dat == 1)
                                   {
                                     setState(() {
                                       itenSelect = 0;
                                       subIten1Select = 0;
                                       subIten2Select = 2;
                                     });
                                   }
                                   else if(dat == 2)
                                   {
                                     setState(() {
                                       itenSelect = 0;
                                       subIten1Select = 1;
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
                                   String array ="envios";
                                   await noCategory(context, array);
                                 }
                               }
                             }


                      }
                  ),
                  if(sectors.length>1)
                    MenuButton(
                        text: SizedBox(
                            width: wItem,
                            child: const Text("Envios")
                        ),
                        submenu:SubMenu(
                            menuItems:
                            [
                              MenuButton(
                                  text: SizedBox(
                                      width:  wItem,
                                      child: Text("Todos")),
                                  onTap: () async {
                                    if (saveChanges == false)
                                    {
                                      setState(() {
                                        itenSelect = 1;
                                        subIten1Select = 2;
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
                                          subIten1Select = 2;
                                          subIten2Select = 0;
                                        });
                                      }
                                    }
                                  }
                              ),
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
                                        subIten1Select = 2;
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
                child: Text('Utilidades',
                  style: TextStyle(color:colorBar),)),
            submenu: SubMenu(
                menuItems:[
                  MenuButton(
                      text: SizedBox(
                          width: wItemMax,
                          child: const Text("Envio de emails")),
                      onTap: () async {
                        if(mails.isEmpty)
                        {
                          String action ='No tiene emails registrados';
                          error(context,action);
                        }

                        if (saveChanges == false)
                        {
                          setState(() {
                            itenSelect = 2;
                            subIten1Select = 0;
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
                            });
                          }
                        }

                      }
                  ),
                  MenuButton(
                      text: SizedBox(
                          width: wItemMax,
                          child: const Text("Conexion BD")),
                      onTap: () async {

                        if (saveChanges == false)
                        {
                          setState(() {
                            itenSelect = 2;
                            subIten1Select = 1;
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
    return MaterialApp(
      theme: ThemeData(
          menuTheme: const MenuThemeData(
            style: MenuStyle(
              padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 16)),
            ),
          )
      ),
      home: mHeight> 40
        ? MenuBarWidget(
        barButtons: _menuBarButtons(),
        barStyle: const MenuStyle(
          backgroundColor: MaterialStatePropertyAll(Color(0xca0347f3)),
        ),
        child:Container(
          width: mWidth,
          height: mHeight,
          color: Colors.white,
          child:  FuntionSeleted(itenSelect, subIten1Select, subIten2Select,mWidth, mHeight)
        ),
      )
      : Container(
        color: Colors.white,
      ),
    );
  }


}
