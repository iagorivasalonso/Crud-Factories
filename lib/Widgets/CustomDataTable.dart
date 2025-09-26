import 'dart:io';
import 'package:fluent_ui/fluent_ui.dart' hide Checkbox;
import 'package:flutter/material.dart' hide Scrollbar;
import '../Backend/Global/controllers/LineSend.dart';
import '../Backend/Global/variables.dart';
import '../Functions/manageState.dart';
import '../helpers/localization_helper.dart';

class customDataTable extends StatelessWidget {

  final ScrollController scrollController;
  final List<String> columns;
  final bool showSectorColumn;
  final List<String> states;
  final List<bool> sendValues;
  final List<LineSendController> linesControllers;

  final void Function(int, String) onObservationChanged;
  final void Function(int, String) onStateChanged;
  final void Function(int, bool) onSendChanged;
  Function(dynamic value) onSelectedAllChanged;

  customDataTable({
    super.key,
    required this.scrollController,
    required this.columns,
    required this.showSectorColumn,
    required this.states,
    required this.sendValues,
    required this.linesControllers,
    required this.onObservationChanged,
    required this.onStateChanged,
    required this.onSendChanged,
    required this.onSelectedAllChanged,
  });


  @override
  Widget build(BuildContext context0) {

   BuildContext context = Platform.isWindows ? context1 : context0;

   int cantFactory = linesControllers.length;
   String stringFactories = LocalizationHelper.factoriesBD(context,cantFactory);
 
    return Container(
      child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 90, bottom: 30),
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
                                rows: tableLinesNew(),
                            ),
                      ),
                   ),
                        ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Row(
                  children: [
                    Text(stringFactories),
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
              )
            ],
          ),
      ),
    );
  }

  List<DataRow> tableLinesNew () {

    return List <DataRow>.generate(linesControllers.length,
          (index) => DataRow(
          cells: [
            DataCell(
                Text(linesControllers[index].factory.text)
            ),

            if (showSectorColumn)
            DataCell(
                Text("linesControllers[index].sector.text")
            ),
            DataCell(
              TextField(
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
                  child: DropdownButtonFormField<String>(
                    value: states.contains(linesControllers[index].state.text)
                        ? linesControllers[index].state.text
                        : states.first,
                    items: states
                        .map((option) => DropdownMenuItem<String>(
                      value: option,
                      child: Text(
                        manageState.seeLanguage(context1, option),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        onStateChanged(index, value);
                      }
                    },
                  ),
                )
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
}
