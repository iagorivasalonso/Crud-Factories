import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Objects/Sector.dart';

Future<void> sqlModifySector(List<Sector> sectors) async {

  try{

    String id = sectors[0].id;
    String name = sectors[0].name;

   var result = await conn.query('update sectors set sector=? where id=?', [name, id]);

  } catch(SQLExeption) {
    
  }
}
