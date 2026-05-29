


import 'package:crud_factories/Backend/Feature/Connection/ExecuteQuery/IexecuteQuery.dart' show Iexecutequery;
import 'package:mysql1/mysql1.dart' show MySqlConnection;

class sqlExecuteQuery implements Iexecutequery{

  final MySqlConnection connection;

  sqlExecuteQuery(this.connection);

  @override
  Future<List<Map<String, dynamic>>> query(
      String sql, [
        List<Object?>? params,
      ]) async {

    final result = await connection.query(sql, params ?? []);

    return result.map((row) => row.fields).toList();
  }

  @override
  Future<void> execute(
      String sql, [
        List<Object?>? params,
      ]) async {
    await connection.query(sql, params ?? []);
  }
  
}