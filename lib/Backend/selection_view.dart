
import 'package:desktop_app/Frontend/factory.dart';
import 'package:desktop_app/Frontend/importData.dart';
import 'package:desktop_app/Frontend/send.dart';
import 'package:desktop_app/Frontend/view_email.dart';

import '../Frontend/view_factory.dart';

FuntionSeleted (int itenSelection, int subItenSelection) {

  switch (itenSelection){
    case 0:
        if(subItenSelection==0)
            return newFactory();

        if(subItenSelection==1)
          return newSend();

        if(subItenSelection==2)
          return newImport();

    case 1:

      break;

    case 2:
        if(subItenSelection==0)
             return viewFactory();

        if(subItenSelection==1)
            return viewEmail();

    case 3:

      break;


  }
}