import 'package:crud_factories/Backend/Global/controllers/LineSend.dart' show LineSendController;
import 'package:crud_factories/Backend/Providers/LineSendProvider.dart';
import 'package:crud_factories/Backend/Providers/SectorProvider.dart';
import 'package:crud_factories/Functions/isNotAndroid.dart' show isNotAndroid;
import 'package:crud_factories/Functions/manageState.dart' show manageState;
import 'package:crud_factories/Objects/LineSend.dart' show LineSendState;
import 'package:crud_factories/generated/l10n.dart' show S;
import 'package:fluent_ui/fluent_ui.dart' hide Checkbox;
import 'package:flutter/material.dart' hide Scrollbar;
import 'package:provider/provider.dart';

import '../Objects/Sector.dart';

class customDataTable extends StatelessWidget {

  final ScrollController scrollController;
  final List<String> columns;

  final bool showSectorColumn;

  final List<LineSendController> lines;
  final List<bool> sendValues;


  final String mesage;

  final void Function(int, String)? onObservationChanged;
  final void Function(int, LineSendState) onStateChanged;
  final void Function(int, bool) onSendChanged;
  Function(dynamic value) onSelectedAllChanged;

  SendFilter? filter;

  customDataTable({
    super.key,
    required this.scrollController,
    required this.columns,
    required this.showSectorColumn,
    required this.sendValues,
    required this.lines,
    required this.mesage,
    this.onObservationChanged,
    required this.onStateChanged,
    required this.onSendChanged,
    required this.onSelectedAllChanged,
    this.filter,

  });




  @override
  Widget build(BuildContext context) {

    final isCreateMode = key is ValueKey<String> && (key as ValueKey<String>).value == 'new';

    return Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 250,
                child: Scrollbar(
                    controller: scrollController,
                  ///vere como queda
                    child: SingleChildScrollView(
                          controller: scrollController,
                          scrollDirection: Axis.vertical,
                          child: DataTable(
                            headingRowHeight: 40,
                            dataRowMinHeight: 40,
                            dataRowMaxHeight: 40,
                            columns: columns
                                .map((c) => DataColumn(label: Text(c)))
                                .toList(),
                            rows: _buildRows(context, isCreateMode),

                          ),
                    ),
                 ),
              ),

            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top:40.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(mesage),
                  Column(
                    children: [
                      if (isCreateMode == true)
                      Row(
                        children: [
                          Row(
                            children: [
                              Text(S.of(context).select_all),
                              Checkbox(
                                value: sendValues.isNotEmpty && sendValues.every((v) => v),// true si todos están seleccionados
                                onChanged: (v) {
                                  if (v != null) {
                                    onSelectedAllChanged!(v);
                                  }
                                },
                              ),
                            ],
                          ),

                        ],
                      ),

                    ],
                  ),
                ],
              ),
          ),
        ],
    );
  }



  List<DataRow> _buildRows(BuildContext context, bool isCreateMode) {

    return List.generate(lines.length, (index) {

      final line = lines[index];

        String? nameSector ="";
        String campKey = "";

        if(isCreateMode)
        {
          final providerSectors = context.watch<SectorProvider>().sectors;

          final sectorCurrent =  providerSectors.firstWhere(
                (s) => s.id == line.sector,
            orElse: () => Sector(id: '', name: ''),
          );

          nameSector = sectorCurrent?.name;

          campKey = line.factory;
        }
        else
        {
           nameSector = line.sector;

           campKey = this.filter == SendFilter.company
                      ? line.date
                      : line.factory;
        }

      return DataRow(
        cells: [

          DataCell(Text(campKey)),

          if (showSectorColumn)
            DataCell(Text(nameSector!)),

          DataCell(
            TextField(
              controller: line.observations,
              onChanged: (value) {
                onObservationChanged?.call(index, value);
              },
            ),
          ),

          DataCell(
            DropdownButtonFormField<LineSendState>(
              value: line.state,
              items: LineSendState.values
                  .map((s) => DropdownMenuItem(
                value: s,
                child: Text(
                  manageState.seeLanguage(context, s.name),
                ),
              ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  line.state = value;
                  onStateChanged(index, value);
                }
              },
            ),
          ),

          if (isCreateMode)
            DataCell(
              Center(
                child: Checkbox(
                  value: index < sendValues.length ? sendValues[index] : false,
                  onChanged: (v) {
                    if (v != null) {
                      onSendChanged.call(index, v);
                    }
                  },
                ),
              ),
            ),
        ],
      );
    });
  }
}


