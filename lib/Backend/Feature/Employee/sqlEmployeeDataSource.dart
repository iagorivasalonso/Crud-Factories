
import 'package:crud_factories/Backend/Feature/Connection/ExecuteQuery/IexecuteQuery.dart';
import 'package:crud_factories/Backend/Feature/Employee/IEmployeeDataSource.dart' show IEmployeeDataSource;
import 'package:crud_factories/Objects/Empleoye.dart';

class SqlEmployeeDataSource implements  IEmployeeDataSource {

  final Iexecutequery executeQuery;

  SqlEmployeeDataSource({
      required this.executeQuery
  });

  @override
  Future<void> delete(String id) async {

    await executeQuery.execute(
      'DELETE FROM employees WHERE id=?',
      [id],
    );
  }
  @override
  Future<List<Empleoyee>> load() async {

    final result = await executeQuery.query(
      'SELECT id, name,idFactory FROM employees',
    );

    return result.map((row) => Empleoyee(
      id: row['id'].toString(),
      name: row['name'],
      idFactory: row['idFactory'],
    )).toList();

  }

  @override
  Future<void> insert(Empleoyee e) async {

    await executeQuery.execute(
        'INSERT INTO employees VALUES (?, ?)',
        [e.name,e.idFactory,e.id]
    );
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