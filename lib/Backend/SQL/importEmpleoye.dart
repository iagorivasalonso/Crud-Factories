import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Objects/Empleoye.dart';

sqlImportEmpleoyes() async {

  try {
    var result = await conn.query('select * from empleoyes');


    for (var row in result) {
      empleoyes.add(Empleoye(
        id: row[0].toString(),
        name: row[1],
        idFactory: row[2].toString()
      ));
    }
  } catch (Exeption) {

  }
}



