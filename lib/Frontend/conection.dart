import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:flutter/material.dart';

import '../Backend/selection_view.dart';
import 'importData.dart';
import 'navigation_screen.dart';

class conection extends StatefulWidget {

List<String> itens;

conection(this.itens);

  @override
  State<conection> createState() => _conectionState();
}

class _conectionState extends State<conection> {


  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();

  double widthBar = 10.0;


  List <String> items=[];


  @override
  Widget build(BuildContext context) {

    items = widget.itens;
   int itenSelect = 1;
   int subIten1Select = 3;
   int subIten2Select = 1;
   double mWidth = 0;
   double mHeight = 0;

    return AdaptiveScrollbar(
      controller: verticalScroll,
      width: widthBar,
      child: AdaptiveScrollbar(
        controller: horizontalScroll,
        width: widthBar,
        position: ScrollbarPosition.bottom,
        underSpacing: EdgeInsets.only(bottom: 8),
        child: SingleChildScrollView(
          controller: verticalScroll,
          scrollDirection: Axis.vertical,
          child: Container(
            width: 2000,
            child: SingleChildScrollView(
              controller: horizontalScroll,
              scrollDirection: Axis.horizontal,
              child: Container(
                height: 418,
                width: 723,
                child: Align(
                  alignment: Alignment.topLeft,
                  child:  Padding(
                    padding: const EdgeInsets.only(left: 30.0,top: 30.0),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Text('Conexion base de datos: ',
                              style: TextStyle(fontWeight: FontWeight.bold),),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top:20.0, bottom: 30.0,left: 20.0),
                          child: Row(
                            children: [
                              Text('Ip: '),
                              SizedBox(
                                width: 170,
                                height: 40,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),

                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 170.0),
                                child: Text('Puerto: '),
                              ),
                              SizedBox(
                                width: 100,
                                height: 40,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),

                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top:20.0, bottom: 30.0,left: 20.0),
                          child: Row(
                            children: [
                              Text('Base de datos: '),
                              SizedBox(
                                width: 170,
                                height: 40,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),

                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top:20.0, bottom: 30.0,left: 20.0),
                          child: Row(
                            children: [
                              Text('Usuario: '),
                              SizedBox(
                                width: 170,
                                height: 40,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),

                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 170.0),
                                child: Text('Contraseña: '),
                              ),
                              SizedBox(
                                width: 170,
                                height: 40,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),

                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 550.0,right: 30.0,top:40.0),
                              child: ElevatedButton(
                                child: Text(items[3]),
                                onPressed: (){
                                       setState(() {
                                           items[3] = "Desconectar";
                                           Navigator.push(
                                             context,
                                             MaterialPageRoute(
                                               builder: (context) =>
                                                 NavigationScreen(),
                                             ),
                                           );

                                           //;
                                       });
                                },
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );


  }
}