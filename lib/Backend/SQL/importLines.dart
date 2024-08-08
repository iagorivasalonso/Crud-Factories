import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Objects/LineSend.dart';
import 'package:mysql1/src/single_connection.dart';


sqlImportLines() async {

  try {

    var result = await conn.query('select * from linesends');

    for (var row in result) {

      line.add(LineSend(
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
