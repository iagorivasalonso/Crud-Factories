import 'package:desktop_app/Screens/Primera_Screen.dart';
import 'package:desktop_app/Screens/Segunda_Screen.dart';
import 'package:flutter/material.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  //List Menu Item
  List<String> itens = ['Menu 1', 'Menu 2', 'Menu 3', 'Menu 4'];
  List<String> Sitens1 = ['Menu 11', 'Menu 12', 'Menu 13', 'Menu 14'];
  List<String> Sitens2 = ['Menu 21', 'Menu 22'];
  List<String> Sitens3 = ['Menu 31', 'Menu 32', 'Menu 33'];
  List<String> Sitens4 = ['Menu 41'];

  List<String> Sitens = [];
  int itenSelection = -1;
  int subItenSelection = -1;
  int itenSelect = -1;
  int subItenSelect = -1;

  var psmenu = const EdgeInsets.only(top: 0,left: 0,right: 0);
  Color cBackground = Colors.blue;
  Color cSelect = Colors.green;
  double posMenu = 0;


  @override
  Widget build(BuildContext context) {

    double mWidth = MediaQuery.of(context).size.width;
    double mHeight = MediaQuery.of(context).size.height-40;
    /*
    print('ancho $mWidth');
    print('alto $mHeight');
     */
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: itenSelection==-1
                  ?SizedBox(
                        width: mWidth,
                        child: buildMenu(mWidth,mHeight),
                       )
                  :SizedBox(
                        width: mWidth,
                        height: 40,
                        child: buildMenu(mWidth,mHeight),
                       )
            ),
          if(itenSelection>-1)
            Padding(
              padding: psmenu,
              child: SafeArea(
                  child: Column(
                    children: [
                      for (int index1 = 0; index1 < Sitens.length; index1++)
                        Align(
                          alignment: Alignment.topLeft,
                          child: MouseRegion(
                             onHover: (s){
                               setState(() {
                                 subItenSelection = index1;
                               });
                             },
                              child:Container(
                                  width: 100,
                                  height: 40,
                                  color: subItenSelection == index1
                                      ? cSelect
                                      : cBackground,
                                  child: GestureDetector(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(Sitens[index1]),
                                    ),
                                     onTap: (){
                                         setState(() {
                                           itenSelect = itenSelection;
                                           subItenSelect = subItenSelection;
                                           itenSelection = -1;
                                           subItenSelection = -1;
                                           print('menu $itenSelect apartado $subItenSelect');
                                         });

                                     },
                                  )

                              ),

                          ),
                        ),

                    ],
                  )
              ),
            ),

        ],
      ),


    );
  }

  Column buildMenu(double mWidth, double mHeight) {

    return Column(
            children: [
              Container(
                color: cBackground,
                width:mWidth,
                height: 40,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: itens.length,
                    itemBuilder: (BuildContext context, index) {
                      return MouseRegion(
                          onHover: (s) {
                            setState(() {
                              itenSelection=index;
                              if(itenSelection==0)
                              {
                                psmenu = const EdgeInsets.only(left: 0);
                                Sitens =Sitens1;
                              }

                              if(itenSelection==1)
                              {
                                psmenu = const EdgeInsets.only(left: 75);
                                Sitens =Sitens2;
                              }
                              if(itenSelection==2)
                              {
                                psmenu = const EdgeInsets.only(left: 150);
                                Sitens =Sitens3;
                              }

                              if(itenSelection==3)
                              {
                                psmenu = const EdgeInsets.only(left: 225);
                                Sitens =Sitens4;
                              }
                              posMenu=itenSelection*75;
                            });
                          },
                          child: Container(
                              width: 75,
                              color: itenSelection == index
                                  ? cSelect
                                  : cBackground,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(itens[index]),

                              )
                          )
                      );
                    }),
              ),

              StreamBuilder<Object>(
                  stream: null,
                  builder: (context, snapshot) {
                    return Container(
                      width:mWidth,
                      height: mHeight,
                      color: Colors.white,
                      child: _funtionSeleted(itenSelect),

                    );
                  }
              ),

            ],
          );
  }

  _funtionSeleted(int option) {

    if(option==0){
      return PrimeraScreen();
    }else if(option==1){
      return SegundaScreen();
    }

  }
}