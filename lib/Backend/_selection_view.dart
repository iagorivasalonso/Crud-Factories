import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Frontend/adminRoutes.dart';
import 'package:crud_factories/Frontend/conection.dart';
import 'package:crud_factories/Frontend/mail.dart';
import 'package:crud_factories/Frontend/factory.dart';
import 'package:crud_factories/Frontend/importData.dart';
import 'package:crud_factories/Frontend/send.dart';
import 'package:crud_factories/Frontend/send_mail.dart';
import 'package:crud_factories/Frontend/view.dart';
import 'package:crud_factories/Functions/avoidRepeatArray.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../generated/l10n.dart';

FuntionSeleted(int itenSelection, int subIten1Selection,int subIten2Selection, double mWidth, double mHeight, BuildContext context) {

  List<String> element = [];
  int select=-1;

    switch (itenSelection) {
      case 0:
        if (subIten1Selection == 0) {
          select = -1;

          if (subIten2Selection == 0)
            return newFactory(context,select);
          if (subIten2Selection == 1)
            return newMail(context, select);

          if (subIten2Selection == 2)
            return newSend(context,"", "", "", select);
        }



        if (subIten1Selection == 2)
          return newImport(context);

break;
      case 1:
        String tView = '';
        bool err = false;

        if (subIten1Selection == 1 || subIten1Selection == 3)
        {
            err = true;
            tView = S.of(context).company;

            factoriesSector.clear();

            String sector = subIten2Selection.toString();

            if(subIten2Selection == 0)
            {
              factoriesSector.clear();

              for(int i = 0; i < allFactories.length;i++)
              {
                factoriesSector.add(allFactories[i]);
                err = false;
              }
            }
            else
            {
              for(int i = 0; i < allFactories.length;i++)
              {
                if(allFactories[i].sector == sector)
                {
                  factoriesSector.add(allFactories[i]);
                  err = false;
                }
              }
            }
        }

        if (subIten1Selection == 2)
          tView = S.of(context).email;
        if (subIten1Selection == 3)
        {
          err = true;
          tView = S.of(context).shipment;

            if(subIten2Selection == 0)
            {
                lineSector.clear();
                String lineFactory ="";

                for(int i = 0; i < allLines.length; i++)
                {
                   lineFactory = allLines[i].factory;

                   for(int y = 0; y < factoriesSector.length; y++)
                   {
                        if(factoriesSector[y].name==lineFactory)
                        {
                          allLines[i].sector = factoriesSector[y].sector;
                          err = false;
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
                                 err = false;
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


        return view(tView,err,context);


      case 2:
        if (subIten1Selection == 0)
           return sendMail(context);
        if (subIten1Selection == 1)
          return conection(context);
    }

}



