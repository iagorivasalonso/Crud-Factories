import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Frontend/conection.dart';
import 'package:crud_factories/Frontend/mail.dart';
import 'package:crud_factories/Frontend/factory.dart';
import 'package:crud_factories/Frontend/importData.dart';
import 'package:crud_factories/Frontend/send.dart';
import 'package:crud_factories/Frontend/send_mail.dart';
import 'package:crud_factories/Frontend/view.dart';
import 'package:crud_factories/Functions/avoidRepeatArray.dart';

FuntionSeleted(int itenSelection, int subIten1Selection,int subIten2Selection, double mWidth, double mHeight) {

  List<String> element = [];
  int select=-1;

    for (int i = 0; i < line.length; i++) {
      element.add(line[i].date);
    }

    dateSends = avoidRepeteat(element);

    switch (itenSelection) {
      case 0:
        if (subIten1Selection == 0) {
          select = -1;

          if (subIten2Selection == 0)
            return newFactory(select);


          if (subIten2Selection == 1)
            return newMail(select);

          if (subIten2Selection == 2)
            return newSend("", "", "", select);
        }

        if (subIten1Selection == 1)
          return newImport();

      case 1:
        String tView = '';
        bool err = false;

        if (subIten1Selection == 0)
        {
          err = true;
            tView = 'factory';

            factoriesSector.clear();

            String sector = subIten2Selection.toString();

            if(subIten2Selection == 0)
            {
              err = false;
              for(int i = 0; i < factories.length;i++)
              {
                factoriesSector.add(factories[i]);
              }
            }
            else
            {
              for(int i = 0; i < factories.length;i++)
              {
                if(factories[i].sector== sector)
                {
                  factoriesSector.add(factories[i]);
                  err = false;
                }
              }
            }
        }

        if (subIten1Selection == 1)
          tView = 'mail';
        if (subIten1Selection == 2)
          tView = 'send';

        return view(tView,err);


      case 2:
        if (subIten1Selection == 0)
           return sendMail();
        if (subIten1Selection == 1)
          return conection();
    }

}



