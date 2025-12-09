import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Frontend/Views/listFactories.dart';
import 'package:crud_factories/Frontend/Views/listMails.dart';
import 'package:crud_factories/Frontend/Views/listSends.dart';
import 'package:crud_factories/Frontend/conection.dart';
import 'package:crud_factories/Frontend/mail.dart';
import 'package:crud_factories/Frontend/factory.dart';
import 'package:crud_factories/Frontend/importData.dart';
import 'package:crud_factories/Frontend/send.dart';
import 'package:crud_factories/Frontend/send_mail.dart';
import 'package:crud_factories/Functions/manageArrays.dart';
import 'package:crud_factories/Objects/Factory.dart';
import 'package:fluent_ui/fluent_ui.dart';
import '../Frontend/adminRoutes.dart';
import '../Objects/LineSend.dart';

FuntionSeleted(int itenSelection, int subIten1Selection,int subIten2Selection, double mWidth, double mHeight, BuildContext context) {

  List<Factory> allFactoriesOriginal = [];

  allFactoriesOriginal = allFactories.map((f) => f.copyWith()).toList();

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
        factoriesSector.clear();

        if (subIten1Selection == 1)
        {
            groupFactoriesSector(subIten2Selection,allFactoriesOriginal);

            if(factoriesSector.isEmpty)
            {
              WidgetsBinding.instance?.addPostFrameCallback((_) async {
                error(context, "no hay Empresas en el sector, se mostraran todas las Empresas");
              });
              factoriesSector = allFactories;
            }

            return listFactories(context,List.from(factoriesSector));
        }

        if (subIten1Selection == 2)
          return listMails();

        if (subIten1Selection == 3)
        {
          groupFactoriesSector(subIten2Selection,allFactoriesOriginal);

          List<LineSend> filteredLines = groupLinesSector();

          if(filteredLines.isEmpty)
          {
            WidgetsBinding.instance?.addPostFrameCallback((_) async {
              error(context, "no hay lineas en el sector, se mostraran todas las lineas");
            });

             groupFactoriesSector(0,allFactoriesOriginal);

             filteredLines = groupLinesSector();
          }

          return listSends(context,List.from(filteredLines),List.from(dateSends));
        }



      case 2:
        if (subIten1Selection == 0)
        {
          groupFactoriesSector(subIten2Selection,allFactoriesOriginal);

          return sendMail();
        }

        if (subIten1Selection == 1)
          return conection();
    }

}
void groupFactoriesSector(int subIten2Selection, List<Factory> allFactoriesOriginal) {

  String sector = subIten2Selection.toString();
  factoriesSector.clear();

  if(subIten2Selection == 0)
  {
    factoriesSector  = allFactoriesOriginal
        .map((f) => f.copyWith())
        .toList();
  }
  else
  {
    factoriesSector  = allFactoriesOriginal
        .where((s) => s.sector == sector)
        .map((f) => f.copyWith())
        .toList();

  }

}

List<LineSend> groupLinesSector() {

  dateSends.clear();
  lineSector.clear();

  for(int i = 0; i <factoriesSector.length; i++)
  {
    final factory = factoriesSector[i];

      final lines = allLines.
            where((sl) => sl.factory == factory.name).toList();

    for (var line in lines) {
      line.sector = factory.sector; // <-- aquí se asigna
    }

    lineSector.addAll(lines);
  }

  dateSends = manageArrays.avoidRepeteat(
    lineSector.map((line) => line.date).toList(),
  );

  return lineSector;
}





