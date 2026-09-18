
import 'package:crud_factories/Backend/Feature/Connection/ExecuteQuery/IexecuteQuery.dart';
import 'package:crud_factories/Backend/Feature/Employee/IEmployeeDataSource.dart' show IEmployeeDataSource;
import 'package:crud_factories/Objects/Empleoye.dart';

class SqlEmployeeDataSource implements  IEmployeeDataSource {

  final Iexecutequery executeQuery;
  final String userId;

  SqlEmployeeDataSource({
      required this.executeQuery,
      required this.userId
  });

  @override
  Future<void> delete(String id) async {

    await executeQuery.execute(
      'DELETE FROM employees WHERE id= ?  AND user_id = ?',
      [id,userId],
    );
  }
  @override
  Future<List<Empleoyee>> load() async {

    final result = await executeQuery.query(
      'SELECT id, name,idFactory FROM employees WHERE userId = ?',
    );

    return result.map((row) => Empleoyee(
      id: row['id']?.toString() ?? '',
      name: row['name']?.toString() ?? '',
      idFactory: row['idFactory']?.toString() ?? '',
    )).toList();

  }

  @override
  Future<void> insert(Empleoyee e) async {

    await executeQuery.execute(
        'INSERT INTO employees VALUES (?, ?,?)',
        [e.name,e.idFactory,e.id,userId]
    );
  }



  @override
  Future<void> save(List<Empleoyee> employees)  async {

    for (final employee in employees) {

      await executeQuery.execute(
        'INSERT INTO employees VALUES (?, ?, ?, ?)',
        [
          employee.id, employee.name, employee.idFactory, userId
        ],
      );

    }

  }

  @override
  Future<void> upload(Empleoyee empleoyee) {
    // TODO: implement upload
    throw UnimplementedError();
  }
//esto solo se usa en CSV
  @override
  Future<void> deleteByFactory(String factoryId) {
    // TODO: implement deleteByFactory
    throw UnimplementedError();
  }

}
