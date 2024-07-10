import 'package:crud_factories/Alertdialogs/noFind.dart';
import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Frontend/factory.dart';
import 'package:crud_factories/Frontend/mail.dart';
import 'package:crud_factories/Frontend/send.dart';
import 'package:crud_factories/Objects/Factory.dart';
import 'package:crud_factories/Widgets/defaultCard.dart';
import 'package:crud_factories/Widgets/factoryCard.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';


class view extends StatefulWidget {

  String tView;



  view(this.tView);

  @override
  State<view> createState() => _viewState();
}

@override
class _viewState extends State<view> {

  List<String> opSearch = ['Todos', 'Filtrar'];
  List<String> filterList = [];
  List<String> filterListSends = ['Fecha', 'Empresa'];
  List<String> filterListFactories = ['Nombre','Dirrección','Telefono','Ciudad'];

  int opSelected = 0;
  String selectCamp = "";
  int cardSeleted = 0;
  String textFilterFactory = ' ';
  int select = 0;

  List<String> campSearch = [];
  List<Factory> campSearchFactory = [];

  List<Factory> resulFactories = [];
  String textFilterSend = "";
  List<String> result = [];
  List<String> factoryName = [];
  String? selectedFilterSend = 'Fecha';
  String typefilter = "";
  String? selectedFactory;
  String? selectedSend;
  String factoryFilter = 'Nombre';
  String sendFilter = 'Fecha';
  String filterFactory = '';

  String campfilter = " ";

  TextEditingController controllerSearchFactory = new TextEditingController();
  TextEditingController controllerSearchSend = new TextEditingController();

  void _runFilter(String view, String enteredKeyboard, String filter,
      String filter1, List<String> factoryName) {
    if (filter1 == "Nombre") {
      filterFactory = "Nombre";
    }

    if (filter1 == "") {
      filter1 = "Fecha";
    }

    if (enteredKeyboard.isEmpty) {
      if (view == "send" && filter1 == "Fecha") {
        result = dateSends;
      }

      if (view == "send" && filter1 == "Empresa") {
        result = factoryName;
      }
      if (view == 'factory') {
        resulFactories = factories;
      }
    }
    else {
      if (filter1 == "Fecha") {
        result = dateSends.where((item) =>
            item.toLowerCase().contains(enteredKeyboard.toLowerCase()))
            .toList();
      }

      if (filter1 == "Empresa") {
        result = factoryName.where((item) =>
            item.toLowerCase().contains(enteredKeyboard.toLowerCase()))
            .toList();
      }

      if (view == "factory") {
        switch (filter1) {
          case "Nombre":
            resulFactories = factories.where((element) =>
                element.name.toLowerCase().contains(
                    enteredKeyboard.toLowerCase())).toList();
            break;

          case "Dirrección":
            resulFactories = factories.where((element) =>
                element.allAdress().toLowerCase().contains(
                    enteredKeyboard.toLowerCase())).toList();
            break;

          case "Telefono":
            resulFactories = factories.where((element) =>
                element.thelephones[0].toLowerCase().contains(
                    enteredKeyboard.toLowerCase())).toList();
            break;

          case "Ciudad":
            resulFactories = factories.where((element) =>
                element.address['city']!.toLowerCase().contains(
                    enteredKeyboard.toLowerCase())).toList();
            break;
        }
      }

      String stringDialog = '';
      bool noDat = false;
      var noDatfunction;

      if (result.length == 0) {
        if (filter1 == "Fecha") {
          stringDialog = 'No se encuentra la fecha en nuestra base de datos';
          noDat = true;
          noDatfunction = noFind(context, noDat, stringDialog);
        }

        if (filter1 == "Empresa") {
          stringDialog = 'Esa empresa no pertenece a nuestra base de datos';
          noDat = true;
          noDatfunction = noFind(context, noDat, stringDialog);
        }
      }
      if (resulFactories.length == 0) {
        filter1 = filter1.toLowerCase();

        if (filter1 == "nombre" || filter1 == "telefono") {
          filter1 = 'El $filter1';
        }

        if (filter1 == "dirrección" || filter1 == "ciudad") {
          filter1 = 'La $filter1';
        }

        stringDialog = '$filter1 no pertenece a nuestra base de datos';
        noDat = true;
        noDatfunction = noFind(context, noDat, stringDialog);
      }
    }
    setState(() {
      if (view == "send" && filter1 == "Fecha") {
        dateSends = result;
      }

      if (view == "send" && filter1 == "Empresa") {
        factoryName = result;
      }
      if (view == "factory") {
        campSearchFactory = resulFactories;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    double mWidth = MediaQuery.of(context).size.width;
    double mHeiht = MediaQuery.of(context).size.height;

    String view = widget.tView;
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
    }

    if (controllerSearchFactory.text == "") {
      if (view == 'factory')
        resulFactories = factories;
    }

    if (controllerSearchSend.text == "") {
      if (view == "send" && factoryFilter == "Empresa") {
        result = factoryName;
      }
      else {
        result = dateSends;
      }
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
 
    return Scaffold(
         body: Align(
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
                                    controllerSearchFactory.clear();
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
                                               factoryFilter=value.toString();
                                               filterFactory = value.toString();
                                               selectCamp=value.toString();

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
                                            controller: controllerSearchFactory,
                                            onChanged: (value) =>_runFilter(view, value, textFilterFactory, factoryFilter, factoryName),
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
                                                sendFilter,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              items: filterList.map((String itemSend) =>
                                                  DropdownMenuItem<String>(
                                                    value: itemSend,
                                                    child: Text(
                                                      itemSend,
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                    ),
                                                  ))
                                                  .toList(),
                                              value:selectedSend,
                                              onChanged: (String? value1) {
                                                setState(() {

                                                  selectedSend = value1;
                                                  factoryFilter = value1.toString();
                                                  sendFilter= value1.toString();
                                                  selectCamp=value1.toString();
                                                  typefilter=sendFilter.toString();

                                                  factoryName.clear();
                                                  for(int i = 0; i <factories.length; i++)
                                                    factoryName.add(factories[i].name);
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
                                            onChanged: (value) => _runFilter(view, value, textFilterFactory, sendFilter, factoryName),
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
                                          onTap: () {
                                            setState(() {
                                              select = index;
                                            });
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
                                            color: index == cardSeleted
                                                ? Colors.white
                                                : Colors.grey),
                                        onTap: () {
                                          setState(() {
                                            cardSeleted = index;
                                            select = index;

                                          });
                                        },
                                      );
                                    },
                                  )
                                      : ListView.builder(
                                    itemCount: result.length,
                                    itemBuilder: (context, index) {
                                      int nSend =index + 1;
                                      String send ="Envio $nSend";
                                      return  GestureDetector(
                                        child: defaultCard(
                                            title: selectedSend=="Empresa"
                                                   ? result[index]
                                                   : send ,
                                            description: selectedSend=="Empresa"
                                                ? ""
                                                : line[index].showFormatDate(result[index]),
                                            color: index == cardSeleted
                                                ? Colors.white
                                                : Colors.grey
                                            ),
                                        onTap: (){
                                          setState(() {
                                            sendsDay.clear();
                                            cardSeleted = index;
                                            select = index;
                                            selectCamp=result[select];

                                            if(selectedFilterSend== "Fecha")
                                            {
                                              selectCamp="";
                                              selectCamp=dateSends[index];
                                            }
                                            if(selectedFilterSend == "Empresa")
                                            {
                                              for(int i = 0; i < line.length ; i++)
                                              {
                                                if(selectCamp == line[i].factory)
                                                {
                                                  sendsDay.add(line[i]);
                                                }
                                              }
                                            }

                                          });
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
                      : newSend(selectCamp, filterFactory, sendFilter,select)

              ),
            ],
          )),
    );
  }

}