import 'package:crud_factories/Backend/Global/controllers/LineSend.dart' show LineSendController;
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Functions/isNotAndroid.dart' show isNotAndroid;
import 'package:crud_factories/Functions/manageState.dart' show manageState;
import 'package:crud_factories/Objects/LineSend.dart' show LineSendState;
import 'package:crud_factories/generated/l10n.dart' show S;
import 'package:fluent_ui/fluent_ui.dart' hide Checkbox;
import 'package:flutter/material.dart' hide Scrollbar;

class customDataTable extends StatelessWidget {

  final ScrollController scrollController;
  final List<String> columns;
  final bool showSectorColumn;
  final int? select;
  final List<String> states;
  final String? selectedItem;
  final List<bool> sendValues;
  final List<LineSendController> linesControllers;
  final String mesage;
  final void Function(int, String)? onObservationChanged;
  final void Function(int, LineSendState) onStateChanged;
  final void Function(int, bool) onSendChanged;
  Function(dynamic value) onSelectedAllChanged;

  customDataTable({
    super.key,
    required this.scrollController,
    required this.columns,
    required this.showSectorColumn,
    this.select,
    required this.states,
    this.selectedItem,
    required this.sendValues,
    required this.linesControllers,
    required this.mesage,
    this.onObservationChanged,
    required this.onStateChanged,
    required this.onSendChanged,
    required this.onSelectedAllChanged,
  });




  @override
  Widget build(BuildContext context0) {

    BuildContext context = isNotAndroid() ? context0 :  context1;

    return Container(
      width: 900,
      child: Column(
        children: [
          Row(
            children: [
              Scrollbar(
                  controller: scrollController,
                  thumbVisibility: true,       ///vere como queda
                  child: SizedBox(
                    height: 250,
                    child: SingleChildScrollView(
                        controller: scrollController,
                        scrollDirection: Axis.vertical,
                        child: DataTable(
                            columns: columns
                                .map((c)=> DataColumn(
                                label: SizedBox(width: 100, child: Text(c)),
                               ),
                                ).toList(),
                            rows: select == -1
                              ? tableLinesNew(context)
                              :  tableLinesEdit(context)

                        ),
                  ),
               ),
                    ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(mesage),
                Column(
                  children: [
                    if(select == -1)
                    Row(
                      children: [
                        Text(S.of(context).select_all),
                        Checkbox(
                          value: sendValues.every((v) => v), // true si todos están seleccionados
                          onChanged: (value) {
                            if (value != null) {
                              onSelectedAllChanged(value);
                            }
                          },
                        ),
                      ],
                    ),

                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  List<DataRow> tableLinesNew (BuildContext context) {

    return List <DataRow>.generate(linesControllers.length,
          (index) => DataRow(
          cells: [
            DataCell(
                Text(linesControllers[index].factory.text)
            ),

            if (showSectorColumn)
            DataCell(
                Text(linesControllers[index].sector.text)
            ),
            DataCell(
              TextField(
                controller: linesControllers[index].observations,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                ),
              ),
            ),
            DataCell(
              SizedBox(
                height: 40,
                child: DropdownButtonFormField<LineSendState>(
                  value: linesControllers[index].state, // ✅ el valor actual (un solo enum)
                  items: LineSendState.values.map((state) {
                    return DropdownMenuItem<LineSendState>(
                      value: state,                     // ✅ un solo enum, no la lista
                      child: Text(manageState.seeLanguage(context,state.name)), // ✅ texto traducido
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      linesControllers[index].state = value; // actualizar la fila
                      onStateChanged(index, value);
                    }
                  },
                ),
              ),
            ),

            DataCell(
              CheckboxListTile(
                value: sendValues[index],
                onChanged:( bool? value) {
                  if (value != null) {
                    onSendChanged(index, value); // <- notifica al padre
                  }

                },
              ),
            ),
          ]
      ),

    );
  }

  List<DataRow> tableLinesEdit (BuildContext context) {

    return List <DataRow>.generate(linesControllers.length,
          (index) => DataRow(
          cells: [
            DataCell(
                Text(columns[0]== S.of(context).company
                      ? linesControllers[index].factory.text
                      : linesControllers[index].date.text)
            ),

            if (showSectorColumn)
            DataCell(
                  Text(linesControllers[index].sector.text)
            ),
            DataCell(
              TextField(
                controller: linesControllers[index].observations,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),

                ),
                onChanged: (value){
                  if (onObservationChanged != null) {
                    onObservationChanged!(index, value);
                  }
                },
              ),
            ),
            DataCell(
                SizedBox(
                  height: 40,
                  child: DropdownButtonFormField<LineSendState>(
                    value: linesControllers[index].state,
                    items: LineSendState.values.map((state) {
                      return DropdownMenuItem<LineSendState>(
                        value: state,
                        child: Text(manageState.seeLanguage(context,state.name)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        linesControllers[index].state = value; // actualizar la fila
                        onStateChanged(index, value);
                      }
                    },
                  ),
                )
            ),
          ]
      ),

    );
  }
}
