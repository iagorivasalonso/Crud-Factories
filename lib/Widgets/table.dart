import 'package:desktop_app/Objects/lineSend.dart';
import 'package:flutter/material.dart';

class table extends StatefulWidget {

  List<String> campsTable;
  int rowsTable;
  List<bool> selectable;
  List<lineSend> listSend;

  table(this.campsTable, this.rowsTable,this.selectable, this.listSend);


  State<table> createState() => _tableState();
}

class _tableState extends State<table> {

  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();

  double widthBar = 10.0;

  late TextEditingController controllerObservations;


  @override
  Widget build(BuildContext context) {

    controllerObservations = new TextEditingController();

    List<String> campsTable = widget.campsTable;
    List<bool> check = widget.selectable;
    List<lineSend> listSend = widget.listSend;
    int endTable = 0;

print(listSend[0].toString());


    if(check.isEmpty)
    {

      endTable = campsTable.length;


    }else{

      endTable = campsTable.length-1;
    }
    var bhj="44";
    return Container(
      height: 250,
      child: Scrollbar(
        controller: verticalScroll,
        child: SingleChildScrollView(
          controller: verticalScroll,
          scrollDirection: Axis.vertical,
          child: DataTable(
            columns: <DataColumn>[
              for(int i=0 ; i < campsTable.length; i++)
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
                        ? Text(listSend[index].factory)
                        : campsTable[i] == "Observaciones"
                        ? Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                             controller: controllerObservations,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                  labelText:listSend[index].observations,
                              ),
                          ),
                        )
                        : campsTable[i] == "Estado"
                        ? Text(listSend[index].state)
                        : campsTable[i] == "Email"
                        ? Text("@")
                        : Text("otro"),
                       ),
                    if(check.isNotEmpty)
                      DataCell(
                        Center(
                            child: CheckboxListTile(
                              value: check[index],
                              onChanged:  (bool? value) {
                                setState(() {
                                  check[index]= value!;
                                });
                              },)
                        ),
                      )

                  ]
              ),
            ),
          ),
        ),
      ),
    );
  }

}