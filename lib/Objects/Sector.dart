import 'package:crud_factories/Objects/BaseEntity.dart';


class Sector extends BaseEntity {

  String id;
  String name;

  Sector ({
    required this.id,
    required this.name,
  });
}