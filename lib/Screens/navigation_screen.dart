import 'package:desktop_app/Screens/Primera_Screen.dart';
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
  var psmenu = const EdgeInsets.only(top: 0,left: 0,right: 0);

  Color cBackground = Colors.blue;
  Color cSelect = Colors.green;
  double posMenu=0;
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
            SizedBox(
              width: mWidth,
              height: 40,
              child: Column(
                children: [
                  Container(
                    color: cBackground,
                    width: mWidth,
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
                                    Sitens =Sitens2;
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
                              child: PrimeraScreen(),

                            );
                          }
                      ),

                    ],
                  ),

                ),
                if(itenSelection>-1)
                    SafeArea(
                        child: Column(
                          children: [
                             for (var objeto in Sitens)
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    width: 100,
                                    height: 55,
                                    color: Colors.cyan,
                                    child: Text(objeto)

                                  ),
                                ),

                          ],
                        )
                    ),

              ],
            ),


    );
  }
}
