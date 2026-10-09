import 'package:crud_factories/Alertdialogs/createUser.dart';
import 'package:crud_factories/Alertdialogs/warning.dart' show warning;
import 'package:crud_factories/Backend/Data/controlsMessagesError/errors.dart';
import 'package:crud_factories/Objects/User.dart';
import 'package:crud_factories/Widgets/dropDownButton.dart' show GenericDropdown;
import 'package:crud_factories/Widgets/headView.dart';
import 'package:crud_factories/Widgets/tableUser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Alertdialogs/confirm.dart';
import '../Alertdialogs/error.dart';
import '../Backend/Providers/UserProvider.dart';
import '../generated/l10n.dart';

class adminPage extends StatefulWidget {
  const adminPage({super.key});

  @override
  State<adminPage> createState() => _adminPageState();
}

class _adminPageState extends State<adminPage> {

  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();
  final ScrollController verticalScrollTable = ScrollController();

  UserRole? selectedRol;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Scrollbar(
          controller: verticalScroll,
          thumbVisibility: true,
          child: Scrollbar(
              controller: horizontalScroll,
              thumbVisibility: true,
              notificationPredicate: (notification) =>
              notification.metrics.axis == Axis.horizontal,
              child: SingleChildScrollView(
                 controller: verticalScroll,
                 scrollDirection: Axis.vertical,
                 child: SingleChildScrollView(
                   controller: horizontalScroll,
                   scrollDirection: Axis.horizontal,
                   child: Padding(
                       padding: const EdgeInsetsGeometry.only(left: 60.0, top: 30.0),
                       child: Container(
                           constraints: BoxConstraints(
                             minWidth: MediaQuery.of(context).size.width,
                             minHeight: MediaQuery.of(context).size.height,
                           ),
                           child: Align(
                               alignment: Alignment.topLeft,
                               child: SizedBox(
                                   width: 850,
                                   child: Column(
                                     children: [
                                         headView(title: S.of(context).user_management),
                                         Align(
                                           alignment: Alignment.topLeft,
                                           child: Padding(
                                             padding: const EdgeInsets.only( top:30, left: 10,bottom: 20),
                                             child: SizedBox(
                                               width: 300,
                                               child: GenericDropdown<UserRole>(
                                                   items: [
                                                     ...UserRole.values,
                                                    ],
                                                   opDefault: S.of(context).allMale,
                                                   camp: S.of(context).role,
                                                   selectedItem: selectedRol,
                                                   hint: S.of(context).allMale,
                                                   itemLabel: (rol) {
                                                     switch (rol) {
                                                       case UserRole.admin:
                                                         return S.of(context).administrator;
                                                       case UserRole.user:
                                                         return S.of(context).user;
                                                     }
                                                   },
                                                   onChanged: (role) {
                                                     setState(() {
                                                       selectedRol = role;
                                                     });
                                                   },
                                               ),
                                             ),
                                           ),
                                         ),

                                         SizedBox(
                                           height: 500,
                                           child: Consumer<UserProvider>(
                                               builder: (context,userProvider,child) {

                                                 final users = userProvider.users;

                                                 final resultUsers = selectedRol == null
                                                     ? users
                                                     : users.where((user) => user.role ==  selectedRol!.name).toList();

                                                 return tableUsers(
                                                      scrollController: verticalScrollTable,
                                                      columns: selectedRol == null
                                                          ? [S.of(context).user,S.of(context).mail,S.of(context).role,S.of(context).active_user, S.of(context).actions]
                                                          : [S.of(context).user,S.of(context).mail,S.of(context).active_user, S.of(context).actions],
                                                      rol: selectedRol,
                                                      users: resultUsers,
                                                      onDelete: (index, value) async {
 print("ess");
                                                            final accepted = await warning(
                                                              context,
                                                              S.of(context).delete_account_confirm,
                                                            );

                                                            if (!accepted) return;

                                                            final result = await userProvider.delete(resultUsers[index].id);

                                                            if(result == DeleteResult.success)
                                                            {
                                                               await confirm(context, S.of(context).user_deleted_successfully);
                                                            }
                                                            else {
                                                              await error(
                                                                context,
                                                                S.of(context)
                                                                    .account_delete_error,
                                                              );
                                                            }
                                                      },
                                                      onEdit: (index, value) async {

                                                           final userEdit = users[index];

                                                           userProvider.select(userEdit);

                                                           showDialog(
                                                             context: context,
                                                             builder: (context) => const createUser(),
                                                           );
                                                      },
                                                    );
                                               }
                                           ),
                                           /*
                                           */
                                         )
                                     ],
                                   ),
                               ),
                           ),
                       ),    
                   ),
                 ),
              )
          )
      ),
    );
    


  }
}
