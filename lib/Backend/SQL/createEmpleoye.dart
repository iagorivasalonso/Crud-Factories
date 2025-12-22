import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Objects/Empleoye.dart';
import 'package:flutter/foundation.dart' as foundation;

Future<void> sqlCreateEmpleoye(List<Empleoye> empleoyes) async {

  try{

    for(int i = 0; i < empleoyes.length; i++)
    {
      String id = empleoyes[i].id;
      String name = empleoyes[i].name;
      String idFactory = empleoyes[i].idFactory;

      if (!foundation.kIsWeb)
        var result = await executeQuery.query(
            'insert into empleoyes (id,name,idFactory) values (?,?,?)',
            [id, name, idFactory]);
    }

  } catch(SQLExeption) {

  }
}
