import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Objects/Mail.dart';

Future<void> sqlCreateMail(List<Mail> mails) async {

  try{

      for(int i = 0; i < mails.length; i++)
      {
         String id = mails[i].id;
         String company = mails[i].company;
         String email = mails[i].addrres;
         String password = mails[i].password;

         var result = await conn.query(
           'insert into mails (id,company,email,password) values (?,?,?,?)',
           [id,company,email,password]);
    }

  } catch(SQLExeption){

   }
}


