import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Frontend/conection.dart';
import 'package:crud_factories/Frontend/mail.dart';
import 'package:crud_factories/Frontend/factory.dart';
import 'package:crud_factories/Frontend/importData.dart';
import 'package:crud_factories/Frontend/send.dart';
import 'package:crud_factories/Frontend/send_mail.dart';
import 'package:crud_factories/Frontend/view.dart';
import 'package:crud_factories/Functions/manageArrays.dart';
import 'package:crud_factories/Objects/Factory.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../Frontend/adminRoutes.dart';
import '../generated/l10n.dart';

FuntionSeleted(int itenSelection, int subIten1Selection,int subIten2Selection, double mWidth, double mHeight, BuildContext context) {

  List<String> element = [];
  int select=-1;

    switch (itenSelection) {
      case 0:
        if (subIten1Selection == 0) {
          select = -1;

          if (subIten2Selection == 0)
            return newFactory(select);
          if (subIten2Selection == 1)
            return newMail(select);

          if (subIten2Selection == 2)
            return newSend("", "", select);
        }

        if (subIten1Selection == 1)
          return adminRoutes();

        if (subIten1Selection == 2)
          return newImport();

      case 1:
        String tView = '';
        bool err = false;
        factoriesSector.clear();

        if (subIten1Selection == 1)
        {
            tView = S.of(context).company;


            groupFactoriesSector(subIten2Selection);

            if(factoriesSector.isEmpty)
            {
                err = true;
            }
        }

        if (subIten1Selection == 2)
          tView = S.of(context).mail;

        if (subIten1Selection == 3)
        {

          err = false;
          tView = S.of(context).shipment;

          groupFactoriesSector(subIten2Selection);

          if(factoriesSector.isEmpty)
          {
            err = true;
          }
          else
          {
              groupLinesSector(subIten2Selection,element);
          }
        }


        return view(tView,err,context);

      case 2:
        if (subIten1Selection == 0)
        {
          groupFactoriesSector(subIten2Selection);
          groupLinesSector(subIten2Selection,element);

          return sendMail();
        }

        if (subIten1Selection == 1)
          return conection();
    }

}
void groupFactoriesSector(int subIten2Selection) {

  String sector = subIten2Selection.toString();
  factoriesSector.clear();
  if(subIten2Selection == 0)
  {
      factoriesSector = allFactories;
  }
  else
  {
    factoriesSector = allFactories.where((f) =>f.sector == sector).toList();
  }

}

void groupLinesSector(int subIten2Selection, List<String> element) {

  dateSends.clear();
  lineSector.clear();

  if(subIten2Selection == 0)
  {
      factoriesSector = factoriesSector;
  }
  else
  {
    if (factoriesSector.isEmpty) {
      groupFactoriesSector(0);
    }
  }

  for(var line in allLines)
  {
    final matches = factoriesSector.where(
            (f) => f.name == line.factory
    );

    if(matches.isNotEmpty)
    {
      final factory = matches.first;
      line.sector = factory.sector;
      lineSector.add(line);
    }
  }

  dateSends = manageArrays.avoidRepeteat(
    lineSector.map((line) => line.date).toList(),
  );
}





