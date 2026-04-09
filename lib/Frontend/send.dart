import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Backend/Global/controllers/LineSend.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Backend/CSV/exportLines.dart';
import 'package:crud_factories/Backend/SQL/createLine.dart';
import 'package:crud_factories/Functions/createId.dart';
import 'package:crud_factories/Functions/manageState.dart';
import 'package:crud_factories/Functions/validatorCamps.dart';
import 'package:crud_factories/Objects/Factory.dart';
import 'package:crud_factories/Objects/LineSend.dart';
import 'package:crud_factories/Objects/Sector.dart';
import 'package:crud_factories/Widgets/headViewsAndroid.dart';
import 'package:crud_factories/Widgets/textfield.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:crud_factories/helpers/localization_helper.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:crud_factories/Backend/SQL/modifyLines.dart';
import 'package:crud_factories/Functions/isNotAndroid.dart';
import 'package:crud_factories/Widgets/CustomDataTable.dart';
import 'package:crud_factories/Widgets/dropDownButton.dart' show GenericDropdown;
import 'package:crud_factories/Widgets/headView.dart' show headView;
import 'package:crud_factories/Widgets/materialButton.dart';

import 'package:crud_factories/Widgets/textfieldCalendar.dart';


class newSend extends StatefulWidget {

  String selectCamp;
  String filter;
  int select;

  newSend(this.selectCamp, this.filter, this.select);

  @override
  State<newSend> createState() => _newSendState();
}

class _newSendState extends State<newSend>{



  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();
  final ScrollController verticalScrollTable = ScrollController();


  String tView ="";
  Sector? selectedSector = null;
  String selectedItem = LineSendState.prepared.name;
  List<LineSend> linesSelected = [];
  List<LineSend> linesSave = [];
  String sector = "";
  String campKey = " ";
  String messageResult ="";
  int cantFactory= 0;
  List<String> stateSends =[];
  String tList = "";
  String action1 = "";
  String action2 = "";
  int allLinesCreated = 0;
  bool allSectors = false;

  List<String> sectorsString = [];
  List<bool> send = [];

  List<bool> observationModify = [];
  List<bool> stateModify = [];

  late List<LineSendController> linesControllers;

  bool _initialized = false;
  @override
  void initState() {
    super.initState();

    linesControllers = [];

    if (widget.select == -1) {
      selectedSector = null;
      factoriesSector = allFactories;
      generateControllers();

    } else {
      _initEditData();
    }
  }
  @override
  void didUpdateWidget(covariant newSend oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.select != widget.select ||
        oldWidget.selectCamp != widget.selectCamp ||
        oldWidget.filter != widget.filter) {

      if (widget.select == -1) {
        selectedSector = null;
        factoriesSector = allFactories;

        generateControllers();
        controllerSearchSend.text =
            DateFormat('dd-MM-yyyy').format(DateTime.now());

        // ✅ después de generar
        loadFactoriesFromModel(context, factoriesSector, linesControllers);

      } else {
        _initEditData();
      }
    }
  }
  void _initEditData() {

    if(widget.filter=="Fecha")
    {
        linesSelected = lineSector.where((e) {
          return e.date == widget.selectCamp;  // si tienes sector seleccionado
        }).toList();
    }
    else
    {
      linesSelected = lineSector.where((e) {
        return e.factory == widget.selectCamp;  // si tienes sector seleccionado
      }).toList();
    }

    print(linesSelected);
    controllerSearchSend.text = widget.selectCamp;

      loadLinesFromModel(linesSelected);


  }


  @override
  void dispose() {
    for (final line in linesControllers) {
      line.dispose();
    }
    super.dispose();

  }

  @override
  Widget build(BuildContext context0) {

    BuildContext context = isNotAndroid() ? context0 :  context1;
    int select = widget.select;
    String filter = widget.filter;


    stateSends = [S.of(context).prepared, S.of(context).sent, S.of(context).in_progress, S.of(context).returned, S.of(context).he_responded, S.of(context).pending];


    if(select == -1)
    {
      tView = S.of(context).new_shipment;
      tList = S.of(context).companies;
      action1 = S.of(context).newMale;
      action2 = S.of(context).reboot;


           if(selectedSector==null)
           {
               factoriesSector = allFactories;
           }
           else
           {

                     factoriesSector = allFactories.where((factory){
                       return factory.sector == selectedSector!.id;
                     }).toList();
           }



    }
    else if(saveChanges == false)
    {
      tView = S.of(context).edit_shipment;
      tList = S.of(context).shipment;
      action1 = S.of(context).save;
      action2 = S.of(context).undo;

      int cant = linesSelected.length;

      if(filter == S.of(context).date)
      {
        campKey = S.of(context).company;
        messageResult = LocalizationHelper.sendsDay(context, cant);
      }
      else
      {
        campKey = S.of(context).date;
        messageResult = LocalizationHelper.sendsFactory(context, cant);
      }


    }


    allSectors = false;
    String? currentSector;

    for (int i = 0; i < lineSector.length; i++) {
      if (i == 0) {
        currentSector = lineSector[i].sector;
      } else {
        if (currentSector != lineSector[i].sector) {
          allSectors = true;
          break;
        }
      }
    }


    return !isNotAndroid()
        ? Scaffold(
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
                      minWidth: MediaQuery.of(context).size.width,
                      minHeight: MediaQuery.of(context).size.height,
                    ),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        width: 980,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              headView(
                                  title: tView
                              ),
                              Container(
                                width: 500,
                                child: select == -1
                                    ? textfieldCalendar(
                                  nameCamp: S.of(context).date,
                                  controllerCamp: controllerSearchSend,
                                )
                                : defaultTextfield(
                                    nameCamp: filter,
                                    controllerCamp: controllerSearchSend
                                ),
                              ),


                                Padding(
                                    padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                                    child: SizedBox(
                                      height: 40,
                                      width: 300,
                                      child: select == -1
                                      ? GenericDropdown<Sector>(
                                        items: sectors,
                                        camp:S.of(context).sector,
                                        opDefault: S.of(context).allMale,
                                        selectedItem: selectedSector,
                                        hint: sector,
                                        itemLabel: (sector) => sector.name,
                                        onChanged: (sectorChoose) =>
                                            _onSectorChanged(context, sectorChoose, select),
                                      )
                                      :allSectors == false  && linesControllers.isNotEmpty
                                        ? Padding(
                                          padding: const EdgeInsets.only(top: 20.0),
                                          child: Text("${S.of(context).companies_of}" " ${linesControllers[0].sector.text}",
                                              style: const TextStyle(fontWeight: FontWeight.bold)),
                                        )
                                        : SizedBox.shrink(),
                                    ),
                                  ),

                                Padding(
                                  padding: const EdgeInsets.only(top: 40, left: 90, bottom: 30),
                                  child: select == -1
                                       ? customDataTable(
                                         key: ValueKey(linesControllers),
                                         scrollController: verticalScrollTable,
                                         columns: allSectors == false
                                                   ? [S.of(context).company, S.of(context).observations, S.of(context).state, S.of(context).select]
                                                   : [S.of(context).company, S.of(context).sector ,S.of(context).observations, S.of(context).state, S.of(context).select],
                                         showSectorColumn: allSectors,
                                         select: -1,
                                         states: stateSends,
                                         sendValues: send,
                                         selectedItem: null,
                                         linesControllers: linesControllers,
                                         mesage: messageResult,
                                         onStateChanged: (index , value ) {
                                           setState(() {
                                             linesControllers[index].state = value as LineSendState;
                                            // selectedItem = value; //
                                           });
                                         },
                                         onSendChanged: (i, value) {

                                             send[i] = value;
                                             saveChanges = true;
                                             setState(() {});
                                         },
                                         onSelectedAllChanged: (value) {
                                              for (int i = 0; i < send.length; i++)
                                              {
                                                send[i] = value;
                                              }
                                          saveChanges = true;
                                          setState(() {});
                                         },
                                      )

                                      : customDataTable(
                                      scrollController: verticalScrollTable,
                                      columns: allSectors == false
                                        ? [campKey, S.of(context).observations, S.of(context).state]
                                        : [campKey, S.of(context).sector ,S.of(context).observations, S.of(context).state],
                                           showSectorColumn: allSectors,
                                          states: stateSends,
                                          selectedItem: null,
                                          linesControllers: linesControllers,
                                          mesage: messageResult,
                                          onObservationChanged: (index , String ) {
                                            if(linesControllers[index].observations.text!=linesSelected[index].observations)
                                            {
                                               linesSelected[index].observations=linesControllers[index].observations.text;
                                               observationModify[index] = true;

                                               setState(() {
                                                 saveChanges = true;
                                               });
                                            }
                                            else
                                            {
                                              observationModify[index] = false;
                                            }


                                          },
                                          onStateChanged: (index , value ) {
                                            setState(() {
                                              linesControllers[index].state = value;

                                              if (linesControllers[index].state.name != linesSave[index].state) {
                                                stateModify[index] = true;
                                                saveChanges = true;
                                              } else {
                                                stateModify[index] = false;
                                              }
                                            });
                                          }, sendValues: [], onSendChanged: (int p1, bool p2) {  }, onSelectedAllChanged: (value) {  },
                                     ),
                                    ),

                                    Padding(
                                        padding: const EdgeInsets.only(left: 700.0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            materialButton(
                                                nameAction: action1,
                                                function: () =>
                                                _onSaveSend(context,select,controllerSearchSend,linesControllers)
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.only(left: 20.0),
                                              child: materialButton(
                                                nameAction: action2,
                                                function: () => _onResetCamps(context),
                                                ),
                                        )
                                       ],
                                    ),
                                   ),
                                ]
                              ),
                      ),
                      )
                  ),
              ),
              ),
            ),
          ),
        )
    ) : Scaffold(
             appBar: appBarAndroid(context, name: "sasd"),
             body: Text("creart email"),
    );

  }
  Future<void> loadFactoriesFromModel(
      BuildContext context,
      List<Factory> factories,
      List<LineSendController> controllersLines,
      ) async {

    for (int i = 0; i < factories.length && i < controllersLines.length; i++) {

      final sectorSelected = sectors.firstWhereOrNull(
            (sector) => sector.id == factories[i].sector,
      );


      controllersLines[i].sector.text = sectorSelected?.name ??
          S.of(context).The_sector_does_not_exist;
      controllersLines[i].date.text = controllerSearchSend.text;
      controllersLines[i].factory.text = factories[i].name;
      controllersLines[i].state = LineSendState.prepared;

    }
    _updateMessageResult(context);
    setState(() {});
  }

  Future<void> loadLinesFromModel(
      List<LineSend> lines
      ) async {

    final oldControllers = linesControllers;


     final newControllers = lines.map((line) {
            final sectorSelected = sectors.firstWhereOrNull(
                  (s) => s.id == line.sector,
            );

            return LineSendController(
              date: TextEditingController(text: line.date),
              factory: TextEditingController(text: line.factory),
              sector: TextEditingController(text: sectorSelected?.name ?? ''),
              observations: TextEditingController(text: line.observations),
              state: manageState.stringToState(line.state),
            );
          }).toList();
    linesControllers = newControllers;
    for (final c in oldControllers) {
      c.dispose();
    }

    linesSave = lines.map((e) => e.copyWith()).toList();
          observationModify = List.filled(lines.length, false);
          stateModify = List.filled(lines.length, false);
  }

  Future<void> _onSectorChanged(BuildContext context,Sector? sectorChoose,int select) async {

    if (sectorChoose != null) {
      selectedSector = sectorChoose;
      allSectors = false;
      factoriesSector = allFactories.where((f) => f.sector == sectorChoose.id).toList();
    } else {
      selectedSector = null;
      allSectors = true;
      factoriesSector = allFactories;
    }
    generateControllers();
    _updateMessageResult(context);
   
    setState(() {});
  }

  Future<void> _onSaveSend(BuildContext context,int select, controllerSearch, List<LineSendController> linesControllers) async{

    List <LineSend> current = [];
    allLines.sort((a, b) => int.parse(a.id).compareTo(int.parse(b.id)));

      String idNew = "";

      if (allLines.isNotEmpty) {
        String idLast = allLines[allLines.length - 1].id;
        idNew = createId(idLast);
      }
      else {
        idNew = "1";
      }

      int idInit = int.parse(idNew);

      if (select == -1) {
        if (validatorCamps.dateCorrect(controllerSearch.text) == true) {

          for (int i = 0; i < factoriesSector.length; i++) {

            if (send[i] == true){
              current.add(LineSend(
                id: (idInit + current.length).toString(),
                date: controllerSearch.text,
                factory: factoriesSector[i].name,
                observations: linesControllers[i].observations.text,
                state: manageState.parseState(linesControllers[i].state.name, context, true),
              ));


            }

              // Reset UI
              linesControllers[i].observations.text = "";
              linesControllers[i].state = LineSendState.prepared;
              send[i] = false;
            }
          }

          allLinesCreated += current.length;
          confirm(context, LocalizationHelper.sendsFactory(context, allLinesCreated));

        setState(() {
          // Reinicia todos los checkboxes
          send = List.generate(factoriesSector.length, (_) => false);

          // Reinicia estados y observaciones de líneas (aunque ya lo hicimos arriba)
          for (var ctrl in linesControllers) {
            ctrl.state = LineSendState.prepared;
            ctrl.observations.text = "";
          }
        });


      }
      else {


        int linesModify = 0;

        for (int i = 0; i < linesSelected.length; i++) {

          final original = linesSave[i];

          final newObservations = linesControllers[i].observations.text;
          final newState = linesControllers[i].state.name;

          if (original.observations != newObservations ||
              original.state != newState) {
            linesModify++;
          }

          // 👉 aplicar cambios
          linesSelected[i].observations = newObservations;
          linesSelected[i].state = newState;
        }

        confirm(
          context,
          LocalizationHelper.cantLinesModify(context, linesModify),
        );

        // 👉 sincronizar con allLines
        final selectedMap = {
          for (var line in linesSelected) line.id: line
        };

        allLines = allLines.map((line) {
          return selectedMap[line.id] ?? line;
        }).toList();
        confirm(context, LocalizationHelper.cantLinesModify(context, linesModify));
      }

    saveChanges = false;

    if (BaseDateSelected.isNotEmpty) {

      if (select == -1) {
        await sqlCreateLine(current, context);
      } else {
        await sqlModifyLines(linesSelected);
      }

    } else {

      bool errorExp = await csvExportatorLines(allLines);

      if (errorExp) {
        String action = LocalizationHelper.no_file(
          context,
          S.of(context).shipments,
        );
        error(context, action);
        return;
      }

      if (select == -1) {
        await _onResetCamps(context);
      }
    }
  }


  Future<void> _onResetCamps(BuildContext context) async {

    final select = widget.select;

      if (select == -1)
      {
          selectedSector = null;
          factoriesSector = allFactories;

          controllerSearchSend.text = DateFormat('dd-MM-yyyy').format(DateTime.now());

          allLinesCreated = 0;
          saveChanges = false;

          generateControllers();
      }
      else
      {
          for(int i = 0; i < linesControllers.length; i++)
          {
              linesControllers[i].observations.text = linesSave[i].observations;
              linesControllers[i].state = manageState.stringToState(linesSave[i].state);
              observationModify[i] = false;
              stateModify[i] = false;
          }

          saveChanges = false;
      }
    _updateMessageResult(context);
     setState(() {});
  }

  void generateControllers() {

    final oldControllers = linesControllers;

    linesControllers = List.generate(factoriesSector.length, (index) {
      return LineSendController(
        date: TextEditingController(
          text: DateFormat('dd-MM-yyyy').format(DateTime.now()),
        ),
        factory: TextEditingController(
          text: factoriesSector[index].name,
        ),
        sector: TextEditingController(
          text: factoriesSector[index].sector.toString(),
        ),
        observations: TextEditingController(text: ""),
        state: LineSendState.prepared,
      );
    });

    send = List.generate(factoriesSector.length, (_) => false);

    for (final c in oldControllers) {
      c.dispose();
    }

  }

  void _updateMessageResult(BuildContext context) {
    int cant = factoriesSector.length;

    if (widget.select == -1) {
      // Mensaje para nueva shipment
      messageResult = LocalizationHelper.factoriesBD(context, cant);
    } else {
      // Mensaje para edición
      if (widget.filter == S.of(context).date) {
        campKey = S.of(context).company;
        messageResult = LocalizationHelper.sendsDay(context, cant);
      } else {
        campKey = S.of(context).date;
        messageResult = LocalizationHelper.sendsFactory(context, cant);
      }
    }
  }
}






