import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:desktop_app/Widgets/table.dart';
import 'package:flutter/material.dart';


class newSend extends StatefulWidget {

  int select;

  newSend(this.select);

  @override
  State<newSend> createState() => _newSendState();
}



class _newSendState extends State<newSend> {

  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();

  double widthBar = 10.0;

  late TextEditingController controllerData;

  List<String> cColumns = [];
  int rows = 0;
  List<bool>selectable = [];

  @override
  Widget build(BuildContext context) {

    controllerData = new TextEditingController();

    int select = widget.select;

    String title ="" ;
    String dataSend = controllerData.text;
    bool viewButoons = false;

    if(select == -1)
    {
      title = "Nuevo ";
      viewButoons = true;
    }
    else
    {
      controllerData.text = "Edit";
      title = "Ver ";
      viewButoons = false;
    }

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
                height: 588,
                width: 848,
                child: Align(
                  alignment: Alignment.topLeft,
                  child:  Padding(
                    padding: const EdgeInsets.only(left: 30.0,top: 30.0),
                    child: Column(
                      children: [
                         Row(
                          children: [
                            Text('$title Envio: ',
                              style: const TextStyle(fontWeight: FontWeight.bold),),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top:20.0),
                          child: Row(
                            children: [
                              Text('Fecha: '),
                              SizedBox(
                                width: 300,
                                height: 40,
                                child: TextField(
                                  controller: controllerData,
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
                            padding: const EdgeInsets.only(top: 40.0,left: 10.0),
                            child: table(
                              cColumns = ['Empresa', 'Observaciones', 'Estado','Seleccionar'],
                              rows = 8,
                              selectable=viewButoons==true
                                        ? List.generate(rows, (index) => false)
                                        : [],
                            ),
                          ),

                       if(viewButoons == true)
                        Padding(
                          padding: const EdgeInsets.only( top: 70.0, left: 550.0),
                          child: Container(
                            width: 200,
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




