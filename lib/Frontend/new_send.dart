import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:desktop_app/Widgets/table.dart';
import 'package:flutter/material.dart';


class newSend extends StatefulWidget {

  const newSend({Key? key}) : super(key: key);

  @override
  State<newSend> createState() => _newSendState();
}



class _newSendState extends State<newSend> {

  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();

  double widthBar = 10.0;

  List<String> cColumns = [];
  int rows = 0;
  List<bool>selectable = [];

  @override
  Widget build(BuildContext context) {


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
                height: 570,
                width: 750,
                child: Align(
                  alignment: Alignment.topLeft,
                  child:  Padding(
                    padding: const EdgeInsets.only(left: 30.0,top: 30.0),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Text('Envio: ',
                              style: TextStyle(fontWeight: FontWeight.bold),),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top:20.0),
                          child: Row(
                            children: [
                              Text('Fecha: '),
                              SizedBox(
                                width: 300,
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
                          padding: EdgeInsets.only(top: 40.0),
                          child: Row(
                            children: [
                              Text('Selección de empresas: ',
                                style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 40.0, right: 80.0),
                            child: table(
                              cColumns = ['Empresa', 'Observaciones', 'Estado'],
                              rows = 8,
                              selectable=List.generate(rows, (index) => false),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(top: 70.0, left: 500.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                child: const Text('Nuevo'),
                                onPressed: () {},
                              ),
                              ElevatedButton(
                                child: const Text('Cancelar'),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                  ]
                ),
              )
              ),
            ),
          ),
        ),
    ),
    ),
    );
  }


}




