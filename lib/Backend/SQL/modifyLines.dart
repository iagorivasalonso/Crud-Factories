import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Functions/manageState.dart';
import 'package:crud_factories/Objects/LineSend.dart';
import 'package:flutter/material.dart';

Future<void> sqlModifyLines(List<LineSend> lineSelected, BuildContext context) async {

  try{

      for (int i = 0; i <lineSelected.length; i++)
      {
        String id = lineSelected[i].id;
        String date = lineSelected[i].date;
        String factory = lineSelected[i].factory;
        String observations = lineSelected[i].observations;
        String state = lineSelected[i].state;

        var result = await conn.query('update linesends set date=?,factory=?, observations=?,  state=? where id=?', [date, factory, observations,state, id]);
      }

  } catch(SQLExeption){

  }
}

