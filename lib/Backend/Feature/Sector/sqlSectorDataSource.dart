

import 'package:crud_factories/Backend/Feature/Connection/ExecuteQuery/IexecuteQuery.dart' show Iexecutequery;
import 'package:crud_factories/Objects/Sector.dart';
import 'ISectorDataSource.dart';

class SqlSectorDataSource  implements ISectorDataSource{

  final Iexecutequery executeQuery;
  final String userId;

  SqlSectorDataSource({
    required this.executeQuery,
    required this.userId
  });

  @override
  Future<void> delete(String id) async {

    await executeQuery.execute(
      'DELETE FROM sectors WHERE id = ? AND user_id = ?',
      [id,userId],
    );
  }

  @override
  Future<List<Sector>> load() async {

    final result = await executeQuery.query(
      'SELECT id, sector FROM sectors WHERE userId = ?',
      [userId]
    );

    return result.map((row) => Sector(
      id: row['id']?.toString() ?? '',
      name: row['sector']?.toString() ?? '',
    )).toList();

  }

  @override
  Future<void> insert(Sector s) async {

    await executeQuery.execute(
      'INSERT INTO sectors VALUES (?, ?, ?)',
      [s.id, s.name,userId],
    );
  }

  @override
  Future<void> upload(Sector s) async {

    await executeQuery.execute(
      'UPDATE sectors SET sector = ? WHERE id = ? AND user_id = ?',
      [s.name, s.id, userId],
    );
  }

  @override
  Future<void> save(List<Sector> sectors) async {

   for(final sector in sectors) {

      await executeQuery.execute(
        'INSERT INTO sectors VALUES (?, ?,?)',
         [
           sector.id, sector.name, userId
        ],
      );

    }
  }
}



