import 'package:crud_factories/Frontend/mail.dart';
import 'package:crud_factories/Frontend/factory.dart';
import 'package:crud_factories/Frontend/importData.dart';
import 'package:crud_factories/Frontend/send.dart';
import 'package:crud_factories/Frontend/send_mail.dart';
import 'package:crud_factories/Objects/Mail.dart';
import 'package:crud_factories/Objects/Factory.dart';
import 'package:crud_factories/Objects/lineSend.dart';
import '../Frontend/conection.dart';
import '../Frontend/view.dart';
import '../Functions/avoidRepeatArray.dart';

FuntionSeleted(int itenSelection, int subIten1Selection,int subIten2Selection, double mWidth, double mHeight, List<String> itens, List<Factory> factories, List<Mail> mails, List<lineSend> line) {

  List<String> datesSends;
  List<String> element = [];

    for (int i = 0; i < line.length; i++) {
      element.add(line[i].date);
    }

    datesSends = avoidRepeteat(element);

    int newdato = -1;

    switch (itenSelection) {
      case 0:
        if (subIten1Selection == 0) {
          if (subIten2Selection == 0) {
            return newFactory(factories, newdato);
          }

          if (subIten2Selection == 1)
            return newMail(mails, newdato);

          if (subIten2Selection == 2) {

            return newSend(datesSends, line, newdato, "", "", line, "",factories);
          }
        }

        if (subIten1Selection == 1)
          return newImport(factories, mails,line);

      case 1:
        String tView = '';

        if (subIten1Selection == 0)
          tView = 'factory';

        if (subIten1Selection == 1)
          tView = 'mail';
        if (subIten1Selection == 2)
          tView = 'send';

        return view(mWidth, mHeight, tView,  factories,  mails,  datesSends, line);


      case 2:
        return sendMail(datesSends,line,factories, mails);

      case 3:
        return conection();
    }

}



