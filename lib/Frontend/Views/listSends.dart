import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Frontend/send.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/material.dart';
import '../../Alertdialogs/warning.dart';
import '../../Backend/CSV/exportLines.dart';
import '../../Backend/Global/list.dart';
import '../../Backend/SQL/deleteLines.dart';
import '../../Functions/changesNoSave.dart';
import '../../Functions/manageArrays.dart';
import '../../Objects/LineSend.dart';
import '../../Widgets/GenericListViewPage.dart';
import '../../Widgets/defaultCard.dart';
import '../../helpers/localization_helper.dart';

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
  String selectedFilter = "Fecha";
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
        .where((l) => l.state.toLowerCase() == "devuelto" && l.date ==line.description)
        .toList();

    final confirmDelete = await warning(
      context,
      LocalizationHelper.confirm_delete(context,S.of(context).You_can_only_delete_the_lines_that_were_returned_Do_you_want_to_delete),
    );
    if (confirmDelete)
    {
      setState(() {
        allLines.removeWhere((l) =>
        l.state.toLowerCase() == "devuelto" &&
            l.date == line.description);
      });
      //return true;
    }


        if (conn != null) {

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


  Future<void> _onFilter(String filter, String search) async {
    selectedFilter = filter;
    final lowerSearch = search.toLowerCase();

    final listFiltered = chargueList(context1, selectedFilter, widget.list, widget.dateSends)
        .where((element) => element.description.toLowerCase().contains(lowerSearch))
        .toList();

    displayLinesNotifier.value = List.from(listFiltered);

  }
  Future<void>_onTap(int index, BuildContext context)  async {

    selectCard = index;
    select = index;

    if (selectedFilter == S.of(context).date) {
      selectCamp = resultSend[select].description;
    }
    if (selectedFilter == S.of(context).company) {
      selectCamp = resultSend[select].title;
    }

    if (saveChanges) {
      saveChanges = !await changesNoSave(context);
      return;
    }
    resultSend = chargueList(context1, selectedFilter,widget.list,widget.dateSends);

  }
  @override
  Widget build(BuildContext context) {

    BuildContext context = context1;


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
                  description: send.description,
                  color: selectCard == index ? Colors.white : Colors.grey,
                ),
                onFilter: _onFilter,
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
print("deben ser ess$dateSends");
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


