

import 'package:crud_factories/Backend/Providers/UserProvider.dart' show UserRole;
import 'package:crud_factories/Objects/User.dart';
import 'package:crud_factories/Widgets/genericCheckbox.dart' show genericCheckbox;
import 'package:crud_factories/Widgets/materialButton.dart' show materialButton;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' hide Scrollbar;

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
          )
       ],
    );
  }
}
