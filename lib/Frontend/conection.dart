import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:crud_factories/Alertdialogs/confirmDelete.dart';
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Alertdialogs/warning.dart';
import 'package:crud_factories/Backend/CSV/exportConections.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Backend/SQL/importLines.dart';
import 'package:crud_factories/Backend/providers/Conection_provider.dart';
import 'package:crud_factories/Objects/Conection.dart';
import 'package:crud_factories/Widgets/headViewsAndroid.dart' show appBarAndroid;
import 'package:crud_factories/Widgets/layoutVariant.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Alertdialogs/confirm.dart';
import '../Backend/CSV/loader.dart';
import '../Backend/SQL/importEmpleoye.dart';
import '../Backend/SQL/importFactories.dart';
import '../Backend/SQL/importMail.dart';
import '../Backend/SQL/importSector.dart';
import '../Functions/createId.dart';
import '../Functions/isNotAndroid.dart';
import '../Widgets/dropDownButton.dart';
import '../Widgets/headView.dart';
import '../Widgets/materialButton.dart';
import '../Widgets/textFieldPassword.dart';
import '../Widgets/textfield.dart';

class conection extends StatefulWidget {


   conection();


  State<conection> createState() => _conectionState();
}

class _conectionState extends State<conection> {


  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();

  double widthBar = 10.0;


  final namebd = TextEditingController();
  final hostbd = TextEditingController();
  final portbd = TextEditingController();
  final userbd = TextEditingController();
  final passbd = TextEditingController();


  @override
  void dispose() {
    namebd.dispose();
    hostbd.dispose();
    portbd.dispose();
    userbd.dispose();
    passbd.dispose();
    horizontalScroll.dispose();
    verticalScroll.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final provider = context.read<ConectionProvider>();
    _restore(provider);

  }

  @override
  Widget build(BuildContext context0) {
    BuildContext context = isNotAndroid() ? context0 : context1;

    final provider = context.watch<ConectionProvider>();

    bool editCamps = true;

    if(provider.status != ConnectionStatus.connected)
    {
      editCamps = true;
    }
    else
    {
      editCamps = provider.viewMode == ConnectionViewMode.editing
               ? true
               : false;
    }

    return !isNotAndroid()
        ? Scaffold(
      body: AdaptiveScrollbar(
        controller: verticalScroll,
        width: widthBar,
        child: AdaptiveScrollbar(
          controller: horizontalScroll,
          width: widthBar,
          position: ScrollbarPosition.bottom,
          underSpacing: const EdgeInsets.only(bottom: 8),
          child: SingleChildScrollView(
            controller: verticalScroll,
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              controller: horizontalScroll,
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                height: 478,
                width: 850,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, top: 30.0),
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
                                    items: conections,
                                    camp: S
                                        .of(context)
                                        .database_connection,
                                    selectedItem: provider.selected,
                                    hint: S
                                        .of(context)
                                        .newFemale,
                                    itemLabel: (Conection) =>
                                    Conection.database,
                                    onChanged: (conectionChoose) =>provider.status != ConnectionStatus.connected
                                       ? _onConectionChanged(conectionChoose,provider)
                                       : null,
                                  ),
                                ),
                              ),


                              Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: materialButton(
                                  nameAction: provider.actionEditLabel(context),
                                  function: ()  {
                                       final ok = provider.toggleEditMode();
                                       if(!ok)
                                       {
                                           String message = S.of(context).not_connected_to_any_database;
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
                                nameCamp: S
                                    .of(context)
                                    .data_base,
                                controllerCamp: namebd,
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
                                    nameCamp: S
                                        .of(context)
                                        .host,
                                    controllerCamp: hostbd,
                                    campEdit: editCamps,
                                  ),
                                ),
                                Expanded(
                                  child:
                                  defaultTextfield(
                                    nameCamp: S
                                        .of(context)
                                        .port,
                                    controllerCamp: portbd,
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
                                    nameCamp: S
                                        .of(context)
                                        .user,
                                    controllerCamp: userbd,
                                    campEdit: editCamps,
                                  ),

                                ),
                                Expanded(
                                  child:
                                  textfieldPassword(
                                    nameCamp: S
                                        .of(context)
                                        .password,
                                    controllerCamp: passbd,
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
                                nameAction: provider.action1Label(context),
                                function: () => _handleAction1(context,provider)

                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: materialButton(
                                  nameAction: provider.action2Label(context),
                                  function: () => _handleAction2(context,provider)

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
    )
        : Scaffold(
      appBar: appBarAndroid(context, name: S
          .of(context)
          .database_connection),
      body: Text("conection"),
    );
  }

  void _handleAction1(BuildContext context,ConectionProvider provider) {

    final actionLabel = provider.action1Label(context);

    actionLabel == S.of(context).newFemale
      ? _createConex(context, provider)
        : provider.viewMode == ConnectionViewMode.normal
          ?  _actionConnect(context, provider)
          :  _editConex(context, provider);


  }

  void _handleAction2(BuildContext context,ConectionProvider provider) {

    final actionLabel = provider.action2Label(context);
    actionLabel== S.of(context).undo
      ? _restore(provider)
      : _deleteConex(context, provider);

  }


  Future<void> _actionConnect(BuildContext context, ConectionProvider provider) async {

    if (provider.status == ConnectionStatus.connected) {

      final connected = await provider.disconnet();


      if(connected==false)
      {
        sectors.clear();
        allFactories.clear();
        empleoyes.clear();
        mails.clear();
        allLines.clear();


        await csvLoaderService.loadRemainingRoutes(context,routesCSV);

        String action = S.of(context).has_closed_the_connection;
        confirm(context, action);
      }
      else
      {
        String action = S.of(context).cannot_disconnect;
        error(context, action);
      }

    } else {

      Conection? modify;
      if(saveChanges == true)
      {
        modify =Conection(
          id: provider.selected?.id ?? "-",
          database: namebd.text,
          port: portbd.text,
          host: hostbd.text,
          user: userbd.text,
          password: passbd.text,
        );
        provider.setTempConnection(modify);
      }

      final conectionTrue = await provider.connect(context);
      if(conectionTrue==selectedDb) //si no hay error ya pone la conex
      {
        sectors.clear();
        allFactories.clear();
        empleoyes.clear();
        mails.clear();
        allLines.clear();
        // Esperamos a que las funciones de carga terminen

        await sqlImportSetors();
        await sqlImportFactories();
        await sqlImportLines();
        await sqlImportEmpleoyes();
        await sqlImportMails();

        String action = "${S.of(context).is_connected_to}$selectedDb";
         await confirm(context, action);

         if(modify != null)
         {
             String action = S.of(context).the_connection_has_changed_do_you_want_to_save_it;
              bool changue = await warning(context, action);

              if(changue)
              {
                String id = modify.id;
                final index = conections.indexWhere((c) => c.id == id);
                conections[index] = modify;
                if (index != -1)
                {
                  String action = S.of(context).connection_has_been_successfully_edited;
                  await confirm(context, action);

                  csvExportatorConections(conections);
                }

              }
         }
      }
      else
      {
         //si no es true
         error(context, conectionTrue);
      }

    }

  }

  Future<void> _onConectionChanged(Conection? conectionChoose, provider) async {

    Conection conect = conectionChoose!;

    namebd.text = conect.database;
    hostbd.text = conect.host;
    portbd.text = conect.port;
    userbd.text = conect.user;
    passbd.text = conect.password;

    provider.selectConnection(conect);
  }

  Future<void>_createConex(BuildContext context, ConectionProvider provider) async{

     Conection cNew=new Conection(
        id: conections.isNotEmpty ? createId(conections.last.id) : "1",
        database: namebd.text,
        port: portbd.text,
        host: hostbd.text,
        user: userbd.text,
        password: passbd.text);

     final type = await provider.create(cNew);

     String action ="";

     if(type!=" ")
     {
       await error(context, type);
     }
     else
     {
       action=S.of(context).connection_has_been_successfully_created;
       confirm(context, action);
     }

  }

  Future<void>_editConex(BuildContext context, ConectionProvider provider) async {

    final old = provider.selected;
    if (old == null) return;

    final updated = Conection(
      id: old.id,
      database: namebd.text,
      host: hostbd.text,
      port: portbd.text,
      user: userbd.text,
      password: passbd.text,
    );

   final err = await provider.update(old, updated);

    String action="";
    if(err==true)
    {
      action = S.of(context).could_not_be_edited;
      error(context, action);
    }
    else
    {
      action=S.of(context).connection_has_been_successfully_edited;
      confirm(context, action);
    }

  }


  Future<void>_deleteConex(BuildContext context, ConectionProvider provider) async {

    String message= "${S.of(context).the} ${S.of(context).connection}";
    bool confirnDelete= await confirmDelete(context, message);

    if(confirnDelete==true)
    {
      final toDelete = provider.selected;
      if (toDelete == null) return;

      final err = await provider.delete(toDelete);

      String action="";
      if(err==true)
      {
        action = S.of(context).could_not_be_deleted;
        error(context, action);
      }
      else
      {
        action= S.of(context).connection_has_been_successfully_deleted;
        confirm(context, action);
      }
    }
  }

  void _restore(ConectionProvider provider) {


    if (provider.selected != null) {
      namebd.text = provider.selected!.database;
      hostbd.text = provider.selected!.host;
      portbd.text = provider.selected!.port;
      userbd.text = provider.selected!.user;
      passbd.text = provider.selected!.password;
    }
    
  }
}
