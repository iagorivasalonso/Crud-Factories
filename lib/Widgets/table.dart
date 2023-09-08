import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';

class table extends StatefulWidget {
  const table({
    super.key,
  });

  @override
  State<table> createState() => _tableState();
}

class _tableState extends State<table> {

  List<bool> check = [false, false, false];

  @override
  Widget build(BuildContext context) {

    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
            label: SizedBox(
                width:200,
                child: Text('Empresa')
            ),
        ),
        DataColumn(
            label: SizedBox(
                width: 200,
                child: Text('Observaciones')
            )
        ),
        DataColumn(
            label: Text('Estado')
        ),
        DataColumn(
            label: Text('Seleccionar')
        ),
      ],
      rows: List<DataRow>.generate(3,
            (int index) =>  DataRow(
            cells: <DataCell>[
               const DataCell(
                 Text('1'),
               ),
               const DataCell(
                 Text('2'),
               ),
              const DataCell(
                Text('3'),
              ),
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
    );

  }






}