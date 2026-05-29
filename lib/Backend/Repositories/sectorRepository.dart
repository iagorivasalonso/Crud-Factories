
import 'package:crud_factories/Backend/Feature/Sector/IsectorDataSource.dart';
import 'package:crud_factories/Objects/Sector.dart' show Sector;

class SectorRepository {

  final ISectorDataSource datasource;

  SectorRepository(this.datasource);

  Future<void> insert(
      Sector sector,
      ) {

    return datasource.insert(
      sector,
    );
  }

  Future<void> delete(
      String id,
      ) {

    return datasource.delete(
      id,
    );
  }

  Future<List<Sector>> load() {

    return datasource.load();
  }

  Future<void> upload(Sector sector) async {

      return datasource.upload(sector);
  }
}