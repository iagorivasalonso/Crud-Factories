import 'package:crud_factories/Objects/BaseEntity.dart';


class Sector extends BaseEntity {

  final String name;

  Sector ({
    required super.id,
    required this.name,
  }) ;
}