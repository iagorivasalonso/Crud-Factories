import 'dart:io';

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
import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import '../Backend/SQL/modifyLines.dart';
import '../Functions/isNotAndroid.dart';
import '../Widgets/CustomDataTable.dart';
import '../Widgets/dropDownButton.dart' show GenericDropdown;
import '../Widgets/headView.dart' show headView;
import '../Widgets/materialButton.dart';

import '../Widgets/textfieldCalendar.dart';


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

  double widthBar = 10.0;
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
    if (oldWidget.select != widget.select && widget.select != -1) {
      _initEditData();

      loadFactoriesFromModel(context, factoriesSector, linesControllers);
    }

  }
  void _initEditData() {
    linesSelected = lineSector.map((e) => e.copyWith()).toList();

    setState(() {
      loadLinesFromModel(linesSelected);
    });

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
    String selectCamp = widget.selectCamp;
    String filter = widget.filter;


    DateTime date = DateTime.now();

    stateSends = [S.of(context).prepared, S.of(context).sent, S.of(context).in_progress, S.of(context).returned, S.of(context).he_responded, S.of(context).pending];



    if(select == -1)
    {
      tView = S.of(context).new_shipment;
      tList = S.of(context).companies;
      action1 = S.of(context).newMale;
      action2 = S.of(context).reboot;

          if(controllerSearchSend.text.isEmpty)
          {
            controllerSearchSend.text = DateFormat('dd-MM-yyyy').format( DateTime.now());
          }

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



      loadFactoriesFromModel(context, factoriesSector, linesControllers);
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

      controllerSearchSend.text = selectCamp;
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
                height: select == -1
                    ? 600
                    : 630,
                width: 1100,
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30.0, top: 30.0),
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


                              Flexible(
                                child: Padding(
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
                                    :allSectors==false  && linesControllers.isNotEmpty
                                      ? Padding(
                                        padding: const EdgeInsets.only(top: 20.0),
                                        child: Text("${S.of(context).companies_of}" " ${linesControllers[0].sector.text}",
                                            style: const TextStyle(fontWeight: FontWeight.bold)),
                                      )
                                      : null,
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 40, left: 90, bottom: 30),
                                child: select == -1
                                     ? customDataTable(
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
                                      padding: const EdgeInsets.only(left: 750.0),
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

    for (int i = 0; i < factories.length; i++) {

      final sectorSelected = sectors.firstWhereOrNull(
            (sector) => sector.id == factories[i].sector,
      );


      controllersLines[i].sector.text = sectorSelected?.name ??
          S.of(context).The_sector_does_not_exist;
      controllersLines[i].date.text = factories[i].highDate;
      controllersLines[i].factory.text = factories[i].name;
      controllersLines[i].observations.text = "";

    }
  }

  Future<void> loadLinesFromModel(
      BuildContext context,
      List<LineSend> lines,
      List<LineSendController> controllersLines,
      ) async {

    for (int i = 0; i < linesSelected.length; i++) {

      final sectorSelected = sectors.firstWhereOrNull(
            (sector) => sector.id == linesSelected[i].sector,
      );


      controllersLines[i].sector.text = sectorSelected?.name ??
          S.of(context).The_sector_does_not_exist;
      controllersLines[i].date.text = linesSelected[i].date;
      controllersLines[i].factory.text = linesSelected[i].factory;
      controllersLines[i].state =  manageState.stringToState(linesSelected[i].state);
      controllersLines[i].observations.text = linesSelected[i].observations;

    }
  }

  Future<void> _onSectorChanged(BuildContext context,Sector? sectorChoose,int select) async {

    setState(() {
      if (sectorChoose != null) {
        selectedSector = sectorChoose;
        allSectors = false;
      } else {
        selectedSector = null;
        allSectors = true;
      }
      loadFactoriesFromModel(context, factoriesSector, linesControllers);
    });
  }

  Future<void> _onSaveSend(BuildContext context,int select, controllerSearch, List<LineSendController> linesControllers) async {

    List <LineSend> current = [];

    setState(() {
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
            if (send[i] == true) {
              int idNew = idInit + current.length;
              allLinesCreated ++;

              current.add(
                LineSend(
                    id: idNew.toString(),
                    date: controllerSearch.text,
                    factory: factoriesSector[i].name,
                    observations: linesControllers[i].observations.text,
                    state: manageState.parseState(
                        linesControllers[i].state.name, context, true)),
              );

              linesControllers[i].observations.text = "";
              linesControllers[i].state = LineSendState.prepared;
              send[i] = false;
              selectedItem = S.of(context).prepared;
            }
          }
          String action = LocalizationHelper.sendsFactory(context, allLinesCreated);
          confirm(context, action);
        }
      }
      else {


        for (int i = 0; i < linesSelected.length; i++) {

          linesSelected[i].observations = linesControllers[i].observations.text;
          linesSelected[i].state=linesControllers[i].state.name;
        }

        int linesModify = 0;

        for (int i = 0; i < stateModify.length; i++) {
          if (stateModify[i] || observationModify[i]) { // suma si al menos uno es true
            linesModify++;
          }
        }

        String action = LocalizationHelper.cantLinesModify(context, linesModify);
        confirm(context,action);
      }
    });

    if (BaseDateSelected.isNotEmpty)
    {
      if(select==-1)
      {
        csvExportatorLines(current);
      }
      else
      {
         sqlModifyLines(linesSelected);
      }
    }
    else
    {
      allLines = allLines + current;

      bool errorExp = await csvExportatorLines(allLines);

      String array = S.of(context).shipments;

      if(errorExp == false)
      {
        if(select == -1)
        {
          await _onResetCamps(context);
        }
      }
      else
      {
        String action = LocalizationHelper.no_file(context, array);
        error(context, action);
      }
      allLinesCreated = 0;
      saveChanges = false;
    }
  }

  Future<void> _onResetCamps(BuildContext context, int select) async {

    setState(() {
      if (select == -1)
      {
        generateControllers();
      }
      else
      {

      }
    });
  }

  void generateControllers() {
    linesControllers = List.generate(allFactories.length, (index) {
      return LineSendController(
        date: TextEditingController(
          text: DateFormat('dd-MM-yyyy').format(DateTime.now()),
        ),
        factory: TextEditingController(
          text: allFactories[index].name,
        ),
        sector: TextEditingController(
          text: factoriesSector[index].sector.toString(),
        ),
        observations: TextEditingController(text: ""),
        state: LineSendState.prepared,
      );
    });

    send = List.generate(allFactories.length, (_) => false);
  }

  void _updateMessageResult(BuildContext context) {
    int cant = factoriesSector.length;

    if (widget.select == -1) {

      messageResult = LocalizationHelper.factoriesBD(context, cant);
    } else {

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






