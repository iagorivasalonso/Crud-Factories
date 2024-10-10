
import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Objects/Sector.dart';

Future<void> sqlCreateSector(List<Sector> sectors) async {


  try{

    for(int i = 0; i < sectors.length; i++)
    {
      String id = sectors[i].id;
      String name = sectors[i].name;

      var result = await conn.query(
          'insert into sectors (id,sector) values (?,?)',
          [id,name]);
    }

  } catch(SQLExeption) {
    print(SQLExeption);
  }
}

