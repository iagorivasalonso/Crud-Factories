import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:desktop_app/Widgets/table.dart';
import 'package:flutter/material.dart';

import '../Objects/lineSend.dart';


class newSend extends StatefulWidget {

  List<lineSend> sendsLine;
  int select;
  String selectCamp;
  String filter;



  newSend(this.sendsLine,this.select,this.selectCamp, this.filter);

  @override
  State<newSend> createState() => _newSendState();
}



class _newSendState extends State<newSend> {

  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();
  final ScrollController verticalScrollTable = ScrollController();

  double widthBar = 10.0;

  late TextEditingController controllerText;

  List<String> columns = [];
  List<String> campsTable = [];
  int rows = 0;
  int rowsTable = 0;
  List<bool>selectable = [];
  List <bool> selectTable = [];
  List<lineSend> sends = [];
  List<lineSend> listSend = [];


  List<bool> Send= List.generate(88, (index) => false);

  @override
  Widget build(BuildContext context) {

    List<TextEditingController> _controllersObserLine =[];
    for (int i = 1; i < 75; i++) _controllersObserLine.add(TextEditingController());
    controllerText = new TextEditingController();

    int select = widget.select;
    String selectedCamp = widget.selectCamp;
    String filter = widget.filter;
    int cant = 0;
    String stringFactories = "";
    String title ="" ;
    String type ="";


    bool viewButoons = false;


    if(select == -1)
    {
      title = "Nuevo ";
      campsTable = ['Empresa', 'Observaciones', 'Estado' ,'Seleccionar'];
      listSend = widget.sendsLine;
      cant = listSend.length;
      stringFactories = "Tiene $cant empresas en su base de datos";
      viewButoons = true;
    }
    else
    {
      controllerText.text = selectedCamp;
      title = "Ver ";

      if(filter== 'Por fecha')
      {
        type = "Fecha:  ";
        controllerText.text =' ';
        campsTable = ['Empresa', 'Observaciones', 'Estado'];
        listSend = widget.sendsLine;
      }
      else
      {
        type = "Empresa:  ";
        campsTable = ['Fecha', 'Observaciones', 'Estado'];
        listSend = widget.sendsLine;
      }


      cant = listSend.length;
      stringFactories = "A esta empresa se le hicieron $cant envios";
      viewButoons = false;

    }
    bool selectable = true;
    int endTable = 0;

    if(selectable == true)
    {
      endTable = campsTable.length;
    }
    else
    {
      endTable = campsTable.length-1;
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
                              Text(type),
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
                            child:Scrollbar(
                              controller: verticalScrollTable,
                              child: Container(
                                height: 250,
                                child: SingleChildScrollView(
                                  controller: verticalScrollTable,
                                  scrollDirection: Axis.vertical,
                                  child: DataTable(
                                    columns: <DataColumn>[
                                      for(int i=0 ; i < endTable; i++)
                                        DataColumn(
                                          label: SizedBox(
                                              width: 110,
                                              child: Text(campsTable[i])
                                          ),
                                        ),

                                    ],
                                    rows: List<DataRow>.generate(listSend.length,
                                          (int index) =>  DataRow(
                                          cells: <DataCell>[
                                            for(int i=0 ; i < endTable; i++)
                                              DataCell(
                                                  campsTable[i] == "Empresa"
                                                      ? Text(listSend[index].factory.name)
                                                      : campsTable[i] == "Fecha"
                                                      ? Text(listSend[index].date)
                                                      : campsTable[i] == "Observaciones"
                                                      ? Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: TextField(
                                                      controller: _controllersObserLine[index],
                                                      decoration: InputDecoration(
                                                        border: OutlineInputBorder(),
                                                        labelText:listSend[index].observations,
                                                      ),
                                                    ),
                                                  )
                                                      : campsTable[i] == "Estado"
                                                      ? Text(listSend[index].state)
                                                      : campsTable[i] == "Seleccionar"
                                                      ? CheckboxListTile(
                                                    value: Send[index],
                                                    onChanged:  (bool? value) {
                                                      setState(() {
                                                        Send[index]= value!;
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
                              padding: const EdgeInsets.only(top: 30.0,left: 50.0),
                              child: Text(stringFactories),
                            ),
                          ],
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
                                  onPressed: () {
                                    setState(() {

                                      for(int i = 0 ; i <listSend.length; i++) {

                                        String factory = listSend[i].factory.name;
                                        String observations = listSend[i].observations;
                                        String state = listSend[i].state;
                                        bool select = Send[i];

                                        print('\nEmpresa: $factory \nObservations: $observations \nEstado: $state \nselect: $select');
                                      }

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


}




