
import 'package:desktop_app/Frontend/email.dart';
import 'package:desktop_app/Frontend/factory.dart';
import 'package:desktop_app/Frontend/importData.dart';
import 'package:desktop_app/Frontend/new_send.dart';
import 'package:desktop_app/Frontend/send_mail.dart';
import '../Frontend/conection.dart';
import '../Frontend/view.dart';

FuntionSeleted (int itenSelection, int subIten1Selection,int subIten2Selection, double mWidth, double mHeight) {

  switch (itenSelection){
    case 0:
        if(subIten1Selection==0)
         {
           if(subIten2Selection==0)
                return newFactory();
           if(subIten2Selection==1)
                 return newEmail();
           if(subIten2Selection==2)
             return newSend();
         }

        if(subIten1Selection==1)
          return newImport();

    case 1:
      itenSelection = -1;
      subIten1Selection = -1;
      subIten2Selection = -1;


    case 2:
      String tView ='';

      if(subIten1Selection==0)
        tView ='factory';
      if(subIten1Selection==1)
        tView ='email';
      if(subIten1Selection==2)
        tView ='send';

        return view(mWidth,mHeight,tView);

    case 3:
        return sendMail();

    case 4:
      return conection();



  }
}