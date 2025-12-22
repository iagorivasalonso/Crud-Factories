import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Objects/Mail.dart';
import 'package:flutter/foundation.dart' as foundation;

Future<void> sqlCreateMail(List<Mail> mails) async {

  try{

      for(int i = 0; i < mails.length; i++)
      {
         String id = mails[i].id;
         String company = mails[i].company;
         String email = mails[i].address;
         String password = mails[i].password;

         if (!foundation.kIsWeb)
         var result = await executeQuery.query(
           'insert into mails (id,company,email,password) values (?,?,?,?)',
           [id,company,email,password]);
    }

  } catch(SQLExeption){

   }
}


