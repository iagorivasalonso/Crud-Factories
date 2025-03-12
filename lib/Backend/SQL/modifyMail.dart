import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Objects/Mail.dart';

Future<void> sqlModifyMail(List<Mail> mail) async {

  try{

    String id = mail[0].id;
    String company = mail[0].company;
    String email = mail[0].addrres;
    String password = mail[0].password;

    var result = await conn.query('update mails set company=?,mail=?,password=? where id=?', [company,email,password, id]);

  } catch(SQLExeption){

  }
}

