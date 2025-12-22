import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Objects/Mail.dart';
import 'package:flutter/foundation.dart' as foundation;

Future<void> sqlModifyMail(List<Mail> mail) async {

  try{

    String id = mail[0].id;
    String company = mail[0].company;
    String email = mail[0].address;
    String password = mail[0].password;

    if (!foundation.kIsWeb)
    var result = await executeQuery.query('update mails set company=?,mail=?,password=? where id=?', [company,email,password, id]);

  } catch(SQLExeption){

  }
}

