import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Alertdialogs/noFind.dart';
import 'package:crud_factories/Alertdialogs/warning.dart';
import 'package:crud_factories/Backend/CSV/exportEmpleoyes.dart';
import 'package:crud_factories/Backend/CSV/exportFactories.dart';
import 'package:crud_factories/Backend/CSV/exportLines.dart';
import 'package:crud_factories/Backend/CSV/exportMails.dart';
import 'package:crud_factories/Backend/SQL/deleteFactory.dart';
import 'package:crud_factories/Backend/SQL/deleteLines.dart';
import 'package:crud_factories/Backend/SQL/deleteMail.dart';
import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Frontend/factory.dart';
import 'package:crud_factories/Frontend/mail.dart';
import 'package:crud_factories/Frontend/send.dart';
import 'package:crud_factories/Functions/avoidRepeatArray.dart';
import 'package:crud_factories/Functions/changesNoSave.dart';
import 'package:crud_factories/Objects/Factory.dart';
import 'package:crud_factories/Objects/LineSend.dart';
import 'package:crud_factories/Widgets/defaultCard.dart';
import 'package:crud_factories/Widgets/factoryCard.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:crud_factories/helpers/localization_helper.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';


class view extends StatefulWidget {

  BuildContext context;
  String tView;
  bool err;

  view(this.tView, this.err, this.context);

  @override
  State<view> createState() => _viewState();
}

@override
class _viewState extends State<view> {

  List<String> opSearch = [];
  List<String> filterList = [];
  List<String> filterListSends = [];
  List<String> filterListFactories = [];
  List <LineSend> sendsDay = [];
  List <cardSend> allCards = [];
  String selectCamp = "";
  String textFilterFactory = '';
  String filterFactory = '';
  String? filterSend = '';
  int select = 0;
  int cardIndex = 0;
  int opSelected = 0;
  bool suprLines = false;
  List<String> campSearch = [];
  List<Factory> allFactories = [];
  List<Factory> resulFactories = [];
  String textFilterSend = "";
  List<cardSend> allSend = [];
  List<cardSend> resultSend = [];
  List<String> factoryName = [];
  String? selectedFactory;
  String? selectedSend;

  Future<void> _runFilter(BuildContext context, String view, String enteredKeyboard, String filter,
      List<String> factoryName, [String? filterFactory]) async {

    if (filter ==  S.of(context).name) {
      filterFactory = S.of(context).name;
    }

    if (filter == "") {
      filter = S.of(context).date;
    }

    if (enteredKeyboard.isEmpty && view == S.of(context).company)
    {
      resulFactories = allFactories;
    }
    else
    {
        if (filterSend ==  S.of(context).date)
        {
          resultSend = allCards.where((card) {
            final descriptFormat = lineSector[0]
                .showFormatDate(card.description)
                .toLowerCase();
            final textSearch = enteredKeyboard.toLowerCase();
            return descriptFormat.contains(textSearch);
          }).toList();
        }

        if (filterSend == S.of(context).company)
        {
          resultSend = allCards.where((element) =>
              element.title.toLowerCase().contains(enteredKeyboard.toLowerCase()))
              .toList();
        }

        if (view == S.of(context).company)
        {
           if(filterFactory==S.of(context).name)
           {
             resulFactories = factoriesSector.where((element) =>
                 element.name.toLowerCase().contains(
                     enteredKeyboard.toLowerCase())).toList();
           }
           else if(filterFactory==S.of(context).address)
           {
             resulFactories = factoriesSector.where((element) =>
                 element.allAdress().toLowerCase().contains(
                     enteredKeyboard.toLowerCase())).toList();
           }
           else if(filterFactory==S.of(context).phone)
           {
             resulFactories = factoriesSector.where((element) =>
                 element.thelephones[0].toLowerCase().contains(
                     enteredKeyboard.toLowerCase())).toList();
           }
           else if(filterFactory==S.of(context).city)
           {
             resulFactories = factoriesSector.where((element) =>
                 element.address['city']!.toLowerCase().contains(
                     enteredKeyboard.toLowerCase())).toList();
           }
        }

        String stringDialog = '';
        bool noDat = false;
        var noDatfunction;

        if (view == S.of(context).company && resulFactories.isEmpty)
        {
              stringDialog = S.of(context).that_company_does_not_belong_to_our_database;

              String pr = "";
              noDat = true;
              noDatfunction = noFind(context, noDat, stringDialog);

              if (filter == S.of(context).name || filter == S.of(context).phone)
              {
                  pr = S.of(context).he;
              }

              if (filter ==  S.of(context).address || filter ==  S.of(context).city)
              {
                  pr = S.of(context).the;
              }
              filter = '$pr $filter';
        }
        if (view ==  S.of(context).shipment && resultSend.isEmpty)
        {
              if (filterSend == S.of(context).date)
              {
                stringDialog = S.of(context).we_do_not_have_any_shipping_on_that_date;
                noDat = true;
              }
              else
              {
                stringDialog = S.of(context).that_company_does_not_belong_to_our_database;
                noDat = true;
              }

              noDatfunction = noFind(context, noDat, stringDialog);
        }
    }
    setState(() {
      if (view == S.of(context).shipment) {
        allSend = resultSend;
      }
      if (view == S.of(context).company) {
        allFactories = resulFactories;
      }
    });
  }

  @override
  @override
  Widget build(BuildContext context) {

    BuildContext context = widget.context;

    double mWidth = MediaQuery
        .of(context)
        .size
        .width;
    double mHeiht = MediaQuery
        .of(context)
        .size
        .height;

    List<String> opSearch = [
      S.of(context).allMale,
      S.of(context).filter,
    ];

    filterListFactories = [
      S.of(context).name,
      S.of(context).address,
      S.of(context).phone,
      S.of(context).city,
    ];

    filterFactory = S.of(context).name;

    filterListSends = [
      S.of(context).date,
      S.of(context).company
    ];

    filterSend = S.of(context).date;

    String view = widget.tView;
    bool err = false;
    double mWidthList = mWidth * 0.2;
    if (mWidthList < 42.0)
      opSelected = 0;

    if (mWidth > 280) {
      if (mWidthList < 240) {
        mWidthList = 240;
      } else {
        mWidthList = mWidth * 0.2;
      }
    } else {
      mWidthList = mWidth * 0.8;
    }

    if (view == S.of(context).company) {
      filterList = filterListFactories;
    }

    if (view == S.of(context).shipment) {
      filterList = filterListSends;

      if (selectCamp.isEmpty && widget.err == false) {
        selectCamp = chargueList(0,context);
      }
    }

    if (controllerSearchSend.text == "") {
      if (view ==S.of(context).company)
        resulFactories = factoriesSector;
    }

    double mWidthPanel = mWidth - mWidthList;

    double mHeightfilter = 150;
    double mHeightList = 0;
    double mHeightbutton = 0;

    if (mHeiht > 190) {
      mHeightbutton = 40;
      mHeightList = mHeiht - mHeightbutton;
    } else {
      mHeightbutton = 0;
      mHeightList = mHeiht - 40;
    }

    if (view == S.of(context).email) {
      mHeightList = mHeiht;
    }



    WidgetsBinding.instance.addPostFrameCallback((_) {

      String action="";

      if(widget.err== true)
      {
        if (view == S.of(context).company)
        {
          action = LocalizationHelper.no_array_departament(context, view);
        }

        if (view == S.of(context).shipment)
        {
          action = LocalizationHelper.no_array_departament(context, view);
        }
      }
    });


    if (view == S.of(context).email)
    {
      if(mails.isEmpty)
      {
        setState(() {
          err = true;
        });
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {

      String action="";

      if (view == S.of(context).email && mails.isEmpty)
      {
        action = S.of(context).you_do_not_have_emails_in_your_database;
        error(context, action);
      }

      if(view == S.of(context).company && factoriesSector.isEmpty)
      {
        action = LocalizationHelper.no_array_departament(context, view);
        error(context, action);
      }

      if(view == S.of(context).shipment && lineSector.isEmpty)
      {
        action = LocalizationHelper.no_array_departament(context, view);
        error(context, action);
      }
    });

    return Scaffold(
      body: widget.err== false
          ? Align(
          alignment: Alignment.topLeft,
          child: Row(
            children: [
              if(err==false)
                SizedBox(
                    width: mWidthList,
                    height: mHeightList,
                    child: Container(
                      decoration: const BoxDecoration(
                          border: Border(
                            right: BorderSide(width: 5, color: Colors.grey),
                          )
                      ),
                      child: Column(
                        children: [
                          if(view == S.of(context).company || view == S.of(context).shipment)
                            Row(
                              children: [
                                for (int index = 0; index < opSearch.length; index++)
                                  Expanded(
                                    child: GestureDetector(
                                      child: Container(
                                        height: mHeightbutton,
                                        color: index == opSelected
                                            ? Colors.lightGreen
                                            : Colors.white,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(opSearch[index],
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: index == opSelected
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          opSelected = index;
                                          controllerSearchSend.clear();
                                        });
                                      },
                                    ),
                                  ),
                              ],
                            ),
                          if(view == S.of(context).company)
                            if (opSelected == 1)
                              Container(
                                color: Colors.greenAccent,
                                height: mHeightfilter,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 15.0, top: 10.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 10.0, right: 10.0),
                                            child: Text(
                                              S.of(context).filter_by,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Expanded(
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton2<String>(
                                                isExpanded: true,
                                                hint: Text(
                                                  filterFactory,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                items: filterList.map((
                                                    String itemFactory) =>
                                                    DropdownMenuItem<String>(
                                                      value: itemFactory,
                                                      child: Text(
                                                        itemFactory,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ))
                                                    .toList(),
                                                value: selectedFactory,
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    selectedFactory = value;
                                                    filterFactory = value.toString();
                                                    controllerSearchSend.clear();
                                                  });
                                                },
                                                buttonStyleData: const ButtonStyleData(
                                                  padding: EdgeInsets.only(
                                                      left: 14, right: 14),
                                                ),
                                                dropdownStyleData: DropdownStyleData(
                                                  maxHeight: 130,
                                                  width: 140,
                                                  scrollbarTheme: ScrollbarThemeData(
                                                    thickness: MaterialStateProperty
                                                        .all(4),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 15.0,
                                                left: 40.0,
                                                right: 40.0),
                                            child: TextField(
                                              controller: controllerSearchSend,
                                              onChanged: (value) => _runFilter(context,
                                                  view, value, textFilterFactory,
                                                  factoryName, filterFactory),
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  hintText: S.of(context).search),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                          if(view == S.of(context).shipment)
                            if (opSelected == 1)
                              Container(
                                color: Colors.greenAccent,
                                height: mHeightfilter,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 15.0, top: 10.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 10.0, right: 10.0),
                                            child: Text(
                                                S.of(context).filter_by,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Expanded(
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton2<String>(
                                                isExpanded: true,
                                                hint: Text(
                                                  filterSend!,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                items: filterList.map((
                                                    String itemSend) =>
                                                    DropdownMenuItem<String>(
                                                      value: itemSend,
                                                      child: Text(
                                                        itemSend,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ))
                                                    .toList(),
                                                value: filterSend,
                                                onChanged: (String? value1) {
                                                  setState(() {
                                                    controllerSearchSend.clear();
                                                    filterSend = value1;
                                                    controllerSearchSend.text =
                                                    "";
                                                    allCards.clear();
                                                    chargueList(0,context);
                                                    select = 0;


                                                    if (filterSend == S.of(context).date) {
                                                      selectCamp = resultSend[0].description;
                                                    }
                                                    if (filterSend ==S.of(context).company) {
                                                      selectCamp = resultSend[0].title;
                                                    }
                                                  });
                                                },
                                                buttonStyleData: const ButtonStyleData(
                                                  padding: EdgeInsets.only(
                                                      left: 14, right: 14),
                                                ),
                                                dropdownStyleData: DropdownStyleData(
                                                  maxHeight: 130,
                                                  width: 140,
                                                  scrollbarTheme: ScrollbarThemeData(
                                                    thickness: MaterialStateProperty
                                                        .all(4),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 15.0,
                                                left: 40.0,
                                                right: 40.0),
                                            child: TextField(
                                              controller: controllerSearchSend,
                                              onChanged: (value) => _runFilter( context,
                                                  view, value, textFilterFactory,
                                                  factoryName),
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  hintText: S.of(context).search),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                          Container(
                            color: view == S.of(context).company
                                ? Colors.cyan
                                : Colors.grey,
                            height: view == S.of(context).email
                                ? mHeiht - 40
                                : opSelected == 0
                                ? mHeightList - mHeightbutton
                                : opSelected == 1
                                ? mHeightList - mHeightfilter - mHeightbutton
                                : 10,
                            child: Row(
                              children: [
                                Expanded(
                                    child: view == S.of(context).company
                                        ? ListView.builder(
                                      itemCount: resulFactories.length,
                                      itemBuilder: (context0, index) {
                                        return Dismissible(
                                          key: Key(resulFactories[index].name),
                                          confirmDismiss: (direction) async {

                                            String array = S.of(context).the_company;
                                            String action1 = LocalizationHelper.ask_confirm_supr(context, array);
                                            return await warning(context, action1);
                                          },
                                          onDismissed: (direction) async {
                                            if (view == S.of(context).company)
                                            {
                                              String idSupr = resulFactories[index].id;

                                              for(int i = 0; i <allFactories.length; i++)
                                              {
                                                if(allFactories[i].id==idSupr)
                                                {
                                                  String name = allFactories[i].name;
                                                  String action = LocalizationHelper.delete_factory(context, name);
                                                  bool delete = await confirm(context, action);
                                                  allFactories.removeAt(i);
                                                }
                                              }

                                              if(allFactories.isEmpty)
                                              {
                                                setState(() {});
                                              }
                                              if (conn != null)
                                              {
                                                sqlDeleteFactory(idSupr);
                                              }
                                              else {
                                                csvExportatorFactories(allFactories);
                                                empleoyes.removeWhere((empleoye) => empleoye.idFactory == idSupr);
                                                csvExportatorEmpleoyes(empleoyes);
                                              }

                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 3.0, right: 9.0, top: 3.0),
                                            child: GestureDetector(
                                              child: factoryCard(
                                                  name: resulFactories[index]
                                                      .name,
                                                  address: resulFactories[index]
                                                      .allAdress(),
                                                  telephone: resulFactories[index]
                                                      .thelephones[0],
                                                  city: resulFactories[index]
                                                      .address['city']),
                                              onTap: () async {
                                                if (saveChanges == false) {
                                                  setState(() {
                                                    select = int.parse(
                                                        resulFactories[index]
                                                            .id) - 1;
                                                  });
                                                }
                                                else {
                                                  saveChanges = !await changesNoSave(context);

                                                  if (saveChanges == false) {
                                                    setState(() {
                                                      select = int.parse(
                                                          resulFactories[index]
                                                              .id) - 1;
                                                    });
                                                  }
                                                }
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                        : view == S.of(context).email
                                        ? ListView.builder(
                                      itemCount: mails.length,
                                      itemBuilder: (context0, index) {
                                        String array = "";
                                        return Dismissible(
                                          key: Key(mails[index].addrres),
                                          confirmDismiss: (direction) async {
                                            String pr = S.of(context).he;
                                            String array0 = S.of(context).email;
                                             array = "$pr $array0";
                                            String action1 = LocalizationHelper.ask_confirm_supr(context, array);
                                            return await warning(
                                                context, action1);
                                          },
                                          onDismissed: (direction) async {
                                            if (view == S.of(context).email) {
                                              String idSupr = mails[index].id;
                                              String act = S.of(context).has_been_deleted_successfully;
                                              String action = '$array  $act';
                                              bool delete = await confirm(context, action);
                                              setState(() {
                                                mails.removeAt(index);
                                              });

                                              if (conn != null) {
                                                sqlDeleteMail(idSupr);

                                              }
                                              else {
                                                csvExportatorMails(mails);
                                              }
                                            }
                                          },
                                          child: GestureDetector(
                                            child: defaultCard(
                                                title: mails[index].company,
                                                description: mails[index].addrres,
                                                color: index == cardIndex
                                                    ? Colors.white
                                                    : Colors.grey),
                                            onTap: () async {
                                              if (saveChanges == false) {
                                                setState(() {
                                                  cardIndex = index;
                                                  select = index;
                                                });
                                              }
                                              else {
                                                saveChanges =
                                                !await changesNoSave(context);

                                                if (saveChanges == false) {
                                                  setState(() {
                                                    cardIndex = index;
                                                    select = index;
                                                  });
                                                }
                                              }
                                            },
                                          ),
                                        );
                                      },
                                    )
                                        : ListView.builder(
                                      itemCount: resultSend.length,
                                      itemBuilder: (context0, index) {

                                        String cantSend = resultSend[index].description;
                                        String send = S.of(context).shipments;
                                        String titleSend ="$send: $cantSend";

                                        return Dismissible(
                                          key: Key(resultSend[index].title),
                                          confirmDismiss: (direction) async {
                                            if (view == S.of(context).shipment) {
                                              String action1 = S.of(context).You_can_only_delete_the_lines_that_were_returned_Do_you_want_to_delete;
                                              suprLines = await warning(context, action1);

                                              String campKey = " ";
                                              List<String> idsDelete = [];
                                              if (suprLines == true)
                                              {

                                                if (filterSend == S.of(context).date) {

                                                  campKey = resultSend[index].description;

                                                  for (int i = 0; i < lineSector.length; i++)
                                                  {
                                                    if (lineSector[i].date == campKey && lineSector[i].state == S.of(context).returned)
                                                    {
                                                      idsDelete.add(lineSector[i].id);
                                                    }
                                                  }
                                                }
                                                else
                                                {
                                                  campKey = resultSend[index].title;

                                                  for (int i = 0; i < lineSector.length; i++)
                                                  {
                                                    if (campKey == lineSector[i].factory && lineSector[i].state ==S.of(context).returned)
                                                    {
                                                      idsDelete.add(lineSector[i].id);
                                                    }
                                                  }
                                                }

                                                int cantLines = idsDelete.length;
                                                String action = LocalizationHelper.delete_Cant_Lines(context, cantLines);
                                                bool delete = await confirm(context, action);

                                                for (int l = 0; l < idsDelete.length; l++)
                                                {
                                                  lineSector.removeWhere((line) => line.id == idsDelete[l]);
                                                }

                                                setState(() {

                                                });
                                              }

                                              if (conn != null)
                                              {
                                                sqlDeleteLines(idsDelete);
                                              }
                                              else
                                              {
                                                csvExportatorLines(lineSector);
                                              }
                                            }

                                            return false;
                                          },
                                          child: GestureDetector(
                                            child: defaultCard(
                                                title: resultSend[index].title,
                                                description: filterSend ==
                                                    S.of(context).date
                                                    ? lineSector[0].showFormatDate(
                                                    resultSend[index].description)
                                                    : titleSend,
                                                color: index == cardIndex
                                                    ? Colors.white
                                                    : Colors.grey
                                            ),
                                            onTap: () async {
                                              if (saveChanges == false) {
                                                setState(() {
                                                  sendsDay.clear();
                                                  cardIndex = index;
                                                  select = index;
                                                });
                                              }
                                              else {
                                                saveChanges = !await changesNoSave(context);

                                                if (saveChanges == false) {
                                                  setState(() {
                                                    sendsDay.clear();
                                                    cardIndex = index;
                                                    select = index;
                                                  });
                                                }
                                              }

                                              if (filterSend ==S.of(context).date) {
                                                selectCamp = resultSend[select].description;
                                              }
                                              if (filterSend ==S.of(context).company) {
                                                selectCamp = resultSend[select].title;
                                              }
                                            },
                                          ),
                                        );
                                      },
                                    )
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              if(err==false)
                SizedBox(
                    width: mWidthPanel,
                    height: mHeiht,
                    child: view == S.of(context).company
                        ? newFactory(context,select,)
                        : view == S.of(context).email
                        ? newMail(context,select)
                        : newSend(
                        context,selectCamp, filterFactory, filterSend!, select)
                ),
            ],
          )
      )
          : null,
    );
  }



  String chargueList(int cardIndex, BuildContext context) {

    List <String> tmp = [];
    String cardSeleted = "";
    allCards.clear();

    if (filterSend ==S.of(context).date) {
      for (int i = 0; i < dateSends.length; i++)
      {
        int numSend = i + 1;
        String send = S.of(context).shipment;
        String titleSend = '$send $numSend';
        allCards.add(cardSend(
            title: titleSend,
            description: dateSends[i])
        );
      }
    }
    resultSend = allCards;


    if (filterSend == S.of(context).company) {
      for (int i = 0; i < lineSector.length; i++) {
        tmp.add(lineSector[i].factory);
      }

      factoryName = avoidRepeteat(tmp);


      int cant = 0;

      for (int i = 0; i < factoryName.length; i++) {
        String current = factoryName[i];
        cant = 0;

        for (int y = 0; y < lineSector.length; y++) {
          if (lineSector[y].factory == current) {
            cant++;
          }
        }

        allCards.add(
            cardSend(
                title: current,
                description: cant.toString()
            )
        );
      }
    }
    cardSeleted = allCards[0].description;
    return cardSeleted;
  }




}
