import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Objects/LineSend.dart';


sqlImportLines() async {

  try {

    var result = await conn.query('select * from linesends');

    for (var row in result) {

      allLines.add(LineSend(
          id: row[0].toString(),
          date: row[1],
          factory: row[2],
          observations: row[3],
          state: row[4]
      ));
    }

  }catch(Exeption){

  }


}
