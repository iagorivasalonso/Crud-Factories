import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Objects/Empleoye.dart';
import 'package:flutter/foundation.dart' as foundation;

Future<void> sqlDeleteEmpleoyes(List<Empleoye> idsDelete) async {

  try{

    String id = " ";

       for (int i = 0; i<idsDelete.length; i++)
       {
           id = idsDelete[i].id;

        if (!foundation.kIsWeb)
          var result = await executeQuery.query('delete from empleoyes where id=? ',[id]);
       }

  } catch(SQLExeption) {

  }
}