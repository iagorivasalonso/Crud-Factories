import 'package:crud_factories/Backend/Global/variables.dart';

Future<void> sqlDeleteLines(List<String> idsDelete) async {

  try{
    String id = " ";

    for (int i = 0; i<idsDelete.length; i++)
    {
      id = idsDelete[i];
      var result = await conn.query('delete from lineSends where id=? ',[id]);
    }

  } catch(SQLExeption) {

  }
}