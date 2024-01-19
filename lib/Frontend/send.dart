import 'dart:io';

import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import '../Objects/lineSend.dart';


class newSend extends StatefulWidget {

  List<lineSend> sendsLine;
  int select;
  String selectCamp;
  String filter;
  List<lineSend> line;
  String SeletedFilter;
  List<String> dateSends;


  newSend(this.dateSends,this.sendsLine,this.select,this.selectCamp, this.filter,  this.line, this.SeletedFilter);

  @override
  State<newSend> createState() => _newSendState();
}



class _newSendState extends State<newSend> {

  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();
  final ScrollController verticalScrollTable = ScrollController();

  double widthBar = 10.0;

  late TextEditingController controllerText = new TextEditingController();
  List<TextEditingController> _controllersObserLine = [];
  List<String> columns = [];
  List<String> campsTable = [];
  int rows = 0;
  int rowsTable = 0;
  List<bool>selectable = [];
  List <bool> selectTable = [];
  List<lineSend> sends = [];
  List<lineSend> listSend = [];


  List<bool> Send = List.generate(88, (index) => false);

  @override
  Widget build(BuildContext context) {



    for (int i = 1; i < 75; i++)
      _controllersObserLine.add(TextEditingController());


    int select = widget.select;
    String selectCamp = widget.selectCamp;
    String filter = widget.filter;
    List<lineSend> line = widget.line;
    int cant = 0;
    String stringFactories = "";
    String title = "";
    String typeList="";
    String type = widget.SeletedFilter;

    campsTable = ['Empresa', 'Observaciones', 'Estado', 'Seleccionar'];


    bool viewButoons = false;


    if (select == -1) {
      title = "Nuevo ";
      typeList = "empresas: ";
      type = "Fecha ";
      campsTable = ['Empresa', 'Observaciones', 'Estado', 'Seleccionar'];
      listSend = widget.sendsLine;
      cant = listSend.length;
      stringFactories = "Tiene $cant empresas en su base de datos";
      viewButoons = true;
    }
    else {
      controllerText.text = "";


      title = "Ver ";

      if(type== "Fecha")
      {
        type = "Fecha:  ";
        campsTable = ['Empresa', 'Observaciones', 'Estado'];
        listSend = widget.sendsLine;
        type =widget.SeletedFilter;
        controllerText.text = widget.dateSends[select];
        typeList = "empresas: ";

        cant= 0;
        listSend.clear();
        for(int i = 0; i < line.length ; i++)
        {
          if(controllerText.text  == line[i].date)
          {
            listSend.add(line[i]);
            cant+=1;
          }

        }

        stringFactories = "Este dia se hicieron $cant envios";
      }


      if(type == "Empresa")
      {
        type = "Empresa:  ";
        campsTable = ['Fecha', 'Observaciones', 'Estado'];
        listSend = widget.sendsLine;
        controllerText.text = line[select].factory;
        typeList = "envios: ";


        cant= 0;
        listSend.clear();

        stringFactories = "A esta empresa se le hicieron $cant envios";
      }


      viewButoons = false;
    }
    bool selectable = true;
    int endTable = 0;

    if (selectable == true) {
      endTable = campsTable.length;
    }
    else {
      endTable = campsTable.length - 1;
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
                height: 630,
                width: 848,
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30.0, top: 30.0),
                      child: Column(
                          children: [
                            Row(
                              children: [
                                Text('$title Envio: ',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text('$type:  '),
                                  ),
                                  SizedBox(
                                    width: 300,
                                    height: 40,
                                    child: TextField(
                                      controller: controllerText,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 40.0),
                              child: Row(
                                children: [
                                  Text('Lista de $typeList',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 40.0, left: 10.0),
                              child: Scrollbar(
                                controller: verticalScrollTable,
                                child: Container(
                                  height: 250,
                                  child: SingleChildScrollView(
                                    controller: verticalScrollTable,
                                    scrollDirection: Axis.vertical,
                                    child: DataTable(
                                      columns: <DataColumn>[
                                        for(int i = 0; i < endTable; i++)
                                          DataColumn(
                                            label: SizedBox(
                                                width: 110,
                                                child: Text(campsTable[i])
                                            ),
                                          ),

                                      ],
                                      rows: List<DataRow>.generate(
                                        listSend.length,
                                            (int index) =>
                                            DataRow(
                                                cells: <DataCell>[
                                                  for(int i = 0; i <
                                                      endTable; i++)
                                                    DataCell(
                                                      campsTable[i] == "Empresa"
                                                          ? Text(listSend[index]
                                                          .factory)
                                                          : campsTable[i] ==
                                                          "Fecha"
                                                          ? Text(
                                                          listSend[index].date)
                                                          : campsTable[i] ==
                                                          "Observaciones"
                                                          ? Padding(
                                                        padding: const EdgeInsets
                                                            .all(8.0),
                                                        child: TextField(
                                                          controller: _controllersObserLine[index],
                                                          decoration: InputDecoration(
                                                            border: OutlineInputBorder(),
                                                            labelText: listSend[index]
                                                                .observations,
                                                          ),
                                                        ),
                                                      )
                                                          : campsTable[i] ==
                                                          "Estado"
                                                          ? Text(
                                                          listSend[index].state)
                                                          : campsTable[i] ==
                                                          "Seleccionar"
                                                          ? CheckboxListTile(
                                                        value: Send[index],
                                                        onChanged: (
                                                            bool? value) {
                                                          setState(() {
                                                            Send[index] = value!;
                                                          });
                                                        },)
                                                          : Text("Otro"),
                                                    ),
                                                ]
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 30.0, left: 50.0),
                                  child: Text(stringFactories),
                                ),
                              ],
                            ),
                            if(viewButoons == true)
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 70.0, left: 550.0),
                                child: Container(
                                  width: 200,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        child: const Text('Nuevo'),
                                        onPressed: () {
                                          setState(() {



                                               String date ='19 de enero del 2024';


                                               for(int i = 0 ; i <4; i++) {

                                                 String factory = listSend[i].factory;
                                                 String observations = listSend[i].observations;
                                                 String state = listSend[i].state;
                                                 bool select = Send[i];

                                                 listSend.add(lineSend(date: date,
                                                     factory: factory,
                                                     observations: observations,
                                                     state: state));

                                               }


                                            csvExportator(listSend);
                                          });
                                        },
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
  csvExportator(List<lineSend> listSend) async {

    File myFile = File('D:/lineSends.csv');

    List<dynamic> associateList = [

      for (int i = 0; i <listSend.length;i++)
        {

          "date": listSend[i].date,
          "factory": listSend[i].factory,
          "observations": listSend[i].observations,
          "state": listSend[i].state

        },
    ];

    List<List<dynamic>> rows = [];
    List<dynamic> row = [];


    for (int i = 0; i < associateList.length; i++) {
      List<dynamic> row = [];
      row.add(associateList[i]["date"]);
      row.add(associateList[i]["factory"]);
      row.add(associateList[i]["observations"]);
      row.add(associateList[i]["state"]);
      rows.add(row);
     
    }

    String csv = const ListToCsvConverter().convert(rows);
    print(csv);
    myFile.writeAsString(csv);


  }

}