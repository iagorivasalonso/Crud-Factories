
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

List<Factory> factories = [];
List<lineSend> line = [];
List<String> datesSends;
List<Mail> mails =[];


List<String> telephones;
List<String> empleoyes;
Map<String,String> address;

telephones =['', ''];
empleoyes =['',''];
address = {'street': '', 'number': '', 'apartament': '', 'city':'', 'postalCode':'', 'province':''};
factories.add(Factory(id: 0, name: '', highDate: '', thelephones: telephones, mail: '', web: 'w', address: address, contacts: empleoyes));
telephones =['',''];


/*            */

  mails.add(Mail(company: '', addrres: '', password:''));


/*            */
  line.add(lineSend(date: '', factory: '' , observations: '', state: ''));



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
               return newFactory(factories, newdato);
           if(subIten2Selection==1)
                return newMail(mails,newdato);

           if(subIten2Selection==2)
           {
             line.clear();

             for(int i = 0 ; i <factories.length; i++)
             {
               line.add(lineSend(date: '2 de noviembre del 2023', factory: factories[i], observations: '', state: 'Enviado'));
             }

            // return newSend(line,newdato,selectDate);
           }

         }

        if(subIten1Selection==1)
          return newImport();

    case 1:
      String tView ='';
      if(subIten1Selection==0)
        tView ='factory';
      if(subIten1Selection==1)
        tView ='mail';
      if(subIten1Selection==2)
        tView ='send';

        return view(mWidth,mHeight,tView,factories,mails,datesSends,line);

    case 2:
        return sendMail(datesSends,line,mails);

    case 3:
      return conection(itens);



  }
}



