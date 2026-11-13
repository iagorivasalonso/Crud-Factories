import 'package:crud_factories/Alertdialogs/closeApp.dart';
import 'package:crud_factories/Alertdialogs/confirm.dart' show confirm;
import 'package:crud_factories/Alertdialogs/createUser.dart';
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Alertdialogs/login.dart' show LoginPage;
import 'package:crud_factories/Alertdialogs/noCategory.dart';
import 'package:crud_factories/Alertdialogs/warning.dart';
import 'package:crud_factories/Backend/AppContent.dart' show AppContent;
import 'package:crud_factories/Backend/Providers/App_provaider.dart' show AppProvider, DataSourceMode;
import 'package:crud_factories/Backend/Providers/EmployeeProvider.dart' show EmployeeProvider;
import 'package:crud_factories/Backend/Providers/RoutesProvider.dart' show RoutesProvider;
import 'package:crud_factories/Backend/Providers/SessionProvider.dart' show SessionProvider;
import 'package:crud_factories/Backend/core/controlsMessagesError/errors.dart';
import 'package:crud_factories/Backend/Export_general/export_service.dart' show ExportService;
import 'package:crud_factories/Backend/Providers/ConectionProvider.dart';
import 'package:crud_factories/Backend/Providers/FactoryProvider.dart';
import 'package:crud_factories/Backend/Providers/LineSendProvider.dart';
import 'package:crud_factories/Backend/Providers/MailProvider.dart';
import 'package:crud_factories/Backend/Providers/NavigationProvider.dart' show navigationProvider, AppView, NavigationProvider, FilterProvider;
import 'package:crud_factories/Backend/Providers/SectorProvider.dart';
import 'package:crud_factories/Backend/Providers/UserProvider.dart' show UserProvider;
import 'package:crud_factories/Backend/Providers/filterProvider.dart' show FilterProvider;
import 'package:crud_factories/Frontend/Menu/AccountActions.dart';
import 'package:crud_factories/Frontend/Menu/MenuActions.dart' show MenuActions;
import 'package:crud_factories/Frontend/Menu/MenuActionsResults.dart' show MenuActionResult, AppView;
import 'package:crud_factories/Frontend/adminRoutes.dart';
import 'package:crud_factories/Frontend/adminSectors.dart';
import 'package:crud_factories/Objects/Sector.dart' show Sector;
import 'package:crud_factories/Widgets/loadingOverlay.dart' show LoadingOverlay;
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:menu_bar/menu_bar.dart';
import 'package:provider/provider.dart';



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
        final app = context.read<AppProvider>();

        await app.loadApp(context);

        print("✅ APP READY");

        if (app.mode == DataSourceMode.csv)
          return;

        final session = context.read<SessionProvider>();

        if (!session.isAuthenticated || session.user == null) {
          context.read<UserProvider>().select(null);
          LoginPage(context);
        }
      } catch (e, st) {
        print("💥 ERROR INIT:");
        print(e);
        print(st);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    double mWidth = MediaQuery
        .of(context)
        .size
        .width;
    double mHeight = MediaQuery
        .of(context)
        .size
        .height;

    final isLoading = context
        .watch<AppProvider>()
        .isLoading;

    final providerRoutes = context
        .watch<RoutesProvider>()
        .routes;
    final providerconnections = context
        .watch<ConnectionProvider>()
        .connections;
    final providerSectors = context
        .watch<SectorProvider>()
        .sectors;
    final providerFactories = context
        .watch<FactoryProvider>()
        .factories;
    final providerEmployees = context
        .watch<EmployeeProvider>()
        .empleoyees;
    final providerLines = context
        .watch<LineSendProvider>()
        .LineSends;
    final providerMails = context
        .watch<MailProvider>()
        .mails;

    double wItem = 80;
    double wItemMax = 120;
    Color colorBar = Colors.white;

    List<BarButton> _menuBarButtons() {
      return [
        BarButton(
            text: SizedBox(
                child: Text(S
                    .of(context)
                    .file,
                  style: TextStyle(color: colorBar),)),
            submenu: SubMenu(
                menuItems: [
                  MenuButton(
                      text: SizedBox(
                          width: wItem,
                          child: Text(S
                              .of(context)
                              .new_male)
                      ),
                      submenu: SubMenu(
                          menuItems: [
                            MenuButton(
                                text: SizedBox(
                                    width: wItem,
                                    child: Text(S
                                        .of(context)
                                        .company)),
                                onTap: () async {

                                  if (!await MenuActions.createFactory(context)) return;

                                  context.read<NavigationProvider>().go(AppView.createFactory);
                                }
                            ),
                            MenuButton(
                                text: SizedBox(
                                    width: wItem,
                                    child: Text(S
                                        .of(context)
                                        .mail)),
                                onTap: () async {
                                  if (!await MenuActions.createMail(context)) return;

                                  context.read<NavigationProvider>().go(AppView.createAddress);
                                }
                            ),
                            MenuButton(
                                text: SizedBox(
                                    width: wItem,
                                    child: Text(S.of(context).shipment)),
                                onTap: () async {

                                    final result = await MenuActions.createShipments(context);

                                    switch(result)
                                    {
                                      case MenuActionResult.show:
                                        context.read<NavigationProvider>().go(AppView.createShipment);
                                       break;
                                      case MenuActionResult.create:
                                        context.read<NavigationProvider>().go(AppView.createFactory);
                                       break;
                                      case MenuActionResult.importData:
                                          context.read<NavigationProvider>().go(AppView.importData);
                                        break;
                                      case MenuActionResult.cancelled:
                                        break;
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
                          builder: (context) => const AdminRoutesDialog(),
                        );
                      }
                  ),
                  MenuButton(
                      text: SizedBox(
                          width: wItem,
                          child: Text(S
                              .of(context)
                              .import)),
                      onTap: () async {
                        if (!await MenuActions.importData(context)) return;

                        context.read<NavigationProvider>().go(AppView.importData);
                      }
                  ),
                  if(!kIsWeb)
                    MenuButton(
                        text: SizedBox(
                            width: wItem,
                            child: Text(S
                                .of(context)
                                .go_out)
                        ),
                        onTap: () {
                          closeAlert(context);
                        }
                    ),

                ]
            )
        ),
        BarButton(
            text: SizedBox(
                child: Text(S
                    .of(context)
                    .lists,
                  style: TextStyle(color: colorBar),)),
            submenu: SubMenu(
                menuItems: [
                  MenuButton(
                    text: SizedBox(
                        width: wItem,
                        child: Text(S
                            .of(context)
                            .sectors)),
                    onTap: () => MenuActions.openSectors(context),
                  ),

                  if(providerSectors.length < 2 || providerFactories.isEmpty)
                    MenuButton(
                      text: SizedBox(
                          width: wItem,
                          child: Text(S
                              .of(context)
                              .companies)),
                      onTap: () => openFactories(null),
                    ),
                  if(providerSectors.length > 1 && providerFactories.isNotEmpty)
                    MenuButton(
                        text: SizedBox(
                            width: wItem,
                            child: Text(S
                                .of(context)
                                .companies)),
                        submenu: SubMenu(
                            menuItems:
                            [
                              MenuButton(
                                text: SizedBox(
                                    width: wItem,
                                    child: Text(S
                                        .of(context)
                                        .all_female)),
                                onTap: () => openFactories(null),
                              ),
                              const MenuDivider(),

                              for (final sector in providerSectors)
                                MenuButton(
                                  text: Text(sector.name),
                                  onTap: () => openFactories(sector.id),

                                )
                            ]
                        )
                    ),

                  MenuButton(
                    text: SizedBox(
                        width: wItem,
                        child: Text(S
                            .of(context)
                            .mails)),
                    onTap: () => openMails(),
                  ),

                  if(providerSectors.length < 2 || providerLines.isEmpty)
                    MenuButton(
                      text: SizedBox(
                          width: wItem,
                          child: Text(S
                              .of(context)
                              .shipments)
                      ),
                      onTap: () => openShipments(null),
                    ),
                  if(providerSectors.length > 1 && providerLines.isNotEmpty)
                    MenuButton(
                      text: SizedBox(
                          width: wItem,
                          child: Text(S
                              .of(context)
                              .shipments)
                      ),
                      submenu: SubMenu(
                          menuItems:
                          [
                            MenuButton(
                              text: SizedBox(
                                  width: wItem,
                                  child: Text(S
                                      .of(context)
                                      .all_male)),
                              onTap: () => openShipments(null),
                            ),
                            const MenuDivider(),
                            for(final sector in providerSectors)
                              MenuButton(
                                text: SizedBox(
                                    width: sector.name.length > 3
                                        ? sector.name.length * 8
                                        : wItem,
                                    child: Text(sector.name)),
                                onTap: () => openShipments(sector.id),
                              ),
                          ]
                      ),

                    ),

                ]
            )
        ),
        BarButton(
            text: SizedBox(
                child: Text(S
                    .of(context)
                    .utilities,
                  style: TextStyle(color: colorBar),)),
            submenu: SubMenu(
                menuItems: [
                  MenuButton(
                      text: SizedBox(
                          width: wItemMax,
                          child: Text(S
                              .of(context)
                              .sending_mails)),
                      onTap: () async {
                        if (!await MenuActions.sendMail(context)) return;

                        context.read<NavigationProvider>().go(AppView.sendMail);
                      }
                  ),
                  MenuButton(
                      text: SizedBox(
                          width: wItemMax,
                          child: Text(S
                              .of(context)
                              .DB_connection)),
                      onTap: () async {
                        if (!await MenuActions.connectBD(context)) return;

                        context.read<NavigationProvider>().go(
                            AppView.connections);
                      }
                  ),
                ]
            )
        ),

        if(kIsWeb)
          BarButton(
              text: Text(S
                  .of(context)
                  .data,
                style: TextStyle(color: colorBar),),
              submenu: SubMenu(
                  menuItems: [
                    MenuButton(
                      text: SizedBox(
                        width: wItemMax,
                        child: Text(S.of(context).download,),
                      ),
                      onTap: () async {
                        if (providerRoutes.isNotEmpty) {
                          await ExportService.exportAllZip(
                            routes: providerRoutes,
                            connections: providerconnections,
                            sectors: providerSectors,
                            factories: providerFactories,
                            employees: providerEmployees,
                            lines: providerLines,
                            mails: providerMails,
                          );

                          await confirm(context, S
                              .of(context)
                              .export_success);
                        }
                        else {
                          await error(context, S
                              .of(context)
                              .no_data_to_export);
                        }
                      },
                    ),
                  ]
              )
          ),
      ];
    }


    return Stack(
      children: [
        MenuBarWidget(
          barButtons: _menuBarButtons(),
          barStyle: const MenuStyle(
            backgroundColor: MaterialStatePropertyAll(
              Color(0xca0347f3),
            ),
          ),
          child: SizedBox.expand(
            child: Container(
              color: Colors.white,
              child: AppContent(),
            ),
          ),
        ),
        if (context
            .watch<ConnectionProvider>()
            .isConnected == true)
          Positioned(
            right: 0,
            top: 0,
            height: 40,
            child: Container(
              color: const Color(0xca0347f3),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Consumer<SessionProvider>(
                    builder: (context, session, child) {
                      if (!session.isAuthenticated || session.user == null) {
                        return Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                context.read<UserProvider>().select(null);
                                LoginPage(context);
                              },
                              child: Text(S.of(context).login,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),

                            TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => const createUser(),
                                );
                              },
                              child: Text(
                                S.of(context).new_user,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        );
                      }

                      return Material(
                        color: Colors.transparent,
                        child: PopupMenuButton<String>(
                          offset: const Offset(0, 40),
                          onSelected: (value) async {
                            if (value == 'admin') {
                              if (!await context
                                  .read<NavigationProvider>()
                                  .canNavigate(context)) return;

                              context.read<NavigationProvider>().go(
                                  AppView.adminUsers);
                            }

                            if (value == 'logout')
                            {
                                 final closed = await AccountActions.logout(
                                     context,
                                     S.of(context).logout_confirm);


                                 if (!closed || !context.mounted) return;

                                 context.read<NavigationProvider>().go(AppView.home);
                            }

                            if (value == 'account')
                            {
                              if (!AccountActions.prepareAccountEdit(context)) return;

                              showDialog(
                                context: context,
                                builder: (context) => const createUser(),
                              );
                            }

                            if (value == 'delete_account')
                            {

                              final result = await AccountActions.deleteAccount(
                                context,
                                S.of(context).delete_account_confirm,
                              );

                              if (!context.mounted || result == null) return;

                              if (result == DeleteResult.success) {
                                await confirm(context, S
                                    .of(context)
                                    .user_deleted_successfully);

                                if (!context.mounted) return;

                                context.read<NavigationProvider>().go(AppView.home);
                              }
                              else {
                                await error(
                                  context,
                                  S
                                      .of(context)
                                      .account_delete_error,
                                );
                              }
                            }
                          },
                          itemBuilder: (context) =>
                          [
                            if (session.user!.role == 'admin')
                              PopupMenuItem<String>(
                                value: 'admin',
                                child: Row(
                                  children: [
                                    Icon(Icons.admin_panel_settings),
                                    SizedBox(width: 8),
                                    Text(S
                                        .of(context)
                                        .administration),
                                  ],
                                ),
                              ),


                            PopupMenuItem<String>(
                              value: 'account',
                              child: Row(
                                children: [
                                  Icon(Icons.person),
                                  SizedBox(width: 8),
                                  Text(S
                                      .of(context)
                                      .my_account),
                                ],
                              ),
                            ),

                            PopupMenuItem<String>(
                              value: 'logout',
                              child: Row(
                                children: [
                                  Icon(Icons.logout),
                                  SizedBox(width: 8),
                                  Text(S
                                      .of(context)
                                      .logout),
                                ],
                              ),
                            ),

                            PopupMenuItem(
                                value: 'delete_account',
                                child: Row(
                                  children: [
                                    Icon(Icons.delete),
                                    SizedBox(width: 8,),
                                    Text(S
                                        .of(context)
                                        .delete_account)
                                  ],
                                )
                            ),
                          ],
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 100,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              child: Text(
                                '${session.user!.username} ▼',
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        if (isLoading)
          LoadingOverlay()
      ],
    );
  }

  Future<void> openFactories(String? sectorId) async {
    final result = await MenuActions.openFactories(context, sectorId);

    switch (result) {
      case MenuActionResult.show:
        context.read<FilterProvider>().setSector(sectorId ?? "0");
        context.read<NavigationProvider>().go(AppView.factories);
        break;

      case MenuActionResult.create:
        context.read<NavigationProvider>().go(AppView.createFactory);
        break;

      case MenuActionResult.importData:
        context.read<NavigationProvider>().go(AppView.importData);
        break;

      case MenuActionResult.cancelled:
        break;
    }
  }

  Future<void> openShipments(String? sectorId) async {
    final result = await MenuActions.openShipments(context, sectorId);

    switch (result) {
      case MenuActionResult.show:
        context.read<FilterProvider>().setSector(sectorId ?? "0");
        context.read<NavigationProvider>().go(AppView.shipments);
        break;
      case MenuActionResult.cancelled:
      // TODO: Handle this case.
        throw UnimplementedError();

      case MenuActionResult.create:
        context.read<NavigationProvider>().go(AppView.createShipment);
        break;
      case MenuActionResult.importData:
        context.read<NavigationProvider>().go(AppView.importData);
        break;
    }
  }

  Future<void> openMails() async {
    final result = await MenuActions.openMails(context);

    switch (result) {
      case MenuActionResult.show:
        context.read<NavigationProvider>().go(AppView.mails);
        break;

      case MenuActionResult.create:
        context.read<NavigationProvider>().go(AppView.createAddress);
        break;

      case MenuActionResult.importData:
        context.read<NavigationProvider>().go(AppView.importData);
        break;

      case MenuActionResult.cancelled:
        break;
    }
  }

}
