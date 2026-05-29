
import 'package:crud_factories/Backend/Feature/Sector/exportSectors.dart' show csvExportatorSectors;
import 'package:crud_factories/Backend/Feature/Sector/importSectors.dart' show csvImportSectors;
import 'package:crud_factories/Backend/Feature/Sector/IsectorDataSource.dart';
import 'package:crud_factories/Objects/Sector.dart';

class CsvSectorDataSource  implements ISectorDataSource{

  final String path;

  CsvSectorDataSource(this.path);

  @override
  Future<List<Sector>> load() async {

    return await csvImportSectors(
      assetPath: this.path,
    );
  }

  @override
  Future<void> delete(String id) async {
       final sectors = await load();

    final updated = sectors.where((s) => s.id != id).toList();
    await csvExportatorSectors(updated,path: this.path);
  }



  @override
  Future<void> insert(Sector sector) async {
    final sectors = await load();

    final updated = [
      ...sectors.where((s) => s.id != sector.id),
      sector,
    ];
      // CSV no guarda 1 elemento aislado → reescribe todo

    await csvExportatorSectors(
      updated,
      path: this.path,
    );

  }

  @override
  Future<void> upload(Sector sector) {
    // TODO: implement upload
    throw UnimplementedError();
  }
  
}