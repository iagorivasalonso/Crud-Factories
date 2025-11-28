import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Frontend/send.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/material.dart';
import '../../Alertdialogs/warning.dart';
import '../../Backend/Global/list.dart';
import '../../Functions/changesNoSave.dart';
import '../../Functions/manageArrays.dart';
import '../../Objects/LineSend.dart';
import '../../Widgets/GenericListViewPage.dart';
import '../../Widgets/defaultCard.dart';
import '../../helpers/localization_helper.dart';

class listSends extends StatefulWidget {

  listSends();

  @override
  State<listSends> createState() => _listSendsState();
}

class _listSendsState extends State<listSends> {

  int selectCard = 0;
  List<cardSend> displayLines = [];
  String selectedFilter = "Fecha";
  String selectCamp ="";
  int select = 0;
  // valor inicial

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    resultSend = chargueList(context1, selectedFilter);
    displayLines = List.from(resultSend);


    if (displayLines.isNotEmpty) {
      selectCard = 0;
      select = 0;

      if (selectedFilter == S
          .of(context1)
          .date) {
        selectCamp = resultSend[0].description;
      } else {
        selectCamp = resultSend[0].title;
      }
    }

  }
  Future<void>_onDelete(cardSend line)  async {

    final confirmDelete = await warning(
      context,
      LocalizationHelper.delete_factory(context, line.title),
    );

    if (confirmDelete) {
      setState(() {
        factoriesSector.remove(factory);
        allFactories.remove(factory);
      });
/*
      if (conn != null) {
        await sqlDeleteLines(idsDelete)
      } else {
        csvExportatorLines(listSend)
      }*/
    }


  }


  Future<void> _onFilter(String filter, String search) async {
    selectedFilter = filter;
    final lowerSearch = search.toLowerCase();


    setState(() {
      displayLines = chargueList(context1, selectedFilter)
          .where((element) =>
          element.description.toLowerCase().contains(lowerSearch))
          .toList();

    });

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
    resultSend = chargueList(context1, selectedFilter);

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
          child: GenericListViewPage<cardSend>(
            itens: displayLines,
            defaultFilter: selectedFilter,
            filters: filterOptions,
            itemBuilder: (send, index) =>
                defaultCard(
                  title: send.title,
                  description: send.description,
                  color: selectCard  == index
                      ? Colors.white
                      : Colors.grey,
                ),
            onDelete: _onDelete,
            onFilter: _onFilter,
            onTap: (send, index) => _onTap(index,context),
            onSelect: (index) {
              setState(() {
                // selectedIndex = index;
              });
            },
          ),
        ),

        SizedBox(
          width: mWidth - mWidthList,
          child: newSend(selectCamp,  selectedFilter!, select)
        ),
      ],
    );
  }
  
}

List<cardSend> chargueList (BuildContext context, String filter) {

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
       List <String> tmp = lineSector.map((e) => e.factory).toList();

       List<String> factories = manageArrays.avoidRepeteat(tmp);

       for (String current in factories)
       {
         int count = lineSector.where((e) => e.factory == current).length;

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

