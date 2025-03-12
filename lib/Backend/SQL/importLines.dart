import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Functions/manageState.dart';
import 'package:crud_factories/Objects/LineSend.dart';
import 'package:fluent_ui/fluent_ui.dart';


sqlImportLines(BuildContext context) async {

  try {

    var result = await conn.query('select * from linesends');

    for (var row in result)
    {
      allLines.add(LineSend(
          id: row[0].toString(),
          date: row[1],
          factory: row[2],
          observations: row[3],
          state: manageState.parseState(row[4],context,true),)
      );
    }

  }catch(Exeption){
print(Exeption);
  }


}
