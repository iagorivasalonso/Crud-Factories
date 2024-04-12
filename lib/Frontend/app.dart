import 'package:crud_factories/Alertdialogs/closeApp.dart';
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Alertdialogs/noCategory.dart';
import 'package:crud_factories/Backend/_selection_view.dart';
import 'package:crud_factories/Backend/importFactories.dart';
import 'package:crud_factories/Backend/importLines.dart';
import 'package:crud_factories/Backend/importMails.dart';
import 'package:crud_factories/Objects/Factory.dart';
import 'package:crud_factories/Objects/Mail.dart';
import 'package:crud_factories/Objects/lineSend.dart';
import 'package:flutter/material.dart';
import 'package:menu_bar/menu_bar.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  int itenSelect = -1;
  int subIten1Select = -1;
  int subIten2Select = -1;

  List<Factory> factories = [];
  List<Mail> mails =[];
  List<lineSend> line = [];
  List<String> fileContent =[];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    factories.clear();

    try {
      factories.add(importFactory(fileContent, factories));
    } catch (Exeption) {

    }

    mails.clear();
    try {
      mails.add(importMail(fileContent, mails));
    } catch (Exeption) {

    }

    line.clear();
    try {
      line.add(importLines(fileContent, line));
    } catch (Exeption) {

    }
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
                                onTap: (){
                                  setState(() {
                                    itenSelect = 0;
                                    subIten1Select = 0;
                                    subIten2Select = 0;
                                  });

                                }
                            ),
                            MenuButton(
                                text: SizedBox(
                                    width: wItem,
                                    child: const Text("Email")),
                                onTap: (){
                                  setState(() {
                                    itenSelect = 0;
                                    subIten1Select = 0;
                                    subIten2Select = 1;
                                  });
                                }
                            ),
                            MenuButton(
                                text: SizedBox(
                                    width: wItem,
                                    child: const Text("Envio")),
                                onTap: (){

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
                      onTap: (){
                        setState(() {
                          itenSelect = 0;
                          subIten1Select = 1;
                        });

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
                          child: const Text("Empresas")),
                      onTap: () async {

                             if(factories.isNotEmpty)
                             {
                                 setState(() {
                                    itenSelect = 1;
                                    subIten1Select = 0;
                                 });

                             }
                             else
                             {
                                String array = "empresas";
                                bool dat = await noCategory(context, array);

                                 if(dat == true)
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
                  ),
                  MenuButton(
                      text: SizedBox(
                          width: wItem,
                          child: const Text("Emails")),
                      onTap: () async {

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
                                bool dat = await noCategory(context, array);

                                if(dat == true)
                                {
                                  setState(() {
                                    itenSelect = 0;
                                    subIten1Select = 0;
                                    subIten2Select = 1;
                                  });
                                }
                                else
                                {
                                  setState(() {
                                    itenSelect = 0;
                                    subIten1Select = 1;
                                    subIten2Select = 1;
                                  });
                                }
                              }

                      }
                  ),
                  MenuButton(
                      text: SizedBox(
                          width: wItem,
                          child: const Text("Envios")
                      ),
                      onTap: () async {
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
                                bool dat = await noCategory(context, array);

                                if(dat == true)
                                {
                                  print("1");
                                  setState(() {
                                    itenSelect = 0;
                                    subIten1Select = 0;
                                    subIten2Select = 2;
                                  });
                                }
                                else
                                {

                                  setState(() {
                                    itenSelect = 0;
                                    subIten1Select = 1;
                                    subIten2Select = 1;
                                  });
                                }
                              }
                              else
                              {
                                String action ='No puede hacer el envio porque no tiene empresas en su base de datos';
                                error(context,action);
                              }
                           }

                      }
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
                      onTap: (){
                        if(mails.isEmpty)
                        {
                          String action ='No tiene emails registrados';
                          error(context,action);
                        }
                        setState(() {
                          itenSelect = 2;
                          subIten1Select = 0;
                        });
                      }
                  ),
                  MenuButton(
                      text: SizedBox(
                          width: wItemMax,
                          child: const Text("Conexion BD")),
                      onTap: (){
                        setState(() {
                          itenSelect = 2;
                          subIten1Select = 1;
                        });
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
      home:  MenuBarWidget(
        barButtons: _menuBarButtons(),
        barStyle: const MenuStyle(
          backgroundColor: MaterialStatePropertyAll(Color(0xca0347f3)),
        ),
        child:Container(
          width: mWidth,
          height: mHeight,
          color: Colors.white,
          child: mHeight> 40
              ?  FuntionSeleted(itenSelect, subIten1Select, subIten2Select,mWidth, mHeight,factories,mails,line)
              : Container(
            color: Colors.white,
          ),

        ),
      ),
    );
  }
}
