import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Frontend/send.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:crud_factories/Alertdialogs/warning.dart';
import 'package:crud_factories/Backend/CSV/exportLines.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/SQL/deleteLines.dart';
import 'package:crud_factories/Functions/changesNoSave.dart';
import 'package:crud_factories/Functions/isNotAndroid.dart';
import 'package:crud_factories/Functions/manageArrays.dart';
import 'package:crud_factories/Objects/LineSend.dart';
import 'package:crud_factories/Widgets/GenericListViewPage.dart';
import 'package:crud_factories/Widgets/defaultCard.dart';
import 'package:crud_factories/helpers/localization_helper.dart';
import 'package:intl/intl.dart';

class listSends extends StatefulWidget {

  BuildContext context;
  List<LineSend> list;
  List<String> dateSends;

  listSends(this.context , this.list, this.dateSends);

  @override
  State<listSends> createState() => _listSendsState();
}

class _listSendsState extends State<listSends> {
  late ValueNotifier<List<cardSend>> displayLinesNotifier;
  late ValueNotifier<List<String>> dateSendsNotifier;

  int selectCard = 0;
  List<cardSend> displayLines = [];
  String selectedFilter = "";
  String selectCamp ="";
  int select = 0;
  // valor inicial

  @override
  @override
  void initState() {
    super.initState();

    final newDates = widget.list
        .map((l) => l.date)
        .toSet()
        .toList();

      selectedFilter = S.of(context1).date;

    dateSendsNotifier = ValueNotifier(newDates);

    displayLinesNotifier = ValueNotifier(
      chargueList(context1, selectedFilter, widget.list, widget.dateSends),
    );


    resultSend = displayLinesNotifier.value;

    if (resultSend.isNotEmpty) {
      selectCard = 0;
      select = 0;

      if (selectedFilter == S.of(context1).date) {
        selectCamp = resultSend[0].description;
      } else {
        selectCamp = resultSend[0].title;
      }
    }
  }
  @override
  void didUpdateWidget(covariant listSends oldWidget) {



    super.didUpdateWidget(oldWidget);

    if (oldWidget.list != widget.list || oldWidget.dateSends != widget.dateSends) {

      final newDates = widget.list.map((l) => l.date).toSet().toList();
      dateSendsNotifier.value = newDates;

      displayLinesNotifier.value =
          chargueList(context1, selectedFilter, widget.list, newDates);


      resultSend = displayLinesNotifier.value;
      if (resultSend.isNotEmpty) {
        selectCard = 0;
        select = 0;
        selectCamp = selectedFilter == S.of(context1).date
            ? resultSend[0].description
            : resultSend[0].title;

      }
    }
  }



  Future<bool> _onDelete(BuildContext context, cardSend line)  async {

    List<LineSend> linesToDelete = allLines
        .where((l) => l.state == S.of(context).returned && l.date ==line.description)
        .toList();

    final confirmDelete = await warning(
      context,
      LocalizationHelper.confirm_delete(context,S.of(context).You_can_only_delete_the_lines_that_were_returned_Do_you_want_to_delete),
    );
    if (confirmDelete)
    {
      setState(() {
        allLines.removeWhere((l) =>
        l.state == S.of(context).returned &&
            l.date == line.description);
      });
      //return true;
    }


        if (BaseDateSelected.isNotEmpty) {

          List<String> idsDelete = [];

          for(int i = 0; i < linesToDelete.length; i++)
          {
            idsDelete.add(linesToDelete[i].id);
          }
           await sqlDeleteLines(idsDelete);

        } else {
          csvExportatorLines(allLines);
        }

    return false;
  }


  Future<void> _onFilter(BuildContext context,String filter, String search) async {
    selectedFilter = filter;
    final lowerSearch = search.toLowerCase();

    final baseList = chargueList(
      context1,
      selectedFilter,
      widget.list,
      widget.dateSends,
    );

    bool matchesDate(String dateStr) {
      try {
        final date = DateFormat('dd-MM-yyyy').parse(dateStr);

        final dayNoZero = DateFormat("d", "es_ES").format(date);   // 1
        final dayWithZero = DateFormat("dd", "es_ES").format(date); // 01
        final month = DateFormat("MMMM", "es_ES").format(date);
        final year = DateFormat("yyyy", "es_ES").format(date);

        final formatted1 = "$dayNoZero de $month de $year".toLowerCase();
        final formatted2 = "$dayWithZero de $month de $year".toLowerCase();

        return formatted1.contains(lowerSearch) ||
            formatted2.contains(lowerSearch) ||
            year.contains(lowerSearch) ||
            dateStr.toLowerCase().contains(lowerSearch);

      } catch (e) {
        return false;
      }
    }

    final listFiltered = baseList.where((element) {
      final title = element.title.toLowerCase();
      final desc = element.description.toLowerCase();

      if (selectedFilter == S.of(context1).date) {
        return matchesDate(element.description) ||
            title.contains(lowerSearch);
      }

      if (selectedFilter == S.of(context1).company) {
        return title.contains(lowerSearch) ||
            desc.contains(lowerSearch);
      }

      return title.contains(lowerSearch) ||
          desc.contains(lowerSearch);
    }).toList();

    setState(() {
      selectCard = 0;
      select = 0;

      resultSend = listFiltered;

      if (listFiltered.isNotEmpty) {
        if (selectedFilter == S.of(context1).date) {
          selectCamp = listFiltered[0].description;
        } else {
          selectCamp = listFiltered[0].title;
        }
      }
    });

    displayLinesNotifier.value = listFiltered;
  }
  Future<void>_onTap(int index, BuildContext context)  async {
   setState(() {
     selectCard = index;
     select = index;

     if (selectedFilter == S.of(context).date) {
       selectCamp = resultSend[select].description;
     }
     if (selectedFilter == S.of(context).company) {
       selectCamp = resultSend[select].title;
     }

   });

   if (saveChanges) {
     bool discard = await changesNoSave(context);

     if (!discard) return;

     saveChanges = false;
   }
    resultSend = chargueList(context1, selectedFilter,widget.list,widget.dateSends);

  }
  @override
  Widget build(BuildContext context0) {

    BuildContext context = isNotAndroid() ? context0 :  context1;

    if(selectedFilter.isEmpty)
      selectedFilter = S.of(context).date;

    double mWidth = MediaQuery
        .of(context)
        .size
        .width;
    double mWidthList = mWidth > 280 ? 280 : 0;

    final filterOptions = [
      S.of(context).date,
      S.of(context).company,
    ];
    return Row(
      children: [
        Container(
          color: Colors.grey,
          width: mWidthList,
          child: ValueListenableBuilder<List<cardSend>>(
            valueListenable: displayLinesNotifier,
            builder: (_, display, __) {
              return GenericListViewPage<cardSend>(
                itens: display,
                defaultFilter: selectedFilter,
                filters: filterOptions,
                itemBuilder: (send, index) => defaultCard(
                  title: send.title,
                  description:selectedFilter == S.of(context).date
                    ? LineSend.showFormatDate(send.description, context)
                    : send.description ,
                  color: selectCard == index ? Colors.white : Colors.grey,
                ),
                onFilter:  (item, query) => _onFilter(context,item,query),
                onDelete: (line) => _onDelete(context, line),
                onTap: (send, index) => _onTap(index, context),
                onSelect: (_) {},
              );
            },
          ),

        ),

        SizedBox(
          width: mWidth - mWidthList,
          child: newSend(selectCamp,  selectedFilter, select)
        ),
      ],
    );
  }
  
}

List<cardSend> chargueList (BuildContext context, String filter, List<LineSend> list, List<String> dateSends) {

    List<cardSend> allCards = [];

    if(filter == S.of(context).date)
    {
        for(int i = 0; i < dateSends.length; i++)
        {
           allCards.add(
             cardSend(
                title: '${S.of(context).shipment} ${i + 1}',
                description: dateSends[i],
              ),
           );
        }

    }

    if(filter == S.of(context).company)
    {
       List <String> tmp = list.map((e) => e.factory).toList();

       List<String> factories = manageArrays.avoidRepeteat(tmp);

       for (String current in factories)
       {
         int count = list.where((e) => e.factory == current).length;

         allCards.add(
           cardSend(
             title: current,
             description: count.toString(),
           ),
         );
       }
    }
    resultSend = allCards;
    return allCards;
}


