import 'package:crud_factories/Backend/Global/variables.dart';

Future<void> sqlDeleteMail(String id) async {

  try{

    var result = await conn.query('delete from mails where id=? ',[id]);

  } catch(SQLExeption) {

  }
}