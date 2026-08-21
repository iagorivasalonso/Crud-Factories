

import 'package:crud_factories/Backend/Feature/Connection/ExecuteQuery/IexecuteQuery.dart' show Iexecutequery;
import 'package:crud_factories/Objects/Sector.dart';
import 'ISectorDataSource.dart';

class SqlSectorDataSource  implements ISectorDataSource{

  final Iexecutequery executeQuery;

  SqlSectorDataSource({
    required this.executeQuery
  });

  @override
  Future<void> delete(String id) async {

    await executeQuery.execute(
      'DELETE FROM sectors WHERE id=?',
      [id],
    );
  }

  @override
  Future<List<Sector>> load() async {

    final result = await executeQuery.query(
      'SELECT id, sector FROM sectors',
    );

    return result.map((row) => Sector(
      id: row['id']?.toString() ?? '',
      name: row['sector']?.toString() ?? '',
    )).toList();

  }

  @override
  Future<void> insert(Sector s) async {

    await executeQuery.execute(
      'INSERT INTO sectors VALUES (?, ?)',
      [s.id, s.name],
    );
  }

  @override
  Future<void> upload(Sector s) async {

    await executeQuery.execute(
       'UPDATE sectors SET sector = ? where id=?',
        [s.name,s.id]
    );
  }

  @override
  Future<void> save(List<Sector> sectors) async {

   for(final sector in sectors) {

      await executeQuery.execute(
        'INSERT INTO sectors VALUES (?, ?)',
         [
           sector.id,
           sector.name
        ],
      );

    }
  }
}



