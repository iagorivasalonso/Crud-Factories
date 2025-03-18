import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/SQL/createLine.dart';
import 'package:crud_factories/Backend/SQL/modifyLines.dart';
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Backend/CSV/exportLines.dart';
import 'package:crud_factories/Functions/createId.dart';
import 'package:crud_factories/Functions/manageArrays.dart';
import 'package:crud_factories/Functions/manageState.dart';
import 'package:crud_factories/Functions/validatorCamps.dart';
import 'package:crud_factories/Objects/LineSend.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:crud_factories/helpers/localization_helper.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:intl/intl.dart';
import 'package:show_platform_date_picker/show_platform_date_picker.dart';
import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:flutter/material.dart';


class newSend extends StatefulWidget {

  BuildContext context;
  String selectCamp;
  String filter;

  int select;

  newSend(this.context, this.selectCamp, this.filter, this.select);

  @override
  State<newSend> createState() => _newSendState();
}

class _newSendState extends State<newSend> {

  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();
  final ScrollController verticalScrollTable = ScrollController();

  double widthBar = 10.0;

  late TextEditingController controllerSearch = new TextEditingController();
  List<TextEditingController> _controllersObserLine = [];
  List<TextEditingController> _controllersSectorLine = [];
  List<TextEditingController> _controllerStateLine = [];

  List<String> campsTable = [];
  String filterSelected = '';
  String date = "";
  int cantFactory = 0;
  int cantSend = 0;
  bool allSelect = false;
  List<bool> Send = List.generate(allFactories.length, (index) => false);
  List<bool> lineEdit = List.generate(allFactories.length, (index) => false);
  DateTime seletedDate =DateTime.now();
  String? selectedSector = "";
  String stringFactories = "";
  List<String> stateSends = [];
  int allLines = 0;
  int allLinesModify = 0;

  @override
  Widget build(BuildContext context) {

    BuildContext context = widget.context;
    String type = widget.filter;
    String selectCamp = widget.selectCamp;
    int select = widget.select;

    if(selectedSector=="")
    {
      selectedSector = S.of(context).allMale;
    }


    List<LineSend> lineSelected = [];
    List <String> campKey = [];
    List <String> sectorsString =[];

    int cant = 0;

    String title = "";
    String typeList="";
    String action1 = "";
    String action2 = "";
    String sectorView = " ";

    stateSends = [
      S.of(context).prepared,
      S.of(context).sent,
      S.of(context).in_progress,
      S.of(context).returned,
      S.of(context).he_responded,
      S.of(context).pending
    ];
    if (select == -1) {

      title = S.of(context).newMale;
      typeList = S.of(context).companies;
      type = S.of(context).date;
      action1 = S.of(context).newMale;
      action2 = S.of(context).reboot;

      sectorsString.add(S.of(context).allMale);

      for(int i = 0; i < sectors.length; i++)
      {
        sectorsString.add(sectors[i].name);
      }

      for (int i = 0; i < allFactories.length; i++)
      {
        _controllersSectorLine.add(TextEditingController());
        _controllersObserLine.add(TextEditingController());
        _controllerStateLine.add(TextEditingController());
      }
      if(controllerSearch.text.isEmpty)
      {
        controllerSearch.text=DateFormat('dd-MM-yyyy').format( DateTime.now());
      }

          if(selectedSector ==S.of(context).allMale)
          {
            campsTable = [
                  S.of(context).company,
                  S.of(context).sector,
                  S.of(context).observations,
                  S.of(context).state,
                  S.of(context).select,
              ];

            factoriesSector.clear();

            for(int i = 0; i < allFactories.length;i++)
            {
              factoriesSector.add(allFactories[i]);
            }

            cantFactory = factoriesSector.length;
            stringFactories = LocalizationHelper.factoriesBD(context,cantFactory);
          }
    }
    else
    {

      action1 = S.of(context).save;
      action2 = S.of(context).undo;
      title = S.of(context).ver;



      int selected = 0;
      if (subIten2Select != 0)
      {
          for(int i = 0; i < sectors.length; i++)
          {
            selected = i + 1;
            if(lineSector[0].sector == selected.toString())
            {
               sectorView = sectors[i].name;
            }
          }
      }

      if(type == S.of(context).date)
      {

        type = S.of(context).date;

            if(subIten2Select == 0)
            {
                campsTable = [
                  S.of(context).company,
                  S.of(context).sector,
                  S.of(context).observations,
                  S.of(context).state
                ];
            }
            else
            {
                 campsTable = [
                   S.of(context).company,
                   S.of(context).observations,
                   S.of(context).state
                 ];
            }


          lineSelected.clear();

           controllerSearch.text = lineSector[0].showFormatDate(selectCamp,context);

           for (int i = 0; i < lineSector.length; i++)
           {
             if(controllerSearch.text == lineSector[0].showFormatDate(lineSector[i].date,context))
             {
               lineSelected.add(lineSector[i]);
               campKey.add(lineSector[i].factory);
             }
           }

          for (int i = 0; i < lineSelected.length; i++)
          {
            _controllersObserLine.add(TextEditingController());
            _controllerStateLine.add(TextEditingController());
            _controllersSectorLine.add(TextEditingController());
          }

          for (int i = 0; i < lineSelected.length; i++)
          {

              if(saveChanges == false)
              {
                _controllersObserLine[i].text = lineSelected[i].observations;
                _controllerStateLine[i].text =  manageState.seeLanguage(context, lineSelected[i].state.toString());
              }

              int sectorfactory = 0;

              if(lineSelected[i].sector!=null)
              {
                sectorfactory = int.parse(lineSelected[i].sector!)-1;
                _controllersSectorLine[i].text = sectors[sectorfactory].name;
              }

          }

          cant = lineSelected.length;
          stringFactories = LocalizationHelper.sendsDay(context, cant);
      }

      typeList = S.of(context).shipments;

      if(type == S.of(context).company)
      {
        type = S.of(context).company;

        campsTable = [
          S.of(context).date,
          S.of(context).observations,
          S.of(context).state
        ];
        controllerSearch.text = selectCamp;

        lineSelected.clear();

        for (int i = 0; i < lineSector.length; i++)
        {
          if(controllerSearch.text == lineSector[i].factory)
          {
            lineSelected.add(lineSector[i]);
            campKey.add(lineSector[i].date);

          }
        }

        for (int i = 0; i < lineSelected.length; i++)
        {
          if(controllerSearch.text==lineSelected[i].factory)
          {
            _controllersObserLine[i].text = lineSelected[i].observations;
             _controllerStateLine[i].text = manageState.seeLanguage(context, lineSelected[i].state.toString());
          }

        }

      }

      cantSend = lineSelected.length;
      stringFactories = LocalizationHelper.sendsDay(context,cantSend);
    }

    String send = S.of(context).shipment;
    String titleComplete = "";

    if(itenSelect == 1 && subIten2Select != 0 )
    {
      String sp = S.of(context).de.toLowerCase();
      titleComplete ='$title $send $sp $sectorView';
    }
    else
    {
      titleComplete ='$title $send';
    }

    String list_d = S.of(context).list_of;
    String list_def='$list_d $typeList';

    final ShowPlatformDatePicker platformDatePicker = ShowPlatformDatePicker(buildContext: context);

    for(int i = 0; i<Send.length; i++)
    {
      if(Send[i] == false)
      {
        allSelect = false;
      }
    }
    return Scaffold(
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
            child: SizedBox(
              width: 2000,
              child: SingleChildScrollView(
                controller: horizontalScroll,
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  height: select == -1
                      ? 710
                      : 630,
                  width: 1400,
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30.0, top: 30.0),
                        child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(titleComplete,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20.0),
                                      child: Text('$type:  '),
                                    ),
                                    SizedBox(
                                      width: 500,
                                      height: 40,
                                      child: TextField(
                                        controller: controllerSearch,
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          icon: select == -1
                                              ? const Icon(Icons.calendar_today)
                                              : null,
                                        ),
                                        onTap: () async {
                                          if(select == -1)
                                          {
                                               DateTime? dateSelected = await  platformDatePicker.showPlatformDatePicker(
                                                    context,
                                                    seletedDate,
                                                    DateTime(DateTime.now().year - 10),
                                                    DateTime(DateTime.now().year + 1),
                                              );

                                               if (dateSelected != null) {
                                                 setState(() {
                                                   date = DateFormat('dd-MM-yyyy').format(dateSelected);
                                                 });
                                               }
                                          }

                                        },
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              if(select == -1)
                              Padding(
                                padding: const EdgeInsets.only( top: 30.0),
                                child: DropdownButtonHideUnderline(
                                  child: Row(
                                    children: [
                                       Padding(
                                        padding: EdgeInsets.only(left: 20.0, right: 30.0),
                                        child: Text(S.of(context).sector),
                                      ),
                                      DropdownButton2<String>(
                                        hint:  Text(S.of(context).allMale),
                                        items: sectorsString.map((String itemSector) => DropdownMenuItem<String>(
                                          value:  itemSector,
                                          child: Text(itemSector),
                                        )).toList(),
                                        value: selectedSector,
                                        onChanged: (String? sectorChoose) {
                                          setState(() {

                                            selectedSector = sectorChoose!;

                                         do{
                                           print(selectedSector);
                                           factoriesSector.clear();
                                           if (selectedSector == S.of(context).allMale)
                                           {

                                             campsTable = [
                                               S.of(context).company,
                                               S.of(context).sector,
                                               S.of(context).observations,
                                               S.of(context).state,
                                               S.of(context).select
                                             ];

                                             for(int i = 0; i < allFactories.length;i++)
                                             {
                                               factoriesSector.add(allFactories[i]);
                                             }

                                             cantFactory = factoriesSector.length;
                                           }
                                           else
                                           {


                                             int  sSelected = 0;
                                             for(int i = 0; i <sectors.length; i++)
                                             {
                                               if(sectors[i].name == selectedSector)
                                               {
                                                 sSelected = i;
                                               }
                                             }
                                             int factoriesSelected = sSelected + 1;

                                             campsTable = [
                                               S.of(context).company,
                                               S.of(context).observations,
                                               S.of(context).state,
                                               S.of(context).select
                                             ];

                                             for(int i = 0; i < allFactories.length;i++)
                                             {
                                               if(allFactories[i].sector == factoriesSelected.toString())
                                               {
                                                 factoriesSector.add(allFactories[i]);
                                               }
                                             }

                                             cantFactory = factoriesSector.length;

                                             if(cantFactory == 0)
                                             {
                                                 String array = S.of(context).companies;
                                                 String action = LocalizationHelper.no_array_departament(context, array);
                                                 error(context, action);
                                                 selectedSector = S.of(context).allMale;
                                             }
                                           }

                                         } while (cantFactory == 0);



                                              stringFactories = LocalizationHelper.factoriesBD(context,cantFactory);

                                          });
                                        },
                                        buttonStyleData: const ButtonStyleData(
                                          height: 50,
                                          width: 220,
                                          padding: EdgeInsets.only(left: 14, right: 14),
                                        ),
                                        dropdownStyleData: DropdownStyleData(
                                          maxHeight: 200,
                                          width: 200,
                                          scrollbarTheme: ScrollbarThemeData(
                                            thickness: MaterialStateProperty.all(6),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 40.0),
                                child: Row(
                                  children: [
                                    Text(list_def,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 40.0, left: 90.0,bottom: 30.0),
                                child: Scrollbar(
                                  controller: verticalScrollTable,
                                  child: SizedBox(
                                    height: 250,
                                    child: SingleChildScrollView(
                                      controller: verticalScrollTable,
                                      scrollDirection: Axis.vertical,
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: DataTable(
                                          columns: List<DataColumn>.generate(campsTable.length, (index) =>
                                            DataColumn(
                                                label: SizedBox(
                                                  width: 100,
                                                    child: Text(campsTable[index])))
                                          ),
                                          rows: select == -1
                                          ? List<DataRow>.generate(factoriesSector.length, (indexRow) =>
                                             DataRow(
                                                 cells: <DataCell>[
                                                   DataCell(
                                                     Text(factoriesSector[indexRow].name),
                                                   ),
                                                   if(selectedSector==S.of(context).allMale)
                                                     DataCell(
                                                       Text(sectors[int.parse(factoriesSector[indexRow].sector)-1].name),
                                                     ),
                                                   DataCell(
                                                       Padding(
                                                         padding: const EdgeInsets.all(8.0),
                                                         child: TextField(
                                                           controller: _controllersObserLine[indexRow],
                                                           decoration: InputDecoration(
                                                             border: OutlineInputBorder(),
                                                           ),
                                                           onChanged: (s){
                                                             setState(() {
                                                               lineEdit[indexRow]=true;
                                                               saveChanges = true;
                                                             });
                                                            },
                                                         ),
                                                       ),
                                                   ),
                                                   DataCell(
                                                     Padding(
                                                       padding: const EdgeInsets.all(1.0),
                                                       child: SizedBox(
                                                         height: 40,
                                                         child: DropdownButtonFormField<String>(
                                                           value: stateSends.contains(_controllerStateLine[indexRow].text)
                                                               ?manageState.seeLanguage(context, _controllerStateLine[indexRow].text)
                                                               : stateSends.isNotEmpty
                                                               ? stateSends[0]
                                                               : null,
                                                           decoration: InputDecoration(
                                                             border: OutlineInputBorder(),
                                                           ),
                                                           items: stateSends.map((option) {
                                                             return DropdownMenuItem<String>(
                                                               value: option,
                                                               child: Text(manageState.seeLanguage(context, option), style: TextStyle(fontSize: 12),),
                                                             );
                                                           }).toList(),
                                                           onChanged: (newValue) {
                                                             setState(() {

                                                               _controllerStateLine[indexRow].text = newValue!;

                                                               lineEdit[indexRow] = true;

                                                               if(saveChanges == false)
                                                               {
                                                                 if (_controllerStateLine[indexRow].text == lineSelected[indexRow].state)
                                                                 {
                                                                   saveChanges = false;
                                                                 } else
                                                                 {
                                                                   saveChanges = true;
                                                                 }
                                                               }
                                                             });

                                                           },
                                                         ),
                                                       ),
                                                     ),
                                                   ),
                                                   DataCell(
                                                     CheckboxListTile(
                                                       value: Send[indexRow],
                                                       onChanged:( bool? value) {
                                                            setState(() {
                                                               Send[indexRow] = value!;
                                                               allSelect = true;
                                                               saveChanges = true;
                                                            });
                                                       },
                                                     ),
                                                   ),
                                                 ]
                                             )
                                          )
                                          : List<DataRow>.generate(lineSelected.length, (indexRow) =>
                                              DataRow(
                                                  cells:  <DataCell>[
                                                    DataCell(
                                                        Text(campKey[indexRow])
                                                    ),
                                                    if(subIten2Select == 0 && type == S.of(context).date)
                                                      DataCell(
                                                          Text(_controllersSectorLine[indexRow].text)
                                                      ),
                                                    DataCell(
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: TextField(
                                                          controller: _controllersObserLine[indexRow],
                                                          decoration: InputDecoration(
                                                              border: OutlineInputBorder(),
                                                          ),
                                                          onChanged: (s){
                                                            lineEdit[indexRow]=true;

                                                            if(saveChanges == false)
                                                            {
                                                                if(_controllersObserLine[indexRow].text == lineSelected[indexRow].observations)
                                                                {
                                                                  saveChanges = false;
                                                                }
                                                                else
                                                                {
                                                                  saveChanges = true;
                                                                }
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Padding(
                                                        padding: const EdgeInsets.all(1.0),
                                                        child: SizedBox(
                                                          height: 40,
                                                          child: DropdownButtonFormField<String>(
                                                            value: stateSends.contains(_controllerStateLine[indexRow].text)
                                                                ?manageState.seeLanguage(context, _controllerStateLine[indexRow].text)
                                                                : stateSends.isNotEmpty
                                                                ? stateSends[0]
                                                                : null,
                                                            decoration: InputDecoration(
                                                              border: OutlineInputBorder(),
                                                            ),
                                                            items: stateSends.map((option) {
                                                              return DropdownMenuItem<String>(
                                                                value: option,
                                                                child: Text(manageState.seeLanguage(context, option), style: TextStyle(fontSize: 12),),
                                                              );
                                                            }).toList(),
                                                            onChanged: (newValue) {
                                                              setState(() {

                                                                _controllerStateLine[indexRow].text = newValue!;

                                                                lineEdit[indexRow] = true;

                                                                if(saveChanges == false)
                                                                {
                                                                    if (_controllerStateLine[indexRow].text == lineSelected[indexRow].state)
                                                                    {
                                                                      saveChanges = false;
                                                                    } else
                                                                    {
                                                                      saveChanges = true;
                                                                    }
                                                                }
                                                              });

                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ]
                                              )
                                          ),
                                        ),
                                      )
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(stringFactories),
                                            ],
                                          ),
                                        ],
                                      ),
                                        if(select == -1)
                                        Padding(
                                          padding: const EdgeInsets.only(left: 500.0),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(right: 15.0),
                                                child: Text(S.of(context).select_all),
                                              ),
                                              Checkbox(
                                                value: allSelect,
                                                onChanged: (value) {
                                                  setState(() {

                                                    for(int i = 0 ; i<Send.length; i++)
                                                    {
                                                      Send[i] = value!;
                                                    }
                                                    allSelect = value!;

                                                  });
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                    ],
                                  )
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top: 70.0, right: 50.0),
                                  child: SizedBox(
                                    width: 200,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        MaterialButton(
                                          color: Colors.lightBlue,
                                          child: Text(action1,
                                          style: const TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () async {
                                            List <LineSend> current = [];

                                            setState(() {
                                              String idNew = "";

                                              if(lineSector.isNotEmpty)
                                              {
                                                String idLast = lineSector[lineSector.length-1].id;
                                                idNew = createId(idLast);
                                              }
                                              else
                                              {
                                                idNew ="1";
                                              }

                                              int idInit = int.parse(idNew);

                                              if(select == -1)
                                              {

                                                    if (validatorCamps.dateCorrect(controllerSearch.text) == false)
                                                    {

                                                      String array = S.of(context).date;
                                                      String action = LocalizationHelper.format_must(context, array);

                                                      String format = 'DD-MM-AAAA';
                                                      error(context, action, format);
                                                    }
                                                    else
                                                    {
                                                      for(int i = 0; i < allFactories.length; i++)
                                                      {
                                                        if(Send[i] == true)
                                                        {
                                                          int idNew = idInit + current.length;
                                                          allLines ++;

                                                          current.add(
                                                            LineSend(
                                                                id: idNew.toString(),
                                                                date: controllerSearch.text,
                                                                factory: allFactories[i].name,
                                                                observations: _controllersObserLine[i].text,
                                                                state:manageState.parseState(_controllerStateLine[i].text,context,true)),
                                                          );

                                                          manageArrays.addDateSend(controllerSearch.text);
                                                        }
                                                      }
                                                      String action = LocalizationHelper.sendsFactory(context, allLines);
                                                      confirm(context,action);
                                                    }

                                              }
                                              else
                                              {

                                                  if(saveChanges == true)
                                                  {
                                                      for(int i = 0; i <lineEdit.length; i++)
                                                      {
                                                        if(lineEdit[i]==true)
                                                        {
                                                          allLinesModify++;
                                                        }
                                                      }


                                                      String id='';
                                                      for (int i = 0; i < lineSelected.length; i++)
                                                      {

                                                        id=lineSelected[i].id;

                                                        for (int y = 0; y < lineSelected.length; y++)
                                                        {

                                                          if(lineSelected[i].id == id)
                                                          {
                                                            print(_controllerStateLine[i].text);
                                                            lineSelected[i].state = manageState.parseState(_controllerStateLine[i].text,context,false);
                                                            lineSelected[i].observations = _controllersObserLine[i].text;
                                                          }
                                                        }

                                                      }


                                                     String action ='';
                                                     if (allLinesModify == 0)
                                                     {
                                                       action = S.of(context).has_no_line_to_modify;
                                                       error(context, action);
                                                     }
                                                     else
                                                     {
                                                       action = LocalizationHelper.cantLinesModify(context, allLinesModify);
                                                       confirm(context,action);

                                                       allLinesModify = 0;
                                                     }

                                                  }

                                              }
                                              lineEdit = List.generate(lineSector.length, (index) => false);

                                            });
                                            if (conn != null)
                                            {
                                              if(select==-1)
                                              {
                                                sqlCreateLine(current,context);
                                              }
                                              else
                                              {
                                                sqlModifyLines(lineSelected, context);
                                              }
                                            }
                                            else
                                            {
                                              lineSector = lineSector + current;

                                              bool errorExp = await csvExportatorLines(lineSector);

                                              String array = S.of(context).shipments;

                                              if(errorExp == false)
                                              {
                                                  if(select == -1)
                                                  {
                                                     Send = List.generate(allFactories.length, (index) => false);
                                                     lineEdit = List.generate(allFactories.length, (index) => false);

                                                     resetCamps();
                                                  }
                                              }
                                              else
                                              {
                                                String action = LocalizationHelper.no_file(context, array);
                                                error(context, action);
                                              }
                                              allLines = 0;
                                              saveChanges = false;
                                            }
                                          },
                                        ),

                                    MaterialButton(
                                      color: Colors.lightBlue,
                                      child: Text(action2,
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                            setState(() {
                                              if (select == -1)
                                              {
                                                 resetCamps();
                                              }
                                              else
                                              {
                                                  for(int i = 0 ; i < lineSelected.length; i++)
                                                  {
                                                        if(lineEdit[i]==true)
                                                        {
                                                           _controllersObserLine[i].text = lineSelected[i].observations;
                                                           _controllerStateLine[i].text = manageState.parseState(_controllerStateLine[i].text,context,false).name;
                                                        }
                                                  }
                                              }

                                               saveChanges = false;

                                            });

                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ]
                        ),
                      )
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void resetCamps() {

    for(int i = 0 ; i<allFactories.length; i++)
    {
      Send[i] = false;
      _controllersObserLine[i].text= "";
      _controllerStateLine[i].text = "";
    }

  }
}


