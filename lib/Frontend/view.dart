import 'package:crud_factories/Frontend/send.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../Objects/Factory.dart';
import '../Objects/Mail.dart';
import '../Objects/lineSend.dart';
import '../Widgets/defaultCard.dart';
import '../Widgets/factoryCard.dart';
import '../Widgets/filterPanel.dart';
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

class _viewState extends State<view> {
  List<String> opSearch = ['Todos', 'Filtrar'];
  List<String> filterList = ['Por fecha', 'Por empresa'];

  int opSelected = 0;
  int select = 0;
  String selectCamp = " ";
  int cardSeleted = 0;
  List<lineSend> sendsDay = [];

  String? selectedFilter;
  String filter = '';

  @override
  Widget build(BuildContext context) {
    double mWidth = widget.mWidth;
    double mHeight = widget.mHeight;
    String view = widget.tView;

    List<Factory> factories = widget.factories;
    List<Mail> mails = widget.mails;
    List<lineSend> line = widget.line;
    List<String> datesSends = widget.datesSends;

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

    if(view=='mail')
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
                                    });
                                  },
                                ),
                              ),
                          ],
                        ),
                        if(view== 'factory' || view =='send')
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
                                        padding: EdgeInsets.only(left: 10.0, right: 5.0),
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
                                            hint: const Text(
                                              'Por fecha',
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            items: filterList
                                                .map((String item) =>
                                                    DropdownMenuItem<String>(
                                                      value: item,
                                                      child: Text(
                                                        item,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ))
                                                .toList(),
                                            value: selectedFilter,
                                            onChanged: (String? value) {
                                              setState(() {
                                               selectedFilter = value;
                                               filter = selectedFilter.toString();

                                              });
                                            },
                                            buttonStyleData:
                                                const ButtonStyleData(
                                              height: 50,
                                              width: 160,
                                              padding: EdgeInsets.only(
                                                  left: 14, right: 14),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 15.0, left: 40.0, right: 40.0),
                                        child: TextField(
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
                                  itemCount: factories.length,
                                  itemBuilder: (context, index) {
                                    var address = factories[index].address['street'];
                                    var number = factories[index].address['number'];
                                    String allAddress = '$address, $number';
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 3.0, right: 9.0, top: 3.0),
                                      child: GestureDetector(
                                        child: factoryCard(
                                            name: factories[index].name,
                                            address: allAddress,
                                            telephone: factories[index].thelephones[0],
                                            city: factories[index].address['city']),
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
                                  itemCount: selectedFilter == 'Por empresa'
                                             ? factories.length
                                             : datesSends.length,
                                  itemBuilder: (context, index) {
                                    int nSend =index + 1;
                                    String send ="Envio $nSend";
                                    return  GestureDetector(
                                      child: selectedFilter == 'Por empresa'
                                          ? defaultCard(
                                          title: factories[index].name,
                                          description: '',
                                          color: index == cardSeleted
                                              ? Colors.white
                                              : Colors.grey
                                        )
                                        : defaultCard(
                                          title: send,
                                          description: datesSends[index],
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
                                         if(selectedFilter == 'Por fecha')
                                         {
                                           campSelect=datesSends[index];
                                           selectCamp=campSelect;
                                           for(int i = 0; i < line.length ; i++)
                                           {
                                             if(campSelect == line[i].date)
                                             {
                                               sendsDay.add(line[i]);
                                             }

                                           }

                                         }
                                         else
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
                          : newSend(sendsDay,select,selectCamp,filter)

              ),
            ],
          )),
    );
  }
}
