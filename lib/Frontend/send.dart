import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';


class newSend extends StatefulWidget {
  const newSend({Key? key}) : super(key: key);

  @override
  State<newSend> createState() => _newSendState();
}

class _newSendState extends State<newSend> {
  @override
  Widget build(BuildContext context) {
    return const ScaffoldPage(
      content: Align(
        alignment: Alignment.topLeft,
        child:  Padding(
          padding: EdgeInsets.only(left: 30.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text('Envio: ',
                    style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top:20.0, bottom: 30.0),
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
              Row(
                children: [
                  Text('Selección de empresas: ',
                    style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(top:20.0,bottom: 30.0),
                  child: tableWidget(),
              ),

            ],
          ),
        ),
      ),
    );

  }
}

class tableWidget extends StatefulWidget {
  const tableWidget({
    super.key,
  });

  @override
  State<tableWidget> createState() => _tableWidgetState();
}

class _tableWidgetState extends State<tableWidget> {
  bool check = false;
  @override
  Widget build(BuildContext context) {

    return DataTable(
        columns: const <DataColumn>[
               DataColumn(
                 label: SizedBox(
                     width:200,
                     child: Text('Empresa')
                 )
               ),
               DataColumn(
                   label: Text('Estado')
               ),
               DataColumn(
                   label: SizedBox(
                       child: Text('Seleccionar')
                   )
               ),
        ],
        rows: <DataRow>[
               DataRow(
                   selected: false,
                   cells: [
                       const DataCell(
                           Text('1'),
                       ),
                       const DataCell(
                           Text('1p'),
                       ),
                       DataCell(
                           Center(
                               child: CheckboxListTile(
                                    value: check,
                                    onChanged: (bool? value) {
                                          setState(() {
                                             check = value!;
                                          });
                                     },
                                  ),
                               ),
                           )
                   ]
               ),

        ],
    );
  }
}