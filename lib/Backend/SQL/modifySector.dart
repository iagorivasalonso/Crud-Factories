import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Objects/Sector.dart';
import 'package:flutter/foundation.dart' as foundation;

Future<void> sqlModifySector(List<Sector> sectors) async {

  try{

    String id = sectors[0].id;
    String name = sectors[0].name;

    if (!foundation.kIsWeb)
      var result = await executeQuery.query('update sectors set sector=? where id=?', [name, id]);

  } catch(SQLExeption) {
    
  }
}
