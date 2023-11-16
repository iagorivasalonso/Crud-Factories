
import 'package:desktop_app/Frontend/mail.dart';
import 'package:desktop_app/Frontend/factory.dart';
import 'package:desktop_app/Frontend/importData.dart';
import 'package:desktop_app/Frontend/send.dart';
import 'package:desktop_app/Frontend/send_mail.dart';
import 'package:desktop_app/Objects/Mail.dart';
import 'package:desktop_app/Objects/Factory.dart';
import 'package:desktop_app/Objects/lineSend.dart';
import '../Frontend/conection.dart';
import '../Frontend/view.dart';
import '../Functions/avoidRepeat.dart';

FuntionSeleted (int itenSelection, int subIten1Selection,int subIten2Selection, double mWidth, double mHeight, List<String> itens) {

List<Factory> factories=[];
List<Mail> mails=[];

List<lineSend> line=[];
List<String> datesSends;

List<String> telephones;
List<String> empleoyes;
Map<String,String> address;


telephones =[];
empleoyes =[];
address = {'street': '', 'number': '', 'apartament': '', 'postalCode':'', 'city':''};
factories.add(Factory(name: '', highDate: '', thelephones: telephones, mail: '', web: '', address: address, contacts: empleoyes));

/*            */

mails.add(Mail(company: '', addrres: '', password:''));

/*            */

line.add(lineSend(date: '', factory: '', observations: '', state: ''));


  List<String> element = [];

  for(int i = 0; i <line.length; i++)
  {
     element.add(line[i].date);
  }

 datesSends = avoidRepeteat(element);

   int newdato = -1;

  switch (itenSelection){
    case 0:
        if(subIten1Selection==0)
         {
           if(subIten2Selection==0)
               return newFactory(newdato);
           if(subIten2Selection==1)
                return newMail(newdato);
           if(subIten2Selection==2)
                return newSend(newdato);
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

        return view(mWidth,mHeight,tView,factories,mails,line,datesSends);

    case 3:
        return sendMail();

    case 4:
      return conection(itens);



  }
}



