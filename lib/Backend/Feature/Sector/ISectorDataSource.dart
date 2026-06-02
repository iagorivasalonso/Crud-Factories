import 'package:crud_factories/Objects/Sector.dart';

abstract class ISectorDataSource {

  Future<List<Sector>> load();

  Future<void> insert(Sector sector);

  Future<void> delete(String id);

  Future<void> upload(Sector sector);

}