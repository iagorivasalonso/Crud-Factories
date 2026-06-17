
import 'package:crud_factories/Backend/Feature/Connection/ExecuteQuery/IexecuteQuery.dart';
import 'package:crud_factories/Backend/Feature/Factory/IFactoryDataSource.dart' show IFactoryDataSource;
import 'package:crud_factories/Objects/Factory.dart';

class SqlFactoryDataSource implements IFactoryDataSource {

  final Iexecutequery executeQuery;

  SqlFactoryDataSource({
    required this.executeQuery
  });

  @override
  Future<void> delete(String id) async {

      await executeQuery.execute(
        'DELETE FROM factories WHERE id=?',
        [id],
      );
  }

  @override
  Future<List<Factory>> load() async{

      final result = await executeQuery.query(
        'SELECT id, name, highDate, sector, telephone1, telephone2, mail, web, address, '
                 'number, apartment,city, province, postcode '
                                                    'FROM factories'
      );

      return result.map((row) => Factory(
        id: row['id'].toString(),
        name: row['name']?.toString() ?? '',
        highDate: row['highDate']?.toString() ?? '',
        sector: row['sector'] ?? '',
        thelephones: [
          row['telephone1']?.toString() ?? '',
          row['telephone2']?.toString() ?? '',
        ],
        mail: row['mail']?.toString() ?? '',
        web: row['web']?.toString() ?? '',
        address: Address(
          street: row['address']?.toString() ?? '',
          number: row['number']?.toString() ?? '',
          apartment: row['apartment']?.toString(),
          city: row['city']?.toString() ?? '',
          province: row['province']?.toString() ?? '',
          postcode: row['postcode']?.toString() ?? '',
        ),
      )).toList();
  }

  @override
  Future<void> insert(Factory f) async {

    await executeQuery.query('INSERT INTO factories values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)',
      [f.id.toString(),f.name,f.highDate,f.sector,f.thelephones[0],f.thelephones[1],f.mail,f.web,
       f.address.street,f.address.number,f.address.apartment,f.address.city,f.address.province,f.address.postcode]
    );
  }


  @override
  Future<void> upload(Factory f) async{

    await executeQuery.query('UPDATE factories SET name=?, highDate=?, sector=?, thelephones=?, mail=?, web=?, '
        'street=?, number=?, apartament=?, city=?, postalCode=?, province=? WHERE id=?',
        [f.name,f.highDate,f.sector,f.thelephones[0],f.thelephones[1],f.mail,f.web,
        f.address.street,f.address.number,f.address.apartment, f.address.city,f.address.province,f.address.postcode,f.id.toString()]
    );
  }
}
