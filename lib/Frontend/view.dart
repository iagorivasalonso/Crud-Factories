import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Alertdialogs/noFind.dart';
import 'package:crud_factories/Alertdialogs/warning.dart';
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
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';


class view extends StatefulWidget {

  String tView;
  bool err;

  view(this.tView, this.err);

  @override
  State<view> createState() => _viewState();
}

@override
class _viewState extends State<view> {

  List<String> opSearch = ['Todos', 'Filtrar'];
  List<String> filterList = [];
  List<String> filterListSends = ['Fecha', 'Empresa'];
  List<String> filterListFactories = ['Nombre','Dirrección','Telefono','Ciudad'];
  List <LineSend> sendsDay = [];
  List <cardSend> allCards = [];
  String selectCamp = "";
  String textFilterFactory = ' ';
  int select = 0;
  int cardIndex = 0;
  int opSelected = 0;
  List<String> campSearch = [];
  List<Factory> allFactories = [];
  List<Factory> resulFactories = [];
  String textFilterSend = "";
  List<cardSend> allSend = [];
  List<cardSend> resultSend = [];
  List<String> factoryName = [];
  String? selectedFilterSend = 'Fecha';
  String? selectedFactory;
  String? selectedSend;

  String filterFactory = '';


  TextEditingController controllerSearchSend = new TextEditingController();


  Future<void> _runFilter(String view, String enteredKeyboard, String filter, List<String> factoryName, [String? filterFactory]) async {


    if (filter == "Nombre") {
      filterFactory = "Nombre";
    }

    if (filter == "") {
      filter = "Fecha";
    }

    if (enteredKeyboard.isEmpty && view == 'factory')
    {
        resulFactories = factories;
    }
    else {

      if (selectedFilterSend == "Fecha")
      {
        resultSend = allCards.where((card) {
          final descriptFormat = line[0].showFormatDate(card.description).toLowerCase();
          final textSearch = enteredKeyboard.toLowerCase();
          return descriptFormat.contains(textSearch);
        }).toList();
      }

      if (selectedFilterSend == "Empresa")
      {
          resultSend = allCards.where((element) =>
              element.title.toLowerCase().contains(enteredKeyboard.toLowerCase()))
              .toList();
      }

      if (view == "factory")
      {
        switch (filterFactory)
        {
          case "Nombre":
            resulFactories = factoriesSector.where((element) =>
                element.name.toLowerCase().contains(
                    enteredKeyboard.toLowerCase())).toList();
            break;

          case "Dirrección":
            resulFactories = factoriesSector.where((element) =>
                element.allAdress().toLowerCase().contains(
                    enteredKeyboard.toLowerCase())).toList();
            break;

          case "Telefono":
            resulFactories = factoriesSector.where((element) =>
                element.thelephones[0].toLowerCase().contains(
                    enteredKeyboard.toLowerCase())).toList();
            break;

          case "Ciudad":
            resulFactories = factoriesSector.where((element) =>
                element.address['city']!.toLowerCase().contains(
                    enteredKeyboard.toLowerCase())).toList();
            break;
        }
      }

      String stringDialog = '';
      bool noDat = false;
      var noDatfunction;

      if (view =="factory" && resulFactories.isEmpty)
      {

          stringDialog = 'Esa empresa no pertenece a nuestra base de datos';
          noDat = true;
          noDatfunction = noFind(context, noDat, stringDialog);

        if (filter == "nombre" || filter == "telefono") {
          filter = 'El $filter';
        }

        if (filter == "dirrección" || filter == "ciudad") {
          filter = 'La $filter';
        }

      }
      if (view =="send"  && resultSend.isEmpty)
      {
          if(selectedFilterSend == "Fecha")
          {
            stringDialog = 'No tenemos ningún envio en esa fecha';
            noDat = true;
          }
          else
          {
            stringDialog = 'Esa empresa no pertenece a nuestra base de datos';
            noDat = true;
          }

        noDatfunction = noFind(context, noDat, stringDialog);



      }
    }
    setState(() {

      if (view == "send")
      {
        allSend = resultSend;
      }
      if (view == "factory")
      {
        allFactories = resulFactories;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    double mWidth = MediaQuery.of(context).size.width;
    double mHeiht = MediaQuery.of(context).size.height;

    String view = widget.tView;
    bool err = widget.err;

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



    if (view == "factory") {
      filterList = filterListFactories;

    }

    if (view == "send") {

      filterList = filterListSends;

       if(selectCamp.isEmpty)
       {
         selectCamp = chargueList(0);
       }
    }

    if (controllerSearchSend.text == "") {
      if (view == 'factory')
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

    if (view == "mail") {
      mHeightList = mHeiht;
    }

    if (view == "mail") {
      mHeightList = mHeiht;
    }

    if (view == 'factory' && err == true)
    {
         WidgetsBinding.instance.addPostFrameCallback((_){

             String action = "No tiene empresas en ese departamento";
             error(context, action);

          });
     }

    
    return Scaffold(
         body: err == false
              ? Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                   children: [
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
                                           if(view== 'factory' || view =='send')
                                              Row(
                                                  children: [
                                                         for (int index = 0; index < 2; index++)
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
                                             if(view== 'factory')
                                                   if (opSelected == 1)
                                                      Container(
                                                         color: Colors.greenAccent,
                                                         height: mHeightfilter,
                                                         child: Column(
                                                             children: [
                                                                    Padding(
                                                                       padding: const EdgeInsets.only(right: 15.0, top: 10.0),
                                                                       child: Row(
                                                                         children: [
                                                                             const Padding(
                                                                              padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                                                                child: Text(
                                                                                        "Filtrar por:",
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
                                                                                       items: filterList.map((String itemFactory) =>
                                                                                           DropdownMenuItem<String>(
                                                                                             value: itemFactory,
                                                                                             child: Text(
                                                                                               itemFactory,
                                                                                               overflow: TextOverflow
                                                                                                   .ellipsis,
                                                                                             ),
                                                                                           ))
                                                                                           .toList(),
                                                                                       value:selectedFactory,
                                                                                       onChanged: (String? value) {
                                                                                       setState(() {
                                                                                                selectedFactory = value;
                                                                                                filterFactory = value.toString();
                                                                                                controllerSearchSend.clear();
                                                                                       });
                                                                                          },
                                                                                          buttonStyleData: const ButtonStyleData(
                                                                                            padding: EdgeInsets.only(left: 14, right: 14),
                                                                                          ),
                                                                                          dropdownStyleData: DropdownStyleData(
                                                                                            maxHeight: 130,
                                                                                            width: 140,
                                                                                            scrollbarTheme: ScrollbarThemeData(
                                                                                              thickness: MaterialStateProperty.all(4),
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
                                                                                        padding: const EdgeInsets.only(top: 15.0, left: 40.0, right: 40.0),
                                                                                        child:  TextField(
                                                                                          controller: controllerSearchSend,
                                                                                          onChanged: (value) =>_runFilter(view, value, textFilterFactory, factoryName,filterFactory),
                                                                                          decoration: const InputDecoration(
                                                                                              border: OutlineInputBorder(),
                                                                                              hintText: 'Buscar...'),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                               ],
                                                                              ),
                                                                           ),
                                              if(view== 'send')
                                                if (opSelected == 1)
                                                  Container(
                                                    color: Colors.greenAccent,
                                                    height: mHeightfilter,
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(right: 15.0, top: 10.0),
                                                          child: Row(
                                                            children: [
                                                              const Padding(
                                                                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                                                child: Text(
                                                                  "Filtrar por:",
                                                                  maxLines: 1,
                                                                  overflow: TextOverflow.ellipsis,
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: DropdownButtonHideUnderline(
                                                                  child: DropdownButton2<String>(
                                                                    isExpanded: true,
                                                                    hint: Text(
                                                                      selectedFilterSend!,
                                                                      overflow: TextOverflow.ellipsis,
                                                                    ),
                                                                    items: filterList.map((String itemSend) =>
                                                                        DropdownMenuItem<String>(
                                                                          value: itemSend,
                                                                          child: Text(
                                                                            itemSend,
                                                                            overflow: TextOverflow.ellipsis,
                                                                          ),
                                                                        ))
                                                                        .toList(),
                                                                    value:selectedFilterSend,
                                                                    onChanged: (String? value1) {
                                                                      setState(() {

                                                                        controllerSearchSend.clear();
                                                                        selectedFilterSend=value1;
                                                                        controllerSearchSend.text="";
                                                                        allCards.clear();
                                                                        chargueList(0);
                                                                        select = 0;


                                                                        if(selectedFilterSend == "Fecha")
                                                                        {
                                                                          selectCamp = resultSend[0].description;
                                                                        }
                                                                        if(selectedFilterSend == "Empresa")
                                                                        {
                                                                          selectCamp =resultSend[0].title;
                                                                        }

                                                                      });
                                                                     },
                                                                    buttonStyleData: const ButtonStyleData(
                                                                      padding: EdgeInsets.only(left: 14, right: 14),
                                                                    ),
                                                                    dropdownStyleData: DropdownStyleData(
                                                                      maxHeight: 130,
                                                                      width: 140,
                                                                      scrollbarTheme: ScrollbarThemeData(
                                                                        thickness: MaterialStateProperty.all(4),
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
                                                                    top: 15.0, left: 40.0, right: 40.0),
                                                                child:  TextField(
                                                                  controller: controllerSearchSend,
                                                                  onChanged: (value) => _runFilter(view, value, textFilterFactory, factoryName),
                                                                  decoration: InputDecoration(
                                                                      border: OutlineInputBorder(),
                                                                      hintText: 'Buscar...'),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    color: view == 'factory'
                                                        ? Colors.cyan
                                                        : Colors.grey,
                                                    height: view == 'mail'
                                                        ?   mHeiht-40
                                                        : opSelected == 0
                                                        ? mHeightList-mHeightbutton
                                                        : opSelected == 1
                                                        ? mHeightList - mHeightfilter - mHeightbutton
                                                        : 10,

                                                       child: Row(
                                                      children: [
                                                        Expanded(
                                                            child: view == 'factory'
                                                                ? ListView.builder(
                                                              itemCount: resulFactories.length,
                                                              itemBuilder: (context, index) {
                                                                return Padding(
                                                                  padding: const EdgeInsets.only(
                                                                      left: 3.0, right: 9.0, top: 3.0),
                                                                  child: GestureDetector(
                                                                    child: factoryCard(
                                                                        name: resulFactories[index].name,
                                                                        address: resulFactories[index].allAdress(),
                                                                        telephone: resulFactories[index].thelephones[0],
                                                                        city: resulFactories[index].address['city']),
                                                                    onTap: () async{

                                                                        if (saveChanges == false)
                                                                        {
                                                                          setState(() {
                                                                            select = int.parse(resulFactories[index].id) - 1;
                                                                          });
                                                                        }
                                                                        else
                                                                        {
                                                                          saveChanges =! await changesNoSave(context);

                                                                          if(saveChanges == false)
                                                                          {
                                                                            setState(() {
                                                                              select = int.parse(resulFactories[index].id) - 1;
                                                                            });
                                                                          }
                                                                        }

                                                                    },
                                                                  ),
                                                                );
                                                              },
                                                            )
                                                                : view == 'mail'
                                                                ? ListView.builder(
                                                              itemCount: mails.length,
                                                              itemBuilder: (context, index) {
                                                                return GestureDetector(
                                                                  child: defaultCard(
                                                                      title: mails[index].company,
                                                                      description: mails[index].addrres,
                                                                      color: index == cardIndex
                                                                          ? Colors.white
                                                                          : Colors.grey),
                                                                  onTap: () async {

                                                                      if (saveChanges == false)
                                                                      {
                                                                        setState(() {
                                                                          cardIndex = index;
                                                                          select = index;
                                                                        });
                                                                      }
                                                                      else
                                                                      {
                                                                        saveChanges =! await changesNoSave(context);

                                                                        if(saveChanges == false)
                                                                        {
                                                                          setState(() {
                                                                            cardIndex = index;
                                                                            select = index;
                                                                          });
                                                                        }
                                                                      }

                                                                  },
                                                                );
                                                              },
                                                            )
                                                                : ListView.builder(
                                                              itemCount: resultSend.length,
                                                              itemBuilder: (context, index) {
                                                                String cantSend = resultSend[index].description;
                                                                return  GestureDetector(
                                                                  child: defaultCard(
                                                                      title: resultSend[index].title,
                                                                      description:selectedFilterSend == "Fecha"
                                                                          ? line[0].showFormatDate(resultSend[index].description)
                                                                          : "Envios: $cantSend",
                                                                      color: index == cardIndex
                                                                          ? Colors.white
                                                                          : Colors.grey
                                                                  ),
                                                                  onTap: () async {

                                                                      if (saveChanges == false)
                                                                      {
                                                                        setState(() {
                                                                          sendsDay.clear();
                                                                          cardIndex = index;
                                                                          select = index;

                                                                        });
                                                                      }
                                                                      else
                                                                      {
                                                                        saveChanges =! await changesNoSave(context);

                                                                        if(saveChanges == false)
                                                                        {
                                                                          setState(() {
                                                                            sendsDay.clear();
                                                                            cardIndex = index;
                                                                            select = index;

                                                                          });
                                                                        }
                                                                      }

                                                                      if(selectedFilterSend == "Fecha")
                                                                      {
                                                                        selectCamp = resultSend[select].description;
                                                                      }
                                                                      if(selectedFilterSend == "Empresa")
                                                                      {
                                                                        selectCamp =resultSend[select].title;
                                                                      }

                                                                  },
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

                                  SizedBox(
                                   width: mWidthPanel,
                                   height: mHeiht,
                                   child: view == 'factory'
                                       ? newFactory(select)
                                       : view == 'mail'
                                       ? newMail(select)
                                       : newSend(selectCamp, filterFactory, selectedFilterSend!,select)
                                ),
                             ],
                  )
              )
              : null,
    );


  }

String chargueList(int cardIndex) {

    List <String> tmp = [];
    String cardSeleted = "";
    allCards.clear();


    if(selectedFilterSend == "Fecha")
    {

      for(int i = 0; i <dateSends.length; i++)
      {
        int numSend = i + 1;
        String titleSend = 'Envio $numSend';
        allCards.add(cardSend(
            title: titleSend ,
            description: dateSends[i])
        );
      }


    }
    resultSend = allCards;


    if(selectedFilterSend == "Empresa")
    {

      for(int i = 0; i <line.length; i++)
      {
        tmp.add(line[i].factory);
      }

      factoryName = avoidRepeteat(tmp);


      int cant =0;

      for(int i = 0; i < factoryName.length; i++)
      {
        String current = factoryName[i];
        cant = 0;

        for(int y = 0; y < line.length; y++)
        {
          if(line[y].factory == current)
          {
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