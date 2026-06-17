

import 'package:crud_factories/Backend/Feature/Employee/IEmployeeDataSource.dart';
import 'package:crud_factories/Backend/Feature/Employee/exportEmployee.dart';
import 'package:crud_factories/Backend/Feature/Employee/importEmployee.dart' show csvImportEmpleoyees;
import 'package:crud_factories/Objects/Empleoye.dart';

class Csvemployeedatasource  implements IEmployeeDataSource {

  final String path;

 Csvemployeedatasource(this.path);


  @override
  Future<List<Empleoyee>> load() async{

    return await csvImportEmpleoyees(
         assetPath: this.path,
    );
  }

  @override
  Future<void> delete(String id) async {
       final employees = await load();

       final update = employees.where((e) => e.id != id).toList();

       await csvExportatorEmpleoyes(
           update,
           path: this.path);
  }

  @override
  Future<void> insert(Empleoyee empleoyee) async {
    final employees = await load();

    final update = [
        ...employees.where((e) => e.id != empleoyee.id),
        empleoyee,
    ];

    await csvExportatorEmpleoyes(
    update,
    path: this.path);
  }

  @override
  Future<void> upload(Empleoyee empleoyee) {
    // TODO: implement upload
    throw UnimplementedError();
  }

  @override
  Future<void> deleteByFactory(String factoryId) async {

    final employees = await load();

    final update = employees.where((e) => e.idFactory == factoryId).toList();

    await csvExportatorEmpleoyes(
    update,
    path: this.path);
  }

}