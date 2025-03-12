import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Functions/manageState.dart';
import 'package:crud_factories/Objects/LineSend.dart';
import 'package:fluent_ui/fluent_ui.dart';

Future<void> sqlCreateLine(List<LineSend> lines, BuildContext context) async {

  try{

      for(int i = 0; i < lines.length; i++)
      {
         String id = lines[i].id;
         String date = lines[i].date;
         String factory = lines[i].factory;
         String state = manageState.parseState(lines[i].state.toString(),context,false).name;
         String observations = lines[i].observations;

         var result = await conn.query(
             'insert into lineSends (id,date,factory,state,observations) values (?,?,?,?,?)',
             [id,date,factory,state,observations]);
    }

  } catch(SQLExeption){

  }
}

