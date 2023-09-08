
import 'package:desktop_app/Frontend/factory.dart';
import 'package:desktop_app/Frontend/importData.dart';
import 'package:desktop_app/Frontend/send.dart';
import 'package:desktop_app/Frontend/view_email.dart';
import '../Frontend/conection.dart';
import '../Frontend/view_factory.dart';

FuntionSeleted (int itenSelection, int subItenSelection, double mWidth, double mHeight) {

  switch (itenSelection){
    case 0:
        if(subItenSelection==0)
            return newFactory();

        if(subItenSelection==1)
          return newSend();

        if(subItenSelection==2)
          return newImport();

    case 1:


    case 2:
        if(subItenSelection==0)
             return viewFactory(mWidth,mHeight);

        if(subItenSelection==1)
            return viewEmail();

    case 3:
            return conection();



  }
}