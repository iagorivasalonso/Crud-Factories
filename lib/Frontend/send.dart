import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Backend/SQL/createLine.dart';
import 'package:crud_factories/Backend/SQL/modifyLines.dart';
import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Backend/CSV/exportLines.dart';
import 'package:crud_factories/Functions/createId.dart';
import 'package:crud_factories/Objects/LineSend.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:intl/intl.dart';
import 'package:show_platform_date_picker/show_platform_date_picker.dart';
import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:flutter/material.dart';


class newSend extends StatefulWidget {

  String selectCamp;
  String filter;
  String SeletedFilterSend;
  int select;

  newSend(this.selectCamp, this.filter,  this.SeletedFilterSend,this.select);

  @override
  State<newSend> createState() => _newSendState();
}

class _newSendState extends State<newSend> {

  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();
  final ScrollController verticalScrollTable = ScrollController();

  double widthBar = 10.0;

  late TextEditingController controllerSearch = new TextEditingController();
  List<TextEditingController> _controllersObserLine = [];
  List<TextEditingController> _controllerStateLine = [];

  List<String> campsTable = [];
  String filterSelected='';
  String date="";
  bool allSelect = false;
  List<bool> Send = List.generate(factories.length, (index) => false);
  List<bool> lineEdit = List.generate(line.length, (index) => false);
  DateTime seletedDate =DateTime.now();

  @override
  Widget build(BuildContext context) {

    String type = widget.SeletedFilterSend;
    String selectCamp = widget.selectCamp;
    int select = widget.select;

    List<LineSend> lineSelected = [];
    List <String> campKey = [];

    int cant = 0;
    String stringFactories = "";
    String title = "";
    String typeList="";
    String action1 = "";
    String action2 = "";


    if (select == -1) {

      title = "Nuevo ";
      typeList = "empresas: ";
      type = "Fecha ";
      action1 = "Nuevo";
      action2 = "Reiniciar";
      campsTable = ['Empresa', 'Observaciones', 'Estado', 'Seleccionar'];

      for (int i = 0; i < factories.length; i++)
      {
        _controllersObserLine.add(TextEditingController());
        _controllerStateLine.add(TextEditingController());
      }
      if(controllerSearch.text.isEmpty)
      {
        controllerSearch.text=DateFormat('dd-MM-yyyy').format( DateTime.now());
      }


      int cantFactory = factories.length;
      stringFactories = "Tiene $cantFactory empresas en su base de datos";

    }
    else {

      action1 = "Guardar";
      action2 = "Deshacer";
      title = "Ver ";



      if(type== "Fecha")
      {

        type = "Fecha:  ";
        campsTable = ['Empresa', 'Observaciones', 'Estado'];


          lineSelected.clear();

           controllerSearch.text = line[0].showFormatDate(selectCamp);

           for (int i = 0; i < line.length; i++)
           {
             if(controllerSearch.text == line[0].showFormatDate(line[i].date))
             {
               lineSelected.add(line[i]);
               campKey.add(line[i].factory);
             }

           }

        for (int i = 0; i < lineSelected.length; i++)
        {
          _controllersObserLine.add(TextEditingController());
          _controllerStateLine.add(TextEditingController());

        }

        int x =int.parse(lineSelected[0].id) -1 ;

        for (int i = 0; i < lineSelected.length; i++)
        {
            _controllersObserLine[i].text=line[x].observations;
            _controllerStateLine[i].text = line[x].state;

            x++;
        }

        cant = lineSelected.length;
        stringFactories = "Este dia se hicieron $cant envios";
      }

      typeList = "envios: ";

      if(type == "Empresa")
      {
        type = "Empresa:  ";
        campsTable = ['Fecha', 'Observaciones', 'Estado'];
        controllerSearch.text = selectCamp;

        lineSelected.clear();

        for (int i = 0; i < line.length; i++)
        {
          if(controllerSearch.text == line[i].factory)
          {
            lineSelected.add(line[i]);
            campKey.add(line[i].date);

          }
        }

        for (int i = 0; i < lineSelected.length; i++)
        {
          if(controllerSearch.text==lineSelected[i].factory)
          {
            _controllersObserLine[i].text=lineSelected[i].observations;
             _controllerStateLine[i].text = lineSelected[i].state;
          }

        }

        cant = lineSelected.length;
        stringFactories = "A esta empresa se le hicieron $cant envios";

      }
    }

    final ShowPlatformDatePicker platformDatePicker = ShowPlatformDatePicker(buildContext: context);

    for(int i = 0; i<Send.length; i++)
    {
      if(Send[i]==false)
      {
        allSelect = false;
      }
    }
    return Scaffold(
      body: AdaptiveScrollbar(
        controller: verticalScroll,
        width: widthBar,
        child: AdaptiveScrollbar(
          controller: horizontalScroll,
          width: widthBar,
          position: ScrollbarPosition.bottom,
          underSpacing: const EdgeInsets.only(bottom: 8),
          child: SingleChildScrollView(
            controller: verticalScroll,
            scrollDirection: Axis.vertical,
            child: SizedBox(
              width: 2000,
              child: SingleChildScrollView(
                controller: horizontalScroll,
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  height: 630,
                  width: 830,
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
                                      width: 500,
                                      height: 40,
                                      child: TextField(
                                        controller: controllerSearch,
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          icon: select == -1
                                              ? const Icon(Icons.calendar_today)
                                              : null,
                                        ),
                                        onTap: () async {
                                          if(select == -1)
                                          {
                                               DateTime? dateSelected = await  platformDatePicker.showPlatformDatePicker(
                                                    context,
                                                    seletedDate,
                                                    DateTime(DateTime.now().year - 10),
                                                    DateTime(DateTime.now().year + 1),
                                              );
                                              setState(() {
                                                 date =DateFormat('dd-MM-yyyy').format(dateSelected!);
                                                 controllerSearch.text = date;
                                            });
                                          }


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
                                        columns: List<DataColumn>.generate(campsTable.length, (index) =>
                                          DataColumn(
                                              label: Container(
                                                width: 100,
                                                  child: Text(campsTable[index])))
                                        ),
                                        rows: select == -1
                                        ? List<DataRow>.generate(factories.length, (indexRow) =>
                                           DataRow(
                                               cells: <DataCell>[
                                                 DataCell(
                                                   Text(factories[indexRow].name),
                                                 ),
                                                 DataCell(
                                                     Padding(
                                                       padding: const EdgeInsets.all(8.0),
                                                       child: TextField(
                                                         controller: _controllersObserLine[indexRow],
                                                         decoration: InputDecoration(
                                                           border: OutlineInputBorder(),
                                                         ),
                                                         onChanged: (s){
                                                           setState(() {
                                                             lineEdit[indexRow]=true;
                                                           });

                                                          },
                                                       ),
                                                     ),
                                                 ),
                                                 DataCell(
                                                   Padding(
                                                     padding: const EdgeInsets.all(8.0),
                                                     child: TextField(
                                                       controller: _controllerStateLine[indexRow],
                                                       decoration: InputDecoration(
                                                         border: OutlineInputBorder(),
                                                       ),
                                                       onChanged: (s){
                                                         lineEdit[indexRow]=true;
                                                       },
                                                     ),
                                                   ),
                                                 ),
                                                 DataCell(
                                                   CheckboxListTile(
                                                     value: Send[indexRow],
                                                     onChanged:( bool? value) {
                                                          setState(() {
                                                             Send[indexRow] = value!;
                                                             allSelect = true;
                                                          });
                                                     },
                                                   ),
                                                 ),
                                               ]
                                           )
                                        )
                                        : List<DataRow>.generate(lineSelected.length, (indexRow) =>
                                            DataRow(
                                                cells:  <DataCell>[
                                                  DataCell(
                                                      Text(campKey[indexRow])
                                                  ),
                                                  DataCell(
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: TextField(
                                                        controller: _controllersObserLine[indexRow],
                                                        decoration: InputDecoration(
                                                            border: OutlineInputBorder(),
                                                        ),
                                                        onChanged: (s){
                                                          lineEdit[indexRow]=true;
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: TextField(
                                                        controller: _controllerStateLine[indexRow],
                                                        decoration: InputDecoration(
                                                            border: OutlineInputBorder(),
                                                        ),
                                                         onChanged: (s){
                                                          lineEdit[indexRow]=true;
                                                         },
                                                      ),
                                                    ),
                                                  ),
                                                ]
                                            )
                                        ),
                                      )
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
                                        Column(
                                          children: [
                                            Text(stringFactories),
                                          ],
                                        ),
                                          if(select == -1)
                                          Padding(
                                            padding: const EdgeInsets.only(left: 290.0),
                                            child: Row(
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.only(right: 15.0),
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
                                            ),
                                          ),
                                      ],
                                    )
                                ),
                              ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 70.0, left: 550.0),
                                  child: SizedBox(
                                    width: 200,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        MaterialButton(
                                          color: Colors.lightBlue,
                                          child: Text(action1,
                                          style: const TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              List <LineSend> current = [];
                                              String idNew = "";

                                              if(line.isNotEmpty)
                                              {
                                                String idLast = line[line.length-1].id;
                                                idNew = createId(idLast);
                                              }
                                              else
                                              {
                                                idNew ="1";
                                              }

                                              int idInit = int.parse(idNew);

                                              if(select == -1)
                                              {
                                                int allLines =0;
                                                for(int i = 0; i < factories.length; i++)
                                                {
                                                  if(Send[i] == true)
                                                  {
                                                    int idNew = idInit + current.length;

                                                    current.add(
                                                        LineSend(
                                                            id: idNew.toString(),
                                                            date: controllerSearch.text,
                                                            factory: factories[i].name,
                                                            observations: _controllersObserLine[i].text,
                                                            state: _controllerStateLine[i].text)
                                                      );
                                                      allLines++;
                                                  }
                                                }

                                                String action ='El pedido contiene $allLines empresas';
                                                confirm(context,action);
                                              }
                                              else
                                              {
                                                int allLinesModify=0;

                                                for(int i = 0; i <lineEdit.length; i++)
                                                {
                                                   if(lineEdit[i]==true)
                                                   {
                                                      allLinesModify++;
                                                   }
                                                }

                                                String id='';
                                                for (int i = 0; i < lineSelected.length; i++)
                                                {

                                                  id=lineSelected[i].id;
                                                  for (int y = 0; y < lineSelected.length; y++)
                                                  {
                                                    if(lineSelected[i].id == id)
                                                    {
                                                      lineSelected[i].state =_controllerStateLine[i].text;
                                                      lineSelected[i].observations = _controllersObserLine[i].text;
                                                    }
                                                  }
                                                }

                                                String action ='';
                                                if (allLinesModify == 0)
                                                {
                                                  action ='no tiene ninguna linea a modificar';
                                                  error(context, action);
                                                }
                                                else
                                                {
                                                  action ='fueron modificadas $allLinesModify lineas';
                                                  confirm(context,action);
                                                }
                                              }

                                              if (conn != null)
                                              {
                                                  if(select==-1)
                                                  {
                                                      sqlCreateLine(current);
                                                  }
                                                  else
                                                  {
                                                     sqlModifyLines(lineSelected);
                                                  }
                                              }
                                              else
                                              {
                                                line = line + current;
                                                csvExportatorLines(line);
                                              }

                                              lineEdit = List.generate(line.length, (index) => false);
                                            });


                                          },
                                        ),

                                    MaterialButton(
                                      color: Colors.lightBlue,
                                      child: Text(action2,
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                            setState(() {
                                              if (select == -1)
                                              {
                                                for(int i = 0 ; i<factories.length; i++)
                                                {
                                                  Send[i] = false;
                                                  _controllersObserLine[i].text="";
                                                }
                                              }
                                              else
                                              {
                                                for(int i = 0 ; i < lineSelected.length; i++)
                                                {
                                                  if(lineEdit[i]==true)
                                                  {
                                                     _controllersObserLine[i].text = lineSelected[i].observations;
                                                  }

                                                }
                                              }

                                            });

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
      ),
    );
  }

}

