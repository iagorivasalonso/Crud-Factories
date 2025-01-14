import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Objects/LineSend.dart';

Future<void> sqlCreateLine(List<LineSend> lines) async {

  try{

      for(int i = 0; i < lines.length; i++)
      {
         String id = lines[i].id;
         String date = lines[i].date;
         String factory = lines[i].factory;
         String state = lines[i].state;
         String observations = lines[i].observations;

         var result = await conn.query(
             'insert into lineSends (id,date,factory,state,observations) values (?,?,?,?,?)',
             [id,date,factory,state,observations]);
    }

  } catch(SQLExeption){

  }
}

