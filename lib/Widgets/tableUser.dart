

import 'package:crud_factories/Backend/Providers/UserProvider.dart' show UserRole;
import 'package:crud_factories/Objects/User.dart';
import 'package:crud_factories/Widgets/genericCheckbox.dart' show genericCheckbox;
import 'package:crud_factories/Widgets/materialButton.dart' show materialButton;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' hide Scrollbar, Colors;

import '../generated/l10n.dart';

class tableUsers extends StatelessWidget {

  final ScrollController scrollController;
  final List<String> columns;
  final UserRole? rol;
  final List<User> users;

  final void Function(int, int)? onDelete;
  final void Function(int, int)? onEdit;

  tableUsers({
    super.key,
    required this.scrollController,
    required this.columns,
    required this.rol,
    required this.users,
    required this.onDelete,
    required this.onEdit,
  });


  @override
  Widget build(BuildContext context) {

    return Column(
       children: [
          Row(
            children: [
                SizedBox(
                    height: 250,
                    child: Scrollbar(
                        controller: scrollController,
                        child: SingleChildScrollView(
                          controller: scrollController,
                          scrollDirection: Axis.vertical,
                          child: DataTable(
                              columns: columns
                                       .map((c) => DataColumn(label: Text((c))))
                                       .toList(),
                              rows: List<DataRow>.generate(users.length, (int index) {
                                   return DataRow(
                                       cells: [
                                           DataCell(Text(users[index].username)),
                                           DataCell(Text(users[index].role)),
                                           if(rol == null)
                                           DataCell(Text(users[index].mail!)),
                                           DataCell(
                                                genericCheckbox(
                                                        text: " ",
                                                        value: users[index].active,
                                                        onChanged: (s){

                                                        },
                                                  ),
                                           ),
                                           DataCell(
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 50,
                                                    height: 30,
                                                    child: materialButton(
                                                      icon: Center(
                                                        child: Icon(Icons.delete),
                                                      ),
                                                      function: () => onDelete?.call(index, 0),
                                                    ),
                                                  ),
                                                 const SizedBox(width: 30),
                                                  SizedBox(
                                                    width: 50,
                                                    height: 30,
                                                    child: materialButton(
                                                      icon: Center(
                                                        child: Icon(Icons.edit),
                                                      ),
                                                      function: () =>  onEdit?.call(index, 0),
                                                    ),
                                                  ),
                                                ],
                                              )
                                           )
                                       ]
                                   );
                              })

                                              ),
                        ),
                      ),
                ),
            ]
          ),

         Padding(
           padding: const EdgeInsets.only(left: 20.0,top: 40.0),
           child: Row(
             children: [
                if(users.isNotEmpty)  ...[
                  Container(
                    width: 150,
                    color: const Color(0xFFE0E0E0),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(S.of(context).users, style: const TextStyle(fontWeight: FontWeight.bold)),
                          Padding(
                              padding: EdgeInsets.only( left: 20.0, top: 3.0, bottom: 2.0),
                              child: Text(users.length.toString())
                          ),

                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0,right: 20.0),
                    child: Container(
                      width: 150,
                      color: const Color(0xFFE0E0E0),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(S.of(context).active, style: const TextStyle(fontWeight: FontWeight.bold)),
                            Padding(
                                padding: EdgeInsets.only( left: 20.0, top: 3.0, bottom: 2.0),
                                child: Text(users.where((u) => u.active).length.toString())
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Container(
                    width: 150,
                    color: const Color(0xFFE0E0E0),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(S.of(context).inactive, style: const TextStyle(fontWeight: FontWeight.bold)),
                          Padding(
                              padding: EdgeInsets.only( left: 20.0, top: 3.0, bottom: 2.0),
                              child: Text(users.where((u) => !u.active).length.toString())
                          ),
                        ],
                      ),
                    ),
                  ),

                ]
             ],
           ),
         )
       ],
    );
  }
}
