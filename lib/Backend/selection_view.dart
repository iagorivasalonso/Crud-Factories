import 'package:crud_factories/Frontend/mail.dart';
import 'package:crud_factories/Frontend/factory.dart';
import 'package:crud_factories/Frontend/importData.dart';
import 'package:crud_factories/Frontend/send.dart';
import 'package:crud_factories/Frontend/send_mail.dart';
import 'package:crud_factories/Objects/Mail.dart';
import 'package:crud_factories/Objects/Factory.dart';
import 'package:crud_factories/Objects/lineSend.dart';
import 'package:fluent_ui/fluent_ui.dart';
import '../Frontend/conection.dart';
import '../Frontend/view.dart';
import '../Functions/avoidRepeatArray.dart';


FuntionSeleted(int itenSelection, int subIten1Selection,int subIten2Selection, double mWidth, double mHeight, List<String> itens, BuildContext context) {

List<Factory> factories = [];
List<lineSend> line = [];
List<String> datesSends;
List<Mail> mails =[];

List<String> telephones;
List<String> empleoyes;
Map<String,String> address;

telephones =['986 241 300', '610 925 664'];
empleoyes =['name 1','name 2'];
address = {'street': 'S. pelayo de navia, redondo', 'number': '30', 'apartament': 'Bajo', 'city':'Vigo', 'postalCode':'36212', 'province':'Pontevedra'};
factories.add(Factory(id: 01, name: 'Empresa Iago', highDate: '21-08-2009', thelephones: telephones, mail: 'iago@gmail.es', web: 'www.rivas.es', address: address, contacts: empleoyes));

telephones =['123 456 789',''];
empleoyes =[];
address = {'street': 'ty', 'number': '1', 'apartament': '', 'city':'Vigo', 'postalCode':'36212', 'province':'Pontevedra'};
factories.add(Factory(id: 02, name: 'mame 1', highDate: '21-07-2009', thelephones: telephones, mail: 'iago@gmail.es', web: 'www.rivas.es', address: address, contacts: empleoyes));

telephones =['123 456 789',''];
empleoyes =[];
address = {'street': 'ty', 'number': '1', 'apartament': '', 'city':'Sanxenxo', 'postalCode':'36212', 'province':'Pontevedra'};
factories.add(Factory(id: 03, name: 'mame 2', highDate: '21-07-2009', thelephones: telephones, mail: 'iagoghhhhhhhvm@gmail.es', web: 'www.rivas.es', address: address, contacts: empleoyes));


mails.add(Mail(id: 1, company: 'Gmail', addrres: 'iagorivasalonso@gmail.com', password:''));
mails.add(Mail(id: 2, company: 'Hotmail', addrres: 'iagorivas@hotmail.com', password:''));

/*          */
line.add(lineSend(date: '11 de enero del 2023', factory: factories[0], observations: 'h', state: 'Enviado'));
line.add(lineSend(date: '11 de enero del 2023', factory: factories[1], observations: '7', state: 'Enviado'));
line.add(lineSend(date: '1 de enero del 2023', factory: factories[2], observations: '9', state: 'Enviado'));
line.add(lineSend(date: '11 de abril del 2023', factory: factories[0], observations: 'gjh', state: 'Enviado'));
line.add(lineSend(date: '18 de abril del 2023', factory: factories[1], observations: 'hmn', state: 'Enviado'));
line.add(lineSend(date: '2 de octubre del 2023', factory: factories[0], observations: 'cggfv', state: 'Enviado'));
line.add(lineSend(date: '24 de octubre del 2023', factory: factories[1], observations: 'cfrtgh', state: 'Enviado'));





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
               line.add(lineSend(date: '', factory: factories[i], observations: '', state: ''));
             }

              return newSend(line,newdato,"","",line,"");
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

        if(tView != '')
        {
          return view(mWidth,mHeight,tView,factories,mails,datesSends,line);
        }


    case 2:
        return sendMail(datesSends,line,mails);

    case 3:
      return conection();



  }
}



