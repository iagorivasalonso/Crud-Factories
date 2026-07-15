import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Backend/Data/controlsMessagesError/errors.dart' show EditResult, CreateResult, DeleteResult;
import 'package:crud_factories/Backend/Feature/Connection/Controller/ConnectionController.dart' show Connectioncontroller, ConnectResultModel, DisconnectResult;
import 'package:crud_factories/Backend/Global/controllers/Conection.dart' show connectionControler;
import 'package:crud_factories/Backend/Providers/App_provaider.dart';
import 'package:crud_factories/Backend/Providers/ConectionProvider.dart';
import 'package:crud_factories/Backend/Providers/EditStateProvider.dart' show EditStateProvider;
import 'package:crud_factories/Objects/ApiConfig.dart' show ApiConfig;
import 'package:crud_factories/Objects/Conection.dart';
import 'package:crud_factories/Widgets/headViewsAndroid.dart' show appBarAndroid;
import 'package:crud_factories/Widgets/layoutVariant.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crud_factories/Functions/isNotAndroid.dart';
import 'package:crud_factories/Widgets/dropDownButton.dart';
import 'package:crud_factories/Widgets/headView.dart';
import 'package:crud_factories/Widgets/materialButton.dart';
import 'package:crud_factories/Widgets/textFieldPassword.dart';
import 'package:crud_factories/Widgets/textfield.dart';
import '../Alertdialogs/confirm.dart';
import '../Backend/Feature/Sector/apiSectorDataSource .dart';

class conection extends StatefulWidget {

  State<conection> createState() => _conectionState();
}

class _conectionState extends State<conection> {


  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();

  late connectionControler controlerConex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controlerConex = connectionControler(
      namebd: TextEditingController(),
      hostbd: TextEditingController(),
      portbd: TextEditingController(),
      userbd: TextEditingController(),
      passbd: TextEditingController(),
    );


  }

  bool _loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final provider = context.read<ConnectionProvider>();

    if (!_loaded && provider.selected != null) {

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _loadConection(provider.selected!, provider);
      });
      _loaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {


    final provider = context.watch<ConnectionProvider>();

    final editCamps = true;

    if (!isNotAndroid()) {
      return Scaffold(
        body: Scrollbar(
          controller: verticalScroll,
          thumbVisibility: true,
          child: Scrollbar(
            controller: horizontalScroll,
            thumbVisibility: true,
            notificationPredicate: (notification) =>
            notification.metrics.axis == Axis.horizontal,
            child: SingleChildScrollView(
              controller: verticalScroll,
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                controller: horizontalScroll,
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0, top: 30.0),
                  child: Container(
                    constraints: BoxConstraints(
                      minWidth: MediaQuery
                          .of(context)
                          .size
                          .width,
                      minHeight: MediaQuery
                          .of(context)
                          .size
                          .height,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        width: 850,
                        child: Column(
                          children: [
                            headView(
                                title: S
                                    .of(context)
                                    .database_connection
                            ),

                            layoutVariant(
                                items:
                                [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30.0, top: 30.0),
                                    child: SizedBox(
                                      width: 700,
                                      height: 40,
                                      child: GenericDropdown<Conection>(
                                        items: provider.connections,
                                        camp: S
                                            .of(context)
                                            .database_connection,
                                        selectedItem: provider.selected,
                                        hint: S
                                            .of(context)
                                            .newFemale,
                                        itemLabel: (Conection) =>
                                        Conection.database,
                                        onChanged: (c) async {
                                    //      if (!await canNavigate(context))
                                        //    return;

                                          provider.select(c);

                                          _loadConection(c, provider);
                                        },
                                      ),
                                    ),
                                  ),


                                  Padding(
                                    padding: const EdgeInsets.only(top: 30.0),
                                    child: materialButton(
                                        nameAction: provider.editButtonLabel(
                                            context),
                                        function: () {
                                          final ok = provider.toggleEditMode();
                                          if (!ok) {
                                            String message = S
                                                .of(context)
                                                .not_connected_to_any_database;
                                            error(context, message);
                                          }
                                        }
                                    ),
                                  ),
                                ]),

                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: SizedBox(
                                  width: 350,
                                  child: defaultTextfield(
                                    context: context,
                                    nameCamp: S
                                        .of(context)
                                        .data_base,
                                    controllerCamp: controlerConex.namebd,
                                    campEdit: editCamps,
                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: layoutVariant(
                                  items: [
                                    Expanded(
                                      child: defaultTextfield(
                                        context: context,
                                        nameCamp: S
                                            .of(context)
                                            .host,
                                        controllerCamp: controlerConex.hostbd,
                                        campEdit: editCamps,
                                      ),
                                    ),
                                    Expanded(
                                      child:
                                      defaultTextfield(
                                        context: context,
                                        nameCamp: S
                                            .of(context)
                                            .port,
                                        controllerCamp: controlerConex.portbd,
                                        campEdit: editCamps,
                                      ),
                                    ),
                                  ]
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: layoutVariant(
                                  items: [
                                    Expanded(
                                      child: defaultTextfield(
                                        context: context,
                                        nameCamp: S
                                            .of(context)
                                            .user,
                                        controllerCamp: controlerConex.userbd,
                                        campEdit: editCamps,
                                      ),

                                    ),
                                    Expanded(
                                      child:
                                      textfieldPassword(
                                        nameCamp: S
                                            .of(context)
                                            .password,
                                        context: context,
                                        controllerCamp: controlerConex.passbd,
                                        campEdit: editCamps,
                                      ),
                                    ),
                                  ]),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 620.0, top: 80.0),
                              child: layoutVariant(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                items: [
                                  materialButton(
                                      nameAction: provider.action1Label(
                                          context),
                                      function: () =>
                                          _handleAction1(context, provider)

                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: materialButton(
                                        nameAction: provider.action2Label(
                                            context),
                                        function: () =>
                                            _handleAction2(context, provider)

                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: appBarAndroid(context, name: S
            .of(context)
            .database_connection),
        body: Text("conection"),
      );
    }
  }

  Future<void> _loadConection(Conection? c, ConnectionProvider provider) async {
    if (c == null) return;

    controlerConex.namebd.text = c.database;
    controlerConex.hostbd.text = c.host;
    controlerConex.portbd.text = c.port;
    controlerConex.userbd.text = c.user;
    controlerConex.passbd.text = c.password;

    provider.select(c);

    final config = ApiConfig(
      host: controlerConex.hostbd.text,
      port: controlerConex.portbd.text,
      database: controlerConex.namebd.text,
      user: controlerConex.userbd.text,
      password: controlerConex.passbd.text,
    );

    provider.setConfig(config);
  }

  void _handleAction1(BuildContext context, ConnectionProvider provider) async {

    final controller = context.read<Connectioncontroller>();

    if (provider.viewMode == ConnectionViewMode.editing) //edicion de conexion
    {
          final update = Conection(
            id: provider.selected!.id,
            database: controlerConex.namebd.text,
            host: controlerConex.hostbd.text,
            port: controlerConex.portbd.text,
            user: controlerConex.userbd.text,
            password: controlerConex.passbd.text,
          );

          final result = await controller.update(provider.selected!, update);

          switch(result)
          {
            case EditResult.invalidData:
              await error(context, S.of(context).can_not_find_the_connection);
             break;

            case EditResult.success:
             await confirm(context, S.of(context).connection_has_been_successfully_edited);
              break;

            case EditResult.alreadyExists:
                  await error(context, S.of(context).the_connection_already_exists);
              break;

            case EditResult.notFound:
             await error(context, S.of(context).can_not_find_the_connection);
              break;

            case EditResult.error:
              await error(context, S.of(context).could_not_be_edited);
              break;
          }
          context.read<EditStateProvider>().clear();
          provider.toggleEditMode();

          return;
    }


    if (provider.selected == null) {
      final newConnection = Conection(
        id: "-",
        database: controlerConex.namebd.text,
        host: controlerConex.hostbd.text,
        port: controlerConex.portbd.text,
        user: controlerConex.userbd.text,
        password: controlerConex.passbd.text,
      );

       final result = await controller.create(newConnection);

       switch(result)
       {
         case CreateResult.invalidData:
           await error(context, S.of(context).can_not_find_the_connection);
           break;

         case CreateResult.alreadyExists:
           await error(context, S.of(context).the_connection_already_exists);
           break;

         case CreateResult.success:
            await confirm(context, S.of(context).connection_has_been_successfully_created);
           break;
       }
      context.read<EditStateProvider>().clear();
      return;
    }

    if (!provider.isConnected)
    {
        final file =context.read<AppProvider>().files;
        print(file?.server);
        final result = await controller.connectSQL(context,file?.server);

        if (result.success) {


          final message = "${S.of(context).is_connected_to} ${provider.selected!.database}";

          await confirm(context, message);

          await context.read<AppProvider>().switchSource(
            context,
            context.read<AppProvider>().isApi == true
               ?  DataSourceMode.api
               :  DataSourceMode.sql,
          );

        } else {
          await error(
            context,
            result.errorMessage ?? "Error desconocido",
          );
        }
    }
    else
    {
         var message = await controller.disconnect();

         switch(message){
           case DisconnectResult.success:

             await context.read<AppProvider>().switchSource(
               context,
               DataSourceMode.csv,
             );

             await confirm(context, S.of(context).properly_disconnected);

           case DisconnectResult.noConnection:
             await error(context, S.of(context).You_must_have_a_selected_connection);
           case DisconnectResult.error:
             await error(context, S.of(context).cannot_disconnect);
           break;
         }
    }
  }

  void _handleAction2(BuildContext context, ConnectionProvider provider) async {

    final controller = context.read<Connectioncontroller>();

    if (provider.viewMode == ConnectionViewMode.editing) {
      provider.toggleEditMode();

      _loadConection(provider.selected, provider);

      return;
    }

    final selected = provider.selected;

    if (selected != null)
    {
        final delete = await controller.delete(selected);

        switch(delete) {
          case DeleteResult.notFound:
            error(context, S.of(context).no_connection_found);
            break;
          case DeleteResult.error:
            error(context, S.of(context).could_not_be_deleted);
            break;

          case DeleteResult.hasDependencies:
            // TODO: Handle this case.
            throw UnimplementedError();
          case DeleteResult.success:
            await confirm(context, S.of(context).connection_has_been_successfully_deleted);
            break;

        }
    }
  }

}