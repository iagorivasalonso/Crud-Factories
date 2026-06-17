

import 'package:crud_factories/Objects/Empleoye.dart';


abstract class IEmployeeDataSource {

   Future<List<Empleoyee>> load();

   Future<void> insert(Empleoyee empleoyee);

   Future<void> delete(String id);

   Future<void> upload(Empleoyee empleoyee);

  Future<void> deleteByFactory(String factoryId);

}