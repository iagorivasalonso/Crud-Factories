import 'package:crud_factories/Alertdialogs/closeApp.dart';
import 'package:crud_factories/Alertdialogs/confirm.dart' show confirm;
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Alertdialogs/noCategory.dart';
import 'package:crud_factories/Alertdialogs/warning.dart';
import 'package:crud_factories/Backend/AppContent.dart' show AppContent;
import 'package:crud_factories/Backend/CSV/Export_general/export_service.dart' show ExportService;
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/Providers/ConectionProvider.dart';
import 'package:crud_factories/Backend/Providers/FactoryProvider.dart';
import 'package:crud_factories/Backend/Providers/LineSendProvider.dart';
import 'package:crud_factories/Backend/Providers/MailProvider.dart';
import 'package:crud_factories/Backend/Providers/NavigationProvider.dart' show navigationProvider, AppView, NavigationProvider;
import 'package:crud_factories/Backend/Providers/SectorProvider.dart';
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Frontend/adminRoutes.dart';
import 'package:crud_factories/Frontend/adminSectors.dart';
import 'package:crud_factories/Functions/changesNoSave.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:menu_bar/menu_bar.dart';
import 'package:provider/provider.dart';
import '../Backend/Providers/App_provaider.dart';
import '../Backend/Providers/EditStateProvider.dart';
import '../Backend/Providers/EmployeeProvider.dart';
import '../Backend/Providers/RoutesProvider.dart';


class appDesktop extends StatefulWidget {
  const appDesktop({super.key});

  @override
  State<appDesktop> createState() => _appDesktopState();
}

class _appDesktopState extends State<appDesktop> {
  late TextEditingController controllerImportPicker = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    WidgetsBinding.instance.addPostFrameCallback((_) async {

      try {
        await context.read<AppProvider>().loadApp(context);

        print("✅ APP READY");

      } catch (e, st) {
        print("💥 ERROR INIT:");
        print(e);
        print(st);
      }


    });
  }
  @override
  void dispose() {
    /*
    controlerConex.namebd.dispose();
    controlerConex.hostbd.dispose();
    controlerConex.portbd.dispose();
    controlerConex.userbd.dispose();
    controlerConex.passbd.dispose();
    super.dispose();*/
  }
  @override
  Widget build(BuildContext context) {

    double mWidth = MediaQuery.of(context).size.width;
    double mHeight = MediaQuery.of(context).size.height;
    
    final providerRoutes = context.watch<RoutesProvider>().routes;
    final providerconnections = context.watch<ConnectionProvider>().connections;
    final providerSectors = context.watch<SectorProvider>().sectors;
    final providerFactories = context.watch<FactoryProvider>().factories;
    final providerEmployees = context.watch<EmployeeProvider>().empleoyees;
    final providerLines = context.watch<LineSendProvider>().LineSends;
    final providerMails = context.watch<MailProvider>().mails;

    double wItem = 80;
    double wItemMax = 120;
    Color colorBar = Colors.white;

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

                                  if (!await canNavigate(context)) return;

                                  context.read<NavigationProvider>()
                                      .go(AppView.createFactory);

                                }
                            ),
                            MenuButton(
                                text: SizedBox(
                                    width: wItem,
                                    child: Text(S.of(context).mail)),
                                onTap: () async {

                                  if (!await canNavigate(context)) return;

                                  context.read<NavigationProvider>()
                                      .go(AppView.createMail);


                                }
                            ),
                            MenuButton(
                                text: SizedBox(
                                    width: wItem,
                                    child: Text(S.of(context).shipment)),
                                onTap: () async {

                                  if (!await canNavigate(context)) return;

                                  context.read<NavigationProvider>()
                                      .go(AppView.createShipment);

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
                          builder: (context) => const AdminRoutesDialog(),
                        );

                      }
                  ),
                  MenuButton(
                      text: SizedBox(
                          width: wItem,
                          child: Text(S.of(context).import)),
                      onTap: () async {

                        if (!await canNavigate(context)) return;

                        context.read<NavigationProvider>()
                            .go(AppView.importData);

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
                        await newSector(context);
                      }
                  ),
                  if(providerSectors.length < 2 || providerFactories.isEmpty)
                    MenuButton(
                        text: SizedBox(
                            width: wItem,
                            child: Text(S.of(context).companies)),
                            onTap: () async {

                                if(!await canNavigate(context)) return;

                                if(providerFactories.isNotEmpty)
                                {
                                  context.read<NavigationProvider>()
                                      .go(AppView.factories);
                                }
                                else
                                {
                                   final result = await noCategory(
                                       context,
                                       S.of(context).companies
                                   );

                                   if(result== 1)
                                   {
                                     context.read<NavigationProvider>()
                                         .go(AppView.factories);
                                   }
                                   else
                                   {
                                     context.read<NavigationProvider>()
                                         .go(AppView.importData);
                                   }
                                }
                            }
                    ),
                  if(providerSectors.length > 1 && providerFactories.isNotEmpty)
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
                                    if(!await canNavigate(context)) return;

                                    context.read<NavigationProvider>().go(AppView.createFactory);
                                  }
                              ),
                              const MenuDivider(),

                              for (final sector in providerSectors)
                              MenuButton(
                                  text: Text(sector.name),
                                  onTap: () async {

                                    if(!await canNavigate(context)) return;

                                    context.read<NavigationProvider>().go(
                                      AppView.factories,
                                      sector: sector.id,
                                    );
                                  }
                              )
                            ]
                        )
                    ),

                  MenuButton(
                      text: SizedBox(
                          width: wItem,
                          child: Text(S.of(context).mails)),
                      onTap: () async {

                        if(!await canNavigate(context)) return;

                        context.read<NavigationProvider>().go(AppView.mails);

                      }
                  ),

                  if(providerSectors.length < 2 || providerLines.isEmpty)
                  MenuButton(
                      text: SizedBox(
                          width: wItem,
                          child: Text(S.of(context).shipments)
                      ),
                      onTap: () async {
                             if(!await canNavigate(context)) return;

                             if(providerLines.isNotEmpty)
                             {
                                 context.read<NavigationProvider>()
                                     .go(AppView.shipments);
                             }
                             else
                             {
                                 if(providerFactories.isEmpty)
                                 {
                                   String array = S.of(context).shipments;
                                   noCategory(context, array);
                                   return;
                                 }

                                 final result = await noCategory(
                                   context,
                                   S.of(context).shipments,
                                 );

                                 if(result == 1)
                                 {
                                   context.read<NavigationProvider>()
                                       .go(AppView.shipments);
                                 }
                                 else if(result == 2)
                                 {
                                    context.read<NavigationProvider>()
                                        .go(AppView.importData);
                                 }

                             }
                      }
                  ),
                  if(providerSectors.length > 1 && providerLines.isNotEmpty)
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
                                      if(!await canNavigate(context)) return;

                                      context.read<NavigationProvider>()
                                          .go(AppView.shipments);
                                  }
                              ),
                              const MenuDivider(),
                              for(final sector in providerSectors)
                                MenuButton(
                                    text: SizedBox(
                                        width: sector.name.length > 3
                                            ? sector.name.length * 8
                                            : wItem,
                                        child: Text(sector.name)),
                                    onTap: () async {
                                      if(!await canNavigate(context)) return;

                                      context.read<NavigationProvider>().go(
                                         AppView.shipments,
                                         sector: sector.id
                                      );
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

                        if(!await canNavigate(context)) return;

                         bool enter = true;
                        if(providerMails.isEmpty)
                        {
                          String action =S.of(context).if_you_have_no_registered_emails_do_you_wish_to_continue;
                          enter = await warning(context,action);
                        }

                        if(!enter) return;

                        context.read<NavigationProvider>().go(AppView.sendMail);

                      }
                  ),
                  MenuButton(
                      text: SizedBox(
                          width: wItemMax,
                          child: Text(S.of(context).DB_connection)),
                      onTap: () async {

                        if(!await canNavigate(context)) return;

                        context.read<NavigationProvider>().go(AppView.connections);
                      }
                  ),
                ]
            )
        ),

        if(kIsWeb)
        BarButton(
            text: Text(S.of(context).data,
                   style: TextStyle(color:colorBar),),
            submenu: SubMenu(
               menuItems: [
                 MenuButton(
                   text: SizedBox(
                     width: wItemMax,
                     child: Text(S.of(context).download,),
                   ),
                   onTap: () async {

                        if(routeFirst.isNotEmpty && providerRoutes.isNotEmpty)
                        {
                              await ExportService.exportAllZip(
                                routes: providerRoutes,
                                connections: providerconnections,
                                sectors: providerSectors,
                                factories: providerFactories,
                                employees: providerEmployees,
                                lines: providerLines,
                                mails: providerMails,
                              );

                              await confirm(context,S.of(context).export_success);
                        }
                        else
                        {
                               await error(context,S.of(context).no_data_to_export);
                        }


                   },
                 ),
               ]
            )
         ),
      ];
    }

    return mHeight>50.0

    ? MenuBarWidget(
      barButtons: _menuBarButtons(),
      barStyle: const MenuStyle(
        backgroundColor: MaterialStatePropertyAll(Color(0xca0347f3)),
      ),
      child:Container(
        width: mWidth,
        height:  mHeight,
        color: Colors.white,
        child:  AppContent(),
      ),
    )
        :Container(
        width: mWidth,
        height:  mHeight,
        color: Colors.white,
        child:  AppContent(),
    );

  }

  Future<bool> canNavigate(BuildContext context) async {

      final provider = context.read<EditStateProvider>();

      if (!provider.hasChanges) return true;

      final ok = await changesNoSave(context);

      if (ok) {
        provider.clear();
      }

      return ok;
    }

}

