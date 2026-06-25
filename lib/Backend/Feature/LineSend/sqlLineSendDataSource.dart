import 'package:crud_factories/Backend/Feature/Connection/ExecuteQuery/IexecuteQuery.dart';
import 'package:crud_factories/Backend/Feature/LineSend/ILineSendDataSource.dart';
import 'package:crud_factories/Objects/LineSend.dart';

class SqlLinesendDatasource implements ILineSendDatasource{

  final Iexecutequery executeQuery;

  SqlLinesendDatasource({
     required this.executeQuery
  });

  @override
  Future<void> delete(List<LineSend> l) async{

    for (final line in l)
    {
      await executeQuery.execute(
          'DELETE FROM linesends WHERE id =?',
          [line.id]
      );
    }
  }

  @override
  Future<List<LineSend>> load() async {

    final result = await executeQuery.query(
       'SELECT id, date, factory,observations,state FROM linesends'
     );

    return result.map((row) => LineSend(
        id: row['id'].toString(),
        date: row['date'],
        factory: row['factory'],
        observations: row['observations'],
        state: row['state'],
    )).toList();
  }
  @override
  Future<void> insert(List<LineSend> l) async{

     for (final line in l) {

         await executeQuery.query(
           'INSERT INTO lineSends (id, date, factory, state, observations) VALUES (?, ?, ?, ?, ?)',
           [
              line.id,
              line.date,
              line.factory,
              line.observations,
              line.state
           ]
         );
     }

  }

  @override
  Future<void> upload(List<LineSend> l) async {

    for (final line in l) {

      await executeQuery.query(
          'UPDATE  lineSends SET date, factory, state, observations WHERE id=?) VALUES (?, ?, ?, ?, ?)',
          [
            line.id,
            line.date,
            line.factory,
            line.observations,
            line.state
          ]
      );
    }
  }

}