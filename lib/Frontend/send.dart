import 'package:crud_factories/Objects/Factory.dart';
import 'package:intl/intl.dart';
import 'package:show_platform_date_picker/show_platform_date_picker.dart';
import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:flutter/material.dart';
import '../Alertdialogs/confirm.dart';
import '../Backend/exportLines.dart';
import '../Objects/lineSend.dart';

class newSend extends StatefulWidget {

  List<lineSend> sendsLine;
  int select;
  String selectCamp;
  String filter;
  List<lineSend> line;
  String SeletedFilter;
  List<String> dateSends;
  List<Factory> factories;

  newSend(this.dateSends,this.sendsLine,this.select,this.selectCamp, this.filter,  this.line, this.SeletedFilter, this.factories);

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
  int rowsType = -1;
  List<bool>selectable = [];
  List <bool> selectTable = [];
  List<lineSend> sends = [];
  List<lineSend> listSend = [];
  String date="";
  bool allSelect = false;
  List<bool> Send = List.generate(75, (index) => false);
  DateTime seletedDate =DateTime.now();
  int rowsTrue=0;

  @override
  Widget build(BuildContext context) {



    for (int i = 1; i < 75; i++)
      _controllersObserLine.add(TextEditingController());


    int select = widget.select;
    List<lineSend> line = widget.line;
    int cant = 0;
    String stringFactories = "";
    String title = "";
    String typeList="";
    String type = widget.SeletedFilter;
    List<Factory> factories = widget.factories;

    campsTable = ['Empresa', 'Observaciones', 'Estado', 'Seleccionar'];


    bool viewButoons = false;


    if (select == -1) {
      title = "Nuevo ";
      typeList = "empresas: ";
      type = "Fecha ";
      campsTable = ['Empresa', 'Observaciones', 'Estado', 'Seleccionar'];
      listSend = widget.sendsLine;
      rowsType =factories.length;

      if(controllerText.text.isEmpty)
      {
        controllerText.text=DateFormat('dd-MM-yyyy').format( DateTime.now());
      }
      rowsTable =factories.length;
      stringFactories = "Tiene $rowsTable empresas en su base de datos";
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
        rowsTable =listSend.length;
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
        rowsType =cant;
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
      endTable = campsTable.length;
    }

    final ShowPlatformDatePicker platformDatePicker = ShowPlatformDatePicker(buildContext: context);

    for(int i = 0; i<Send.length; i++)
    {
      if(Send[i]==false)
      {
        allSelect = false;
      }
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
                                      decoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        icon: select == -1
                                              ? const Icon(Icons.calendar_today)
                                              : null,
                                      ),
                                      onTap: () async {
                                        DateTime? dateSelected = await  platformDatePicker.showPlatformDatePicker(
                                            context,
                                            seletedDate,
                                            DateTime(DateTime.now().year - 10),
                                            DateTime(DateTime.now().year + 1),
                                        );
                                        setState(() {
                                          date =DateFormat('dd-MM-yyyy').format(dateSelected!);
                                          controllerText.text = date;
                                        
                                        });

                                      },
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
                                       rows: List<DataRow>.generate(rowsType,
                                          (int index) =>
                                          DataRow(
                                              cells: <DataCell>[
                                                for(int i = 0; i < endTable; i++)
                                                DataCell(
                                                 campsTable[i] == "Empresa"
                                                    ? select == -1
                                                       ? Text(factories[index].name)
                                                       : Text(listSend[index].factory)
                                                 : campsTable[i] == "Fecha"
                                                     ?  Text(listSend[index].date)
                                                 : campsTable[i] == "Observaciones"
                                                     ? Padding(
                                                         padding: const EdgeInsets.all(8.0),
                                                         child: TextField(
                                                             controller: _controllersObserLine[index],
                                                             decoration: InputDecoration(
                                                               border: OutlineInputBorder(),
                                                               labelText: select == -1
                                                                   ? _controllersObserLine[index].text
                                                                   : listSend[index].observations,
                                                          ),
                                                   ),
                                                 )
                                                : campsTable[i] == "Estado"
                                                     ? select == -1
                                                           ? Text("estado")
                                                           : Text(listSend[index].state)
                                                : campsTable[i] =="Seleccionar"
                                                     ? CheckboxListTile(
                                                          value: Send[index],
                                                            onChanged: (bool? value) {
                                                                 setState(() {

                                                               Send[index] = value!;
                                                               allSelect = true;
                                                          });
                                                         },)
                                                 : Text("data")
                                                ),
                                              ]
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0,left: 60.0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    children: [
                                      Text(stringFactories),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 350.0),
                                        child: Text("Seleccionar todas"),
                                      ),
                                      Checkbox(
                                        value: allSelect,
                                        onChanged: (value) {
                                          setState(() {

                                          for(int i = 0 ; i<Send.length; i++)
                                          {
                                            Send[i] = value!;
                                          }
                                          allSelect = value!;




                                          });
                                        },
                                      )

                                    ],
                                  )
                              ),
                            ),
                            if(viewButoons == true)
                              Padding(
                                padding: const EdgeInsets.only(top: 70.0, left: 550.0),
                                child: SizedBox(
                                  width: 200,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        child: const Text('Nuevo'),
                                        onPressed: () {
                                          setState(() {
                                            List<lineSend> sendSelected = [];
                                            int allLines =0;
                                            for(int i = 0; i < factories.length; i++)
                                            {
                                                if(Send[i] == true)
                                                {
                                                  line.add(lineSend(date: controllerText.text, factory: factories[i].name,  observations: _controllersObserLine[i].text, state:'Preparado'));
                                                  allLines++;
                                                  print(line);
                                                }
                                            }

                                            String action ='El pedido contiene $allLines empresas';
                                            confirm(context,action);

                                           csvExportatorLines(listSend);
                                          });


                                        },
                                      ),
                                      ElevatedButton(
                                        child: const Text('Cancelar'),
                                        onPressed: () {

                                        },
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

