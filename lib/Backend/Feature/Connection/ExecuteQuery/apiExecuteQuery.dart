
import 'package:crud_factories/Backend/Feature/Connection/ExecuteQuery/IexecuteQuery.dart' show Iexecutequery;
import 'package:crud_factories/Backend/connectors_API/DbApi.dart' show DbApi;

class ApiExecuteQuery implements Iexecutequery {


  @override
  Future<List<Map<String, dynamic>>> query(
      String sql, [
        List<Object?>? params,
      ]) async {

    final res = await DbApi.queryData(sql, params);

    return List<Map<String, dynamic>>.from(res['data']);
  }

  @override
  Future<void> execute(
      String sql, [
        List<Object?>? params,
      ]) async {

    await DbApi.queryData(sql, params);
  }
}

