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
import '../../Functions/changesNoSave.dart';
import '../../Functions/isNotAndroid.dart';
import '../../Objects/Mail.dart';
import '../../Widgets/GenericListViewPage.dart';
import '../../helpers/localization_helper.dart';

class listMails extends StatefulWidget {

  listMails();

  @override
  State<listMails> createState() => _listMailsState();
}

class _listMailsState extends State<listMails> {

  int selectCard = 0;

  Future<bool>_onDelete(BuildContext context,Mail mail)  async {

    final confirmDelete = await warning(
      context,
      LocalizationHelper.confirm_delete(context,"${mail.address}"),
    );

    if (confirmDelete) {
      setState(() {
        mails.remove(mail);
      });
      return true;
    }


    if (executeQuery != null) {
      await sqlDeleteMail(mail.id);
    } else {
      csvExportatorMails(mails);
    }
    return false;

  }

  Future<void>_onTap(int index, BuildContext context)  async {

    selectCard = index;

    if (saveChanges) {
      saveChanges = !await changesNoSave(context);
      return;
    }
  }

  @override
  Widget build(BuildContext context0) {

    BuildContext context = isNotAndroid() ? context0 :  context1;

    double mWidth = MediaQuery.of(context).size.width;
    double mWidthList = mWidth > 280 ? 250 : 0;

    return Row(
      children: [
        Container(
          color: Colors.grey,
          width: mWidthList,
          child: GenericListViewPage<Mail>(
            itens: mails,
            itemBuilder: (mail, index) => defaultCard(
              title: mail.address,
              description: mail.company,
              color: selectCard  == index
                     ? Colors.white
                     : Colors.grey,
            ),
            onDelete: (mail) => _onDelete(context, mail),
            onTap: (mail, index) => _onTap(index, context),
            onSelect: (index) {
              setState(() {
                selectCard = index;
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
