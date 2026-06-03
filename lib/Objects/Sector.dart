import 'package:crud_factories/Objects/BaseEntity.dart';


class Sector extends BaseEntity {

  final String id;
  final String name;

  Sector ({
    required this.id,
    required this.name,
  });
}