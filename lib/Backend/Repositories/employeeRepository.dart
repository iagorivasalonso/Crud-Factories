
import 'package:crud_factories/Backend/Feature/Employee/IEmployeeDataSource.dart';
import 'package:crud_factories/Objects/Empleoye.dart';

class EmployeeRepository {

  final IEmployeeDataSource dataSource;

  EmployeeRepository(this.dataSource);

  Future<void> insert(Empleoyee empleoyee) {

    return dataSource.insert(empleoyee);
  }

  Future<void> delete(String id) {

    return dataSource.delete(id);
  }

  Future<void> deleteByFactory(String factoryId) {
    return dataSource.deleteByFactory(factoryId);
  }

  Future<List<Empleoyee>> load() {

    return dataSource.load();
  }
}