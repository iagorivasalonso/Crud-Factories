
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Objects/Sector.dart';
import 'package:flutter/foundation.dart' as foundation;

Future<void> sqlCreateSector(List<Sector> sectors) async {

  try{

    for(int i = 0; i < sectors.length; i++)
    {
      String id = sectors[i].id;
      String name = sectors[i].name;

      if (!foundation.kIsWeb)
      var result = await executeQuery.query(
          'insert into sectors (id,sector) values (?,?)',
          [id,name]);
    }

  } catch(SQLExeption) {

  }
}

