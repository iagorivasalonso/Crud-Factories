import 'package:crud_factories/Backend/CSV/exportMails.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Backend/SQL/deleteMail.dart';
import 'package:crud_factories/Frontend/mail.dart';
import 'package:crud_factories/Widgets/defaultCard.dart';
import 'package:crud_factories/Widgets/headViewsAndroid.dart' show appBarAndroid;
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/material.dart';

import '../../Alertdialogs/warning.dart';
import '../../Objects/Mail.dart';
import '../../Widgets/GenericListViewPage.dart';
import '../../helpers/localization_helper.dart';

class listMails extends StatefulWidget {



  listMails();

  @override
  State<listMails> createState() => _listMailsState();
}

class _listMailsState extends State<listMails> {

  int selectCard = -1;


  Future<void>_onDelete(Mail mail)  async {

    final confirmDelete = await warning(
      context,
      LocalizationHelper.delete_factory(context, mail.address),
    );

    if (confirmDelete) {
      setState(() {
        factoriesSector.remove(factory);
        allFactories.remove(factory);
      });

      if (conn != null) {
        await sqlDeleteMail(mail.id);
      } else {
        csvExportatorMails(mails);
      }
    }

  }

  Future<void>_onTap(int index)  async {

    selectCard = index;
    // saveChanges = !await changesNoSave(context);

  }

  @override
  Widget build(BuildContext context) {

    BuildContext context = context1;

    double mWidth = MediaQuery.of(context).size.width;
    double mWidthList = 280;

    return Row(
      children: [
        SizedBox(
          width: mWidthList,
          child: GenericListViewPage<Mail>(
            itens: mails,
            defaultFilter: S.of(context).address,
            itemBuilder: (mail, index) => defaultCard(
              title: mail.address,
              description: mail.company,
              color: Colors.transparent,
            ),
            onDelete: _onDelete,
            onTap: (factory, index) => _onTap(index),
            onSelect: (index) {
              setState(() {
                // selectedIndex = index;
              });
            },
          ),
        ),

        SizedBox(
          width: mWidth-mWidthList,
          child: newMail(selectCard),
        ),
      ],
    );

  }
}
