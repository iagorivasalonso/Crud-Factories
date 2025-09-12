
import 'package:flutter/material.dart';


Padding tableElements<T>({
  required List<String>columnsTable,
  required List<T>contentTable,
  required TextEditingController controllerCamp,
  required List<String> Function(T) rowBuilder,
}) {
  final ScrollController verticalScrollTable = ScrollController();

  return Padding(
    padding: const EdgeInsets.only(left: 40.0),
    child: Row(
        children: [
          SizedBox(
            height: 200,
            child: Scrollbar(
              controller: verticalScrollTable,
              child: SingleChildScrollView(
                controller: verticalScrollTable,
                scrollDirection: Axis.vertical,
                child: DataTable(
                  columns: <DataColumn>[
                    for(int i = 0; i < columnsTable.length; i++)
                      DataColumn(
                        label: SizedBox(
                            width: 110,
                            child: Text(columnsTable[i])
                        ),
                      ),

                  ],
                  rows: List<DataRow>.generate(
                      contentTable.length, (int index) {
                    final cells = rowBuilder(contentTable[index]);
                    return DataRow(
                        cells: [
                          for (final cell in cells) DataCell(Text(cell)),
                        ]
                    );
                  }
                  ),
                ),
              ),
            ),
          ),
        ]
    ),
  );
}