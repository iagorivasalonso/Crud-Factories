abstract class Iexecutequery  {

  Future<List<Map<String, dynamic>>> query(
      String sql, [
        List<Object?>? params,
      ]);


  Future<void> execute(
      String sql, [
        List<Object?>? params,
      ]);
}