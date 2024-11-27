import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Frontend/conection.dart';
import 'package:crud_factories/Frontend/mail.dart';
import 'package:crud_factories/Frontend/factory.dart';
import 'package:crud_factories/Frontend/importData.dart';
import 'package:crud_factories/Frontend/send.dart';
import 'package:crud_factories/Frontend/send_mail.dart';
import 'package:crud_factories/Frontend/view.dart';
import 'package:crud_factories/Functions/avoidRepeatArray.dart';
import 'package:crud_factories/Objects/LineSend.dart';

FuntionSeleted(int itenSelection, int subIten1Selection,int subIten2Selection, double mWidth, double mHeight) {

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
            return newSend("", "", "", select);
        }

        if (subIten1Selection == 1)
          return newImport();

      case 1:
        String tView = '';
        bool err = false;

        if (subIten1Selection == 0 || subIten1Selection == 2)
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
        {
          err = true;
          tView = 'send';

            if(subIten2Selection == 0)
            {
                lineSector.clear();
                err = false;
                String lineFactory ="";

                for(int i = 0; i < allLines.length; i++)
                {
                   lineFactory = allLines[i].factory;

                   for(int y = 0; y < factoriesSector.length; y++)
                   {
                        if(factoriesSector[y].name==lineFactory)
                        {
                          allLines[i].sector = factoriesSector[y].sector;
                        }


                   }
                  lineSector.add(allLines[i]);
                }

            }
            else
            {
                lineSector.clear();
                String factoryCurrent ="";
                bool exist = false;
                err = false;
                String sFactory = "";

                for(int i = 0; i < allLines.length; i++)
                {
                    factoryCurrent = allLines[i].factory;
                    exist = false;

                          for(int y = 0; y <factoriesSector.length; y++)
                          {
                               if(factoriesSector[y].name == factoryCurrent)
                               {
                                 exist = true;
                                 sFactory = factoriesSector[y].sector;
                               }
                          }

                    if(exist == true)
                    {
                        allLines[i].sector = sFactory;
                        lineSector.add(allLines[i]);
                    }
                }

            }

            for (int i = 0; i < lineSector.length; i++)
            {
              element.add(lineSector[i].date);
            }

            dateSends = avoidRepeteat(element);
        }


        return view(tView,err);


      case 2:
        if (subIten1Selection == 0)
           return sendMail();
        if (subIten1Selection == 1)
          return conection();
    }

}



