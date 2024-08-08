import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Objects/Factory.dart';

sqlImportFactories() async {

  try {

    var result = await conn.query('select * from factories');

    for (var row in result) {


      String  allEmp=row[13].toString();
      List<String> emp=allEmp.split(",");

      factories.add(Factory(
          id: row[0].toString(),
          name: row[1],
          highDate: row[2],
          thelephones: [row[3],row[4]],
          mail: row[5],
          web: row[6],
          address: {
            'street': row[7],
            'number': row[8],
            'apartament': row[9],
            'city': row[10],
            'postalCode':row[12],
            'province':row[11]
          },
          contacts: emp

      ));
    }
  }catch(Exeption){

  }




}
