
import 'package:crud_factories/Backend/Feature/Connection/ExecuteQuery/IexecuteQuery.dart'
    show Iexecutequery;
import 'package:crud_factories/Backend/Feature/Connection/ExecuteQuery/ITransacionalExecuteQuery.dart'
    show ITransactionalExecuteQuery;
import 'package:mysql1/mysql1.dart'
    show MySqlConnection, TransactionContext;



class sqlExecuteQuery implements ITransactionalExecuteQuery {

  final MySqlConnection connection;

  sqlExecuteQuery(this.connection);

  @override
  Future<List<Map<String, dynamic>>> query(String sql, [
    List<Object?>? params,
  ]) async {
    final result = await connection.query(sql, params ?? []);
    return result.map((r) => r.fields).toList();
  }

  @override
  Future<void> execute(String sql, [
    List<Object?>? params,
  ]) async {
    await connection.query(sql, params ?? []);
  }

  @override
  Future<void> transaction(
      Future<void> Function(Iexecutequery executor) action,) async {
    await connection.transaction<void>((txn) async {
      final executor = _SqlTransactionExecuteQuery(txn);
      await action(executor);
    });
  }
}

class _SqlTransactionExecuteQuery implements Iexecutequery {

  final TransactionContext transaction;

  _SqlTransactionExecuteQuery(this.transaction);

  @override
  Future<List<Map<String, dynamic>>> query(
      String sql, [
        List<Object?>? params,
      ]) async {
    final result = await transaction.query(sql, params ?? []);
    return result.map((r) => r.fields).toList();
  }

  @override
  Future<void> execute(
      String sql, [
        List<Object?>? params,
      ]) async {
    await transaction.query(sql, params ?? []);
  }
}