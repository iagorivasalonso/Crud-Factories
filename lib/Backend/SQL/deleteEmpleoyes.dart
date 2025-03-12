import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Objects/Empleoye.dart';

Future<void> sqlDeleteEmpleoyes(List<Empleoye> idsDelete) async {

  try{

    String id = " ";

       for (int i = 0; i<idsDelete.length; i++)
       {
           id = idsDelete[i].id;
          var result = await conn.query('delete from empleoyes where id=? ',[id]);
       }

  } catch(SQLExeption) {

  }
}