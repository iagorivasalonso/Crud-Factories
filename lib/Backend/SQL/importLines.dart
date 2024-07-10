import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Objects/LineSend.dart';


sqlImportLines() async {

  var result = await conn.query('select * from linesends');

  line.clear();

  for (var row in result) {

    line.add(LineSend(
        id: row[0].toString(),
        date: row[1],
        factory: row[2],
        observations: row[3],
        state: row[4]
    ));
  }
}
