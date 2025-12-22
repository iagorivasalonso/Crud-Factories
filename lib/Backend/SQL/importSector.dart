import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Objects/Sector.dart';
import 'package:flutter/foundation.dart' as foundation;

sqlImportSetors() async {

  try {
    if (!foundation.kIsWeb) {
      var result = await executeQuery.query('select * from sectors');

      for (var row in result) {

        sectors.add(Sector(
          id: row[0].toString(),
          name: row[1],
        ));
      }

    }

  } catch(Exeption){

  }

}
