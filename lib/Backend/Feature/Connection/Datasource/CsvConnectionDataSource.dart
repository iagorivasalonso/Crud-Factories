
import 'package:crud_factories/Backend/Feature/Connection/Datasource/IConnection_repository.dart' show IConnectionDataSource;
import 'package:crud_factories/Backend/Feature/Connection/Datasource/exportConections.dart';
import 'package:crud_factories/Backend/Feature/Connection/Datasource/importConections.dart';
import 'package:crud_factories/Objects/Conection.dart';

class CsvConnectionDataSource implements IConnectionDataSource {

  String? _path;
  bool _initialized = false;


  void init(String path) {
    _path = path;
    _initialized = true;
  }

  @override
  Future<List<Conection>> load() async {

    return await csvImportconnections(
        assetPath: _path
    );
  }

  @override
  Future<void> save(Conection connection) async {

    final connections = await load();

    final updated = [
      ...connections.where((c) => c.id != connection.id),
      connection,
    ];

    await csvExportatorconnections(
        updated,
        path: _path!
    );
  }

  @override
  Future<void> delete(String id) async {

    final connections = await load();

    final updated = connections.where((c) => c.id != id).toList();

    await csvExportatorconnections(
        updated,
        path: _path!
    );
  }
}