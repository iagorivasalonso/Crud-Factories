import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Backend/providers/Conection_provider.dart';
import 'package:crud_factories/Objects/Conection.dart';
import 'package:crud_factories/Widgets/headViewsAndroid.dart' show appBarAndroid;
import 'package:crud_factories/Widgets/layoutVariant.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Backend/CSV/chargueDataCsv.dart';
import '../Backend/SQL/importEmpleoye.dart';
import '../Backend/SQL/importFactories.dart';
import '../Backend/SQL/importMail.dart';
import '../Backend/SQL/importSector.dart';
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

  Conection? _last;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final provider = context.read<ConectionProvider>();

    if (provider.selected != null && provider.selected != _last) {
      _last = provider.selected;

      namebd.text = _last!.database;
      hostbd.text = _last!.host;
      portbd.text = _last!.port;
      userbd.text = _last!.user;
      passbd.text = _last!.password;
    }
  }
  @override
  Widget build(BuildContext context0) {
    BuildContext context = isNotAndroid() ? context0 : context1;

    final provider = context.watch<ConectionProvider>();

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
                                    onChanged: (conectionChoose) => _onConectionChanged(context,conectionChoose,provider),
                                  ),
                                ),
                              ),


                              Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: materialButton(
                                  nameAction: S
                                      .of(context)
                                      .edit,
                                  function: () => null, //_onSelectAction(context),

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
                                campEdit: false,
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
                                    campEdit: false,
                                  ),
                                ),
                                Expanded(
                                  child:
                                  defaultTextfield(
                                    nameCamp: S
                                        .of(context)
                                        .port,
                                    controllerCamp: portbd,
                                    campEdit: false,
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
                                    campEdit: false,
                                  ),

                                ),
                                Expanded(
                                  child:
                                  textfieldPassword(
                                    nameCamp: S
                                        .of(context)
                                        .password,
                                    controllerCamp: passbd,
                                    campEdit: false,
                                  ),
                                ),
                              ]),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              left: 620.0, top: 20.0),
                          child: layoutVariant(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            items: [
                              materialButton(
                                nameAction: provider.actionLabel(context),
                                function: () =>  _onConect(context,provider),

                              ),
/*
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: materialButton(
                                  nameAction: action2,
                                  function: () => _onDelete(context),

                                ),
                              ),*/
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


  Future<void> _onConect(BuildContext context, ConectionProvider provider) async {
    if (provider.status == ConnectionStatus.connected) {
      provider.disconnet(context);

      sectors.clear();
      allFactories.clear();
      empleoyes.clear();
      mails.clear();
      allLines.clear();

      chargueDataCSV(context);
    } else {
      await provider.connect(context);

      sectors.clear();
      allFactories.clear();
      empleoyes.clear();
      mails.clear();
      allLines.clear();

      // Esperamos a que las funciones de carga terminen

      await sqlImportSetors();
      await sqlImportFactories();
      await sqlImportEmpleoyes();
      await sqlImportMails();
    }
  }

  Future<void> _onConectionChanged(BuildContext context, Conection? conectionChoose, provider) async {

    Conection conect = conectionChoose!;

    namebd.text = conect.database;
    hostbd.text = conect.host;
    portbd.text = conect.port;
    userbd.text = conect.user;
    passbd.text = conect.password;

    await provider.selectConnection(conect, context);
  }
}
