import 'package:crud_factories/Frontend/send.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../Alertdialogs/noFind.dart';
import '../Objects/Factory.dart';
import '../Objects/Mail.dart';
import '../Objects/lineSend.dart';
import '../Widgets/defaultCard.dart';
import '../Widgets/factoryCard.dart';
import 'mail.dart';
import 'factory.dart';

class view extends StatefulWidget {
  double mWidth;
  double mHeight;
  String tView;

  List<Factory> factories;
  List<Mail> mails;
  List<String> datesSends;
  List<lineSend> line = [];

  view(this.mWidth, this.mHeight, this.tView, this.factories, this.mails,
      this.datesSends, this.line);

  @override
  State<view> createState() => _viewState();
}

 @override
class _viewState extends State<view> {

  List<String> opSearch = ['Todos','Filtrar'];
  List<String> filterList = [];
  List<String> filterListSends = ['Fecha','Empresa'];
  List<String> filterListFactories = ['Nombre','Dirrección','Telefono','Ciudad'];

  int opSelected = 0;
  int select = 0;
  String selectCamp = " ";
  int cardSeleted = 0;
  List<lineSend> sendsDay = [];
  String textFilterFactory=' ';
  List<String> datesSends =[];
  List<String> campSearch =[];
  List<Factory> campSearchFactory =[];
  List<Factory> factories =[];
  List<Factory> resulFactories = [];
  String textFilterSend ="";
  List<String> result = [];
  List<String> factoryName = [];
  String? selectedFilterSend ='Fecha';
  String typefilter="";
  String? selectedFactory;
  String? selectedSend;
  String factoryFilter ='Nombre';
  String sendFilter ='Fecha';
  String  filterFactory='Nombre';


  String campfilter =" ";

   TextEditingController controllerSearchFactory = new TextEditingController();
   TextEditingController controllerSearchSend = new TextEditingController();


  void _runFilter(String view,String enteredKeyboard, String filter,String filter1, List<String> factoryName){


        if(filter1=="Nombre")
        {
             filterFactory="Nombre";
        }

         if(filter1=="")
         {
           filter1="Fecha";
         }

    if(enteredKeyboard.isEmpty)
    {
         if(view == "send" && filter1=="Fecha")
         {
           result = datesSends;
         }

         if(view == "send" && filter1=="Empresa")
         {

           result = factoryName;
         }
         if(view ==  'factory')
         {
           resulFactories = factories;
         }
    }
    else
    {

      if(filter1=="Fecha")
      {
        result = datesSends.where((item) =>
            item.toLowerCase().contains(enteredKeyboard.toLowerCase())).toList();

      }

      if(filter1=="Empresa")
      {

        result = factoryName.where((item) =>
            item.toLowerCase().contains(enteredKeyboard.toLowerCase())).toList();
      }

      if(view == "factory")
      {
        switch(filter1)
        {
          case "Nombre":
            resulFactories = factories.where((element) =>
                element.name.toLowerCase().contains(enteredKeyboard.toLowerCase())).toList();
            break;

          case "Dirrección":

            resulFactories = factories.where((element) =>
                element.allAdress().toLowerCase().contains(enteredKeyboard.toLowerCase())).toList();
            break;

          case "Telefono":
            resulFactories = factories.where((element) =>
                element.thelephones[0].toLowerCase().contains(enteredKeyboard.toLowerCase())).toList();
            break;

          case "Ciudad":
            resulFactories = factories.where((element)=>
                element.address['city']!.toLowerCase().contains(enteredKeyboard.toLowerCase())).toList();
            break;


        }

      }

      String strindDialog ='';
      bool noDat = false;
      var noDatfunction;

      if(result.length == 0)
      {


        if(filter1=="Fecha")
        {
          strindDialog = 'No se encuentra la fecha en nuestra base de datos';
          noDat =true;
          noDatfunction= noFind(context,noDat,strindDialog) ;
        }

        if(filter1=="Empresa")
        {
          strindDialog = 'Esa empresa no pertenece a nuestra base de datos';
          noDat =true;
          noDatfunction= noFind(context,noDat,strindDialog);
        }
      }
      if(resulFactories.length==0)
      {

        filter1 = filter1.toLowerCase();

        if(filter1 == "nombre" || filter1 == "telefono")
        {
          filter1 = 'El $filter1';
        }

        if(filter1 == "dirrección" || filter1 == "ciudad")
        {
          filter1 = 'La $filter1';
        }

        strindDialog = '$filter1 no pertenece a nuestra base de datos';
        noDat =true;
        noDatfunction= noFind(context,noDat,strindDialog);
      }
    }
   setState(() {
     if(view == "send" && filter1=="Fecha")
     {
        datesSends = result;
     }

     if(view =="send" && filter1=="Empresa")
     {
       factoryName = result;
     }
     if(view == "factory")
     {
       campSearchFactory = resulFactories;
     }
   });
  }

  @override
  Widget build(BuildContext context) {
    double mWidth = widget.mWidth;
    double mHeight = widget.mHeight;
    String view = widget.tView;
    factories = widget.factories;
    List<Mail> mails = widget.mails;
    List<lineSend> line = widget.line;
    datesSends = widget.datesSends;

    double mWidthList = mWidth * 0.2;

    if (mWidthList < 42.0) opSelected = 0;

    if (mWidth > 280) {
      if (mWidthList < 240) {
        mWidthList = 240;
      } else {
        mWidthList = mWidth * 0.2;
      }
    } else {
      mWidthList = mWidth * 0.8;
    }


    if(view == "factory")
    {

      filterList = filterListFactories;
    }

    if(view == "send")
    {
      filterList = filterListSends;
    }

    if(controllerSearchFactory.text=="")
    {
      if(view== 'factory' )
        resulFactories=factories;
    }

    if(controllerSearchSend.text=="")
    {


      if(view =="send" && factoryFilter=="Empresa")
      {
         result = factoryName;

      }
      else
      {
        result = datesSends;
      }

    }


    double mWidthPanel = mWidth - mWidthList;

    double mHeightfilter = 150;
    double mHeightList = 0;
    double mHeightbutton = 0;

    if (mHeight > 190) {
      mHeightbutton = 40;
      mHeightList = mHeight - mHeightbutton;
    } else {
      mHeightbutton = 0;
      mHeightList = mHeight;
    }

    if(view=="mail")
    {
      mHeightList = mHeight;
    }
    return Scaffold(
      body: Align(
          alignment: Alignment.topLeft,
          child: Row(
            children: [
              SizedBox(
                  width: mWidthList,
                  height: mHeight,
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            right: BorderSide(width: 5, color: Colors.grey))),
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
                                          padding: EdgeInsets.only(
                                              top: 15.0, left: 40.0, right: 40.0),
                                          child:  TextField(
                                            controller: controllerSearchFactory,
                                            onChanged: (value) =>_runFilter(view, value, textFilterFactory, factoryFilter, factoryName),
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
                          height: opSelected == 0
                              ? mHeightList
                              : opSelected == 1
                              ? mHeightList-mHeightfilter
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
                                        child: selectedFilterSend == 'Fecha'
                                            ? defaultCard(
                                            title: send,
                                            description: result[index],
                                            color: index == cardSeleted
                                                ? Colors.white
                                                : Colors.grey
                                        )
                                            : defaultCard(
                                            title: result[index],
                                            description: '',
                                            color: index == cardSeleted
                                                ? Colors.white
                                                : Colors.grey
                                        ),

                                        onTap: (){
                                          setState(() {
                                            sendsDay.clear();
                                            cardSeleted = index;
                                            select = index;

                                            late String campSelect;
                                            if(selectedFilterSend== "Fecha")
                                            {
                                              campSelect=datesSends[index];
                                              selectCamp=campSelect;


                                            }
                                            if(selectedFilterSend == "Empresa")
                                            {
                                              campSelect=factories[index].name;
                                              selectCamp=campSelect;

                                              for(int i = 0; i < line.length ; i++)
                                              {
                                                if(campSelect == line[i].factory.name)
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
                  height: mHeight,
                  child: view == 'factory'
                      ? newFactory(factories, select)
                      : view == 'mail'
                      ? newMail(mails, select)
                      : newSend(sendsDay,select,selectCamp,filterFactory,line,sendFilter)

              ),
            ],
          )),
    );
  }

}
