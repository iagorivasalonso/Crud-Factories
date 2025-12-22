import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:flutter/foundation.dart' as foundation;

Future<void> sqlDeleteLines(List<String> idsDelete) async {

  try{
    String id = " ";

    for (int i = 0; i<idsDelete.length; i++)
    {
      id = idsDelete[i];

      if (!foundation.kIsWeb)
      var result = await executeQuery.query('delete from lineSends where id=? ',[id]);
    }

  } catch(SQLExeption) {

  }
}