import 'package:crud_factories/Backend/data.dart';

Future<void> sqlDeleteFactory(String id) async {

  try{

    var result = await conn.query('delete from factories where id=? ',[id]);

  } catch(SQLExeption) {

  }
}