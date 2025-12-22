import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:flutter/foundation.dart' as foundation;

Future<void> sqlDeleteSector(String idSupr) async {

  try{

    if (!foundation.kIsWeb)
      var result = await executeQuery.query('delete from sectors where id=? ',[idSupr]);
      
  } catch(SQLExeption) {

  }
}