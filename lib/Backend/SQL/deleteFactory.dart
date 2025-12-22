import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:flutter/foundation.dart' as foundation;

Future<void> sqlDeleteFactory(String id) async {

  try{
    if (!foundation.kIsWeb)
    var result = await executeQuery.query('delete from factories where id=? ',[id]);

  } catch(SQLExeption) {

  }
}