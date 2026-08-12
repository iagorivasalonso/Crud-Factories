


import 'package:crud_factories/Objects/BaseEntity.dart';

class Empleoyee extends BaseEntity {


  String name;
  String idFactory;

  Empleoyee ({
    required super.id,
    required this.name,
    required this.idFactory
  });

  @override
  String toString() {
    return 'Empleoye{id: $id, name: $name, idFActory: $idFactory}';
  }
}