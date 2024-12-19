import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Objects/Empleoye.dart';

Future<void> sqlDeleteEmpleoyes(List<Empleoye> empleoyesDelete) async {

  try{

    String id = " ";

       for (int i = 0; i<empleoyesDelete.length; i++)
       {
           id = empleoyesDelete[i].id;
          var result = await conn.query('delete from empleoyes where id=? ',[id]);
       }

  } catch(SQLExeption) {

  }
}