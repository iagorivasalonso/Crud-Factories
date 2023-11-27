import 'package:desktop_app/Frontend/send.dart';
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

  List<lineSend> line=[];
  List<String> datesSends;

  view(this.mWidth, this.mHeight, this.tView, this.factories, this.mails, this.line, this.datesSends);

  @override
  State<view> createState() => _viewState();
}

class _viewState extends State<view> {

  List<String> opSearch = ['Todos', 'Filtrar'];
  List<String> filterList = ['uno', 'dos'];

  int opSelected = 0;
  int select = 0;
  String selectDate=" ";
  int cardSeleted = 0;
  List<lineSend> sendsDay =[];


  @override
  Widget build(BuildContext context) {
    double mWidth = widget.mWidth;
    double mHeight = widget.mHeight;
    String view = widget.tView;

    List<Factory> factories = widget.factories;
    List<Mail> mails = widget.mails;
    List<lineSend> line =widget.line;
    List<String> datesSends =widget.datesSends;


    double mWidthList = mWidth * 0.2;


    if(mWidthList < 42.0)
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

    double mWidthPanel = mWidth - mWidthList;

    double mHeightfilter = 0;
    double mHeightList = 0;
    double mHeightbutton = 0;

    if (mHeight > 190) {
      mHeightbutton = 40;
      mHeightList = mHeight - mHeightbutton;
    } else {
      mHeightbutton = 0;
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
                  child: view == 'factory'
                      ? Container(
                          decoration: const BoxDecoration(
                              border: Border(right: BorderSide(width: 5, color: Colors.grey))),
                          child: Column(
                            children: [
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(opSearch[index],
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: index == opSelected
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis),
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

                              if (opSelected == 1)
                                filterPanel(
                                  mHeightfilter = 150,
                                  filterList = ['uno', 'dos'],
                                ),

                              Container(
                                color: Colors.cyan,
                                height: mHeightList-mHeightfilter,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: factories.length,
                                        itemBuilder: (context, index) {
                                          var address = factories[index].address['street'];
                                          var number = factories[index].address['number'];
                                          String allAddress ='$address, $number';
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 3.0,
                                                right: 9.0,
                                                top: 3.0),
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
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : view == 'email'
                          ? Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    color: Colors.grey,
                                    child: ListView.builder(
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
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                    children: [
                      Row(
                        children: [
                          for(int indexFilter = 0; indexFilter < 2; indexFilter++)
                            Expanded(
                              child: GestureDetector(
                                child: Container(
                                  height:mHeightbutton,
                                  color: indexFilter==opSelected
                                      ? Colors.lightGreen
                                      : Colors.white,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(opSearch[indexFilter],
                                          style: TextStyle(fontWeight: FontWeight.bold,
                                            color: indexFilter==opSelected
                                                ? Colors.white
                                                : Colors.black,),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                ),
                                onTap: (){
                                  setState(() {
                                    opSelected=indexFilter;

                                  });
                                },
                              ),
                            ),
                        ],
                      ),
                      if(opSelected==1)
                        filterPanel(
                          mHeightfilter = 150,
                          filterList =['uno', 'dos'],
                        ),
                      Container(
                        color: Colors.grey,
                        height: mHeightList-mHeightfilter,
                        child: Row(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: datesSends.length,
                                itemBuilder: (context,index){
                                  int nSend =index + 1;
                                  String send ="Envio $nSend";
                                  return GestureDetector(
                                    child: defaultCard(
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

                                        String sendSelect=datesSends[index];
                                        selectDate=sendSelect;

                                        for(int i = 0; i < line.length ; i++)
                                        {
                                          if(sendSelect == line[i].date)
                                          {
                                            sendsDay.add(line[i]);
                                          }

                                        }
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),

              SizedBox(
                  width: mWidthPanel,
                  height: mHeight,
                  child: view == 'factory'
                      ? newFactory(factories,select)
                      : view == 'email'
                          ? newMail(mails,select)
                          : newSend(sendsDay,select,selectDate)
              ),
            ],
          )),
    );
  }
}
