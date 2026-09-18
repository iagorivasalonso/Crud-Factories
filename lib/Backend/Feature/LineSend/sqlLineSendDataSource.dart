import 'package:crud_factories/Backend/Feature/Connection/ExecuteQuery/IexecuteQuery.dart';
import 'package:crud_factories/Backend/Feature/LineSend/ILineSendDataSource.dart';
import 'package:crud_factories/Objects/LineSend.dart';

class SqlLinesendDatasource implements ILineSendDatasource{

  final Iexecutequery executeQuery;
  final String userId;

  SqlLinesendDatasource({
     required this.executeQuery,
     required this.userId
  });

  @override
  Future<void> delete(List<LineSend> l) async{

    for (final line in l)
    {
      await executeQuery.execute(
          'DELETE FROM linesends WHERE id = ? AND user_id = ?',
          [line.id,userId]
      );
    }
  }

  @override
  Future<List<LineSend>> load() async {

    final result = await executeQuery.query(
       'SELECT id, date, factory,observations,state FROM linesends WHERE userId = ?'
     );

    return result.map((row) => LineSend(
        id: row['id']?.toString() ?? '',
        date: row['date']?.toString() ?? '',
        factory: row['factory']?.toString() ?? '',
        observations: row['observations']?.toString() ?? '',
        state: row['state']?.toString() ?? '',
    )).toList();
  }

  @override
  Future<void> insert(List<LineSend> l) async{

     for (final line in l) {

         await executeQuery.query(
           'INSERT INTO lineSends (id, date, factory, state, observations) VALUES (?, ?, ?, ?,? , ?)',
           [line.id, line.date, line.factory, line.state, line.observations,userId]
         );
     }

  }

  @override
  Future<bool> upload(List<LineSend> l) async {

    if (l.isEmpty) return false;

    for (final line in l) {

      await executeQuery.query(
        'UPDATE lineSends SET date = ?,factory = ?,state = ?,observations = ? WHERE id = ?  AND user_id = ?',
        [line.date, line.factory, line.state, line.observations, line.id,userId],
      );
    }

    return true;
  }

  @override
  Future<void> save(List<LineSend> lines) async {

    for (final line in lines) {

      await executeQuery.query(
          'INSERT INTO lineSends (id, date, factory, state, observations) VALUES (?, ?, ?, ?, ?, ?)',
          [
            line.id, line.date, line.factory, line.state, line.observations, userId
          ]
      );
    }

  }

}
