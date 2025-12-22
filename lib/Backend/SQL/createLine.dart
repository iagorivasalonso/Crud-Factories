import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Functions/manageState.dart';
import 'package:crud_factories/Objects/LineSend.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart' as foundation;

Future<void> sqlCreateLine(List<LineSend> lines, BuildContext context) async {

  try{

      for(int i = 0; i < lines.length; i++)
      {
         String id = lines[i].id;
         String date = lines[i].date;
         String factory = lines[i].factory;
         String state = manageState.parseState(lines[i].state.toString(),context,false);
         String observations = lines[i].observations;

         if (!foundation.kIsWeb)
         var result = await executeQuery.query(
             'insert into lineSends (id,date,factory,state,observations) values (?,?,?,?,?)',
             [id,date,factory,state,observations]);
    }

  } catch(SQLExeption){

  }
}

