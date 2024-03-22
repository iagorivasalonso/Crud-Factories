import 'dart:io';

import 'package:crud_factories/Backend/importFactories.dart';
import 'package:crud_factories/Backend/importMails.dart';
import 'package:flutter/material.dart';
import '../Backend/_selection_view.dart';
import '../Alertdialogs/closeApp.dart';
import '../Backend/importLines.dart';
import '../Objects/Factory.dart';
import '../Objects/Mail.dart';
import '../Objects/lineSend.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}


class _NavigationScreenState extends State<NavigationScreen> {


  //List Menu Item
  List<String> itens = ['Archivo', 'Listas','Enviar Emails', 'Conectar'];
  List<String> N1itens1 = ['Nuevo','Importar','Salir' ];
  List<String> N2itens1 = ['Empresa', 'Email', 'Envio'];
  List<String> N1itens2 = ['Empresas', 'Emails', 'Envios'];
   late File file;
  List<String> N1itens = [];
  List<String> N2itens = [];
  int itenSelection = 1;
  int subIten1Selection = 1;
  int subIten2Selection = -1;
  int itenSelect = -1;
  int subIten1Select = -1;
  int subIten2Select = -1;
  int itenSelectable = -1;
  int subIten1Selectable = -1;
  List<String> allcontatcs=[];
  var psmenu = const EdgeInsets.only(top: 0, left: 0, right: 0);
  Color cBackground = Colors.blue;
  Color cSelect = Colors.green;
  double posMenu = 0;
  List<String> fileContent =[];
  List<Factory> factories = [];
  List<Mail> mails =[];
  List<lineSend> line = [];

  @override
  Widget build(BuildContext context) {

    double mHeightBar = 0;
    double mHeightContent = 0;


    double mWidth = MediaQuery.of(context).size.width;
    double mHeight = MediaQuery.of(context).size.height;


/*
    print(mHeight);
    print(mWidth);
*/
    if(mHeight>40)
    {
      mHeightBar = 40;
      mHeightContent = mHeight - mHeightBar;
    }
    else
    {
      mHeightBar = mHeight * 0.9;
      mHeightContent = mHeight * 0.1;
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
              child: itenSelection == -1 || itenSelection == 2 || itenSelection == 3
                  ? SizedBox(
                width: mWidth,
                child: buildMenu(mWidth, mHeightContent, mHeightBar),
              )
                  : SizedBox(
                height: mHeightBar,
                child: buildMenu(mWidth, mHeightContent, mHeightBar),
              )),
          if (itenSelection > -1 && itenSelection < 2)
            Align(
              alignment: Alignment.topLeft,
              child: MouseRegion(
                child: SizedBox(
                  child: Padding(
                    padding: itenSelection == 0
                        ?  psmenu = const EdgeInsets.only(left: 0)
                        :  psmenu = const EdgeInsets.only(left: 75),
                    child: SizedBox(
                      child: Row(
                        children: [
                          MouseRegion(
                            child: SafeArea(
                                child: Column(
                                  children: [
                                    for (int index1 = 0; index1 < N1itens.length; index1++)
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: MouseRegion(
                                          onHover: (s) {
                                            setState(() {
                                              subIten1Selection = index1;

                                              if(itenSelection == 0 && subIten1Selection == 0)
                                              {
                                                N2itens=N2itens1;
                                                itenSelectable = itenSelection;
                                                subIten1Selectable = subIten1Selection;
                                              }

                                            });
                                          },
                                          child: GestureDetector(
                                            child: Container(
                                                width: 100,
                                                height: 40,
                                                color: subIten1Selection == index1
                                                    ? cSelect
                                                    : cBackground,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(12.0),
                                                  child:Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(N1itens[index1]),
                                                      index1==0 && itenSelection == 0
                                                          ? const Text(">")
                                                          : const Text(""),

                                                    ],
                                                  ),
                                                )
                                            ),
                                            onTap: () async {


                                                if(itenSelection == 0 && subIten1Selection ==2)
                                                {
                                                  closeAlert(context);

                                                }
                                                if(itenSelection == 1)
                                                {

                                                  switch(subIten1Selection) {
                                                    case 0:

                                                      factories.clear();

                                                      try {

                                                        factories.add(importFactory(fileContent, factories));

                                                      } catch (Exeption) {

                                                      }
                                                      break;

                                                       case 1:
                                                               mails.clear();
                                                               try {

                                                                   mails.add(importMail(fileContent, mails));

                                                              } catch (Exeption) {

                                                              }

                                                       break;

                                                    case 2:
                                                              line.clear();
                                                              try {

                                                                  line.add(importLines(fileContent,line));

                                                              } catch (Exeption) {

                                                              }

                                                      break;
                                                      }
                                                  }
                                                
                                                  itenSelect = itenSelection;
                                                  subIten1Select = subIten1Selection;
                                                  subIten2Select = subIten2Selection;
                                                  itenSelection = -1;
                                                  subIten1Selection = -1;
                                                }



                                          ),

                                        ),
                                      ),
                                  ],
                                )),
                            onExit: (s){
                              setState(() {

                                itenSelection = -1;
                                subIten1Selection = -1;


                              });
                            },
                          ),
                          if (itenSelection==itenSelectable && subIten1Selection==subIten1Selectable)
                            SafeArea(
                                child: Column(
                                  children: [
                                    for (int index2 = 0; index2 < N2itens.length; index2++)
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: MouseRegion(
                                          onHover: (s) {
                                            setState(() {
                                              subIten2Selection = index2;
                                              itenSelection = itenSelectable;
                                              subIten1Selection = subIten1Selectable;

                                            });
                                          },
                                          child: GestureDetector(
                                            child: Container(
                                                width: 100,
                                                height: 40,
                                                color: subIten2Selection == index2
                                                    ? cSelect
                                                    : cBackground,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(12.0),
                                                  child: Text(N2itens[index2]),
                                                )
                                            ),
                                            onTap: (){
                                              setState(() {

                                                if(itenSelection == 0 && subIten1Selection ==3)
                                                {
                                                  closeAlert(context);


                                                } else {
                                                  itenSelect = itenSelection;
                                                  subIten1Select = subIten1Selection;
                                                  subIten2Select = subIten2Selection;
                                                  itenSelection = -1;
                                                  subIten1Selection = -1;
                                                }
                                              });
                                            },

                                          ),
                                          onExit: (s){
                                            setState(() {
                                              itenSelection = -1;
                                              subIten1Selection = -1;
                                            });
                                          },
                                        ),
                                      ),
                                  ],
                                )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Column buildMenu(double mWidth, double mHeight, double mHeightBar) {

    return Column(
      children: [
        Container(
          color: cBackground,
          width: mWidth,
          height: mHeightBar,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: itens.length,
              itemBuilder: (BuildContext context, index) {
                return MouseRegion(
                  onHover: (s) {
                    setState(() {
                      itenSelection = index;
                      index == 0
                          ?  N1itens = N1itens1
                          :  N1itens = N1itens2;
                    });
                  },
                  child: GestureDetector(
                    child: Container(
                        width: index == 2 || index == 3
                            ? 110
                            : 75,
                        color: itenSelection == index ? cSelect : cBackground,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Center(child: Text(itens[index])),
                        )
                    ),
                    onTap: (){
                      setState(() async {

                        if (itenSelection == 2 || itenSelection == 3)
                          itenSelect = itenSelection;
                      });
                    },

                  ),
                  onExit: (s) {
                    setState(() {
                      if (itenSelection == 3)
                        itenSelection = -1;
                    });
                  },
                );
              }),
        ),

        StreamBuilder<Object>(
            stream: null,
            builder: (context, snapshot) {
              return Container(
                width: mWidth,
                height: mHeight,
                color: Colors.white,
                child: mHeight> 18
                    ? FuntionSeleted(itenSelect, subIten1Select, subIten2Select,mWidth, mHeight,itens,factories,mails,line)
                    : Container(
                  color: Colors.white,
                ),

              );
            }),
      ],
    );
  }
}



