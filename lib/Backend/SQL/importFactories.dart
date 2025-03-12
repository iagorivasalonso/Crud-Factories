import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Objects/Factory.dart';

sqlImportFactories() async {

  try {

    var result = await conn.query('select * from factories');

    for (var row in result)
    {
      allFactories.add(Factory(
          id: row[0].toString(),
          name: row[1],
          highDate: row[2],
          sector: row[3].toString(),
          thelephones: [row[4],row[5]],
          mail: row[6],
          web: row[7],
          address: {
            'street': row[8],
            'number': row[9],
            'apartament': row[10],
            'city': row[11],
            'postalCode':row[12],
            'province':row[13]
          },
      ));
    }
  }catch(Exeption){

    print(Exeption);
  }




}
