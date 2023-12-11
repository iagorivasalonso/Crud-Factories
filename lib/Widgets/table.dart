import 'package:crud_factories/Objects/lineSend.dart';
import 'package:flutter/material.dart';

class table extends StatefulWidget {

  List<String> campsTable;
  List<lineSend> listSend;


  table(this.campsTable, this.listSend);


  State<table> createState() => _tableState();
}

class _tableState extends State<table> {

  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();

  double widthBar = 10.0;

  List<TextEditingController> _controllers =[];


 List<bool> selec1 =[false,true,false];
  late List<bool> Send= List.generate(88, (index) => false);

  @override
  Widget build(BuildContext context) {

    List<String> campsTable = widget.campsTable;
    List<lineSend> listSend = widget.listSend;



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


    return Container(
      height: 200,
      child: Text("sfdsg")
     /* Scrollbar(
        controller: verticalScroll,
        child: SingleChildScrollView(
          controller: verticalScroll,
          scrollDirection: Axis.vertical,
          child: DataTable(
            columns: <DataColumn>[
              for(int i=0 ; i < columnsTable.length; i++)
                DataColumn(
                  label: SizedBox(
                      width: 110,
                      child: Text(columnsTable[i])
                  ),
                ),

            ],
            rows: List<DataRow>.generate(sendsDay.length,
                  (int index) =>  DataRow(
                  cells: <DataCell>[
                    DataCell(
                        Text(sendsDay[index].factory.name)
                    ),
                    DataCell(
                        Text(sendsDay[index].factory.mail)
                    ),
                  ]
              ),
            ),
          ),
        ),
      ),*/
    );
  }

}