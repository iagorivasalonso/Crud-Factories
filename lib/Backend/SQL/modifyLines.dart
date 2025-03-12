import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Functions/manageState.dart';
import 'package:crud_factories/Objects/LineSend.dart';

Future<void> sqlModifyLines(List<LineSend> lineSelected) async {

  try{
/*
      for (int i = 0; i <lineSelected.length; i++)
      {
        String id = lineSelected[i].id;
        String date = lineSelected[i].date;
        String factory = lineSelected[i].factory;
        String observations = lineSelected[i].observations;
        String state = parseState(lineSelected[i].state.toString()).name;

        var result = await conn.query('update linesends set date=?,factory=?, observations=?,  state=? where id=?', [date, factory, observations,state, id]);
      }
*/
  } catch(SQLExeption){

  }
}

