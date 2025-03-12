import 'package:crud_factories/Backend/Global/variables.dart';

Future<void> sqlDeleteSector(String idSupr) async {

  try{

      var result = await conn.query('delete from sectors where id=? ',[idSupr]);
      
  } catch(SQLExeption) {

  }
}