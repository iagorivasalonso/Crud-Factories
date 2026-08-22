import 'package:crud_factories/Backend/Feature/Connection/Datasource/IConnection_repository.dart' show IConnectionDataSource;
import 'package:crud_factories/Backend/Feature/Connection/Datasource/exportConections.dart' show csvExportatorconnections;
import 'package:crud_factories/Backend/Feature/Connection/Datasource/importConections.dart' show csvImportconnections;
import 'package:crud_factories/Objects/Conection.dart';


class CsvConnectionDataSource implements IConnectionDataSource {
  String? _path;
  bool _initialized = false;

  void init(String path) {
    _path = path;
    _initialized = true;
  }

  String get path {
    if (!_initialized || _path == null) {
      throw StateError(
        'CsvConnectionDataSource no ha sido inicializado. '
            'Llama a init(path) antes de usarlo.',
      );
    }

    return _path!;
  }

  @override
  Future<List<Conection>> load() async {
    return csvImportconnections(
      path: path,
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
      path: path,
    );
  }

  @override
  Future<void> delete(String id) async {
    final connections = await load();

    final updated = connections
        .where((c) => c.id != id)
        .toList();

    await csvExportatorconnections(
      updated,
      path: path,
    );
  }

  @override
  Future<void> saveAll(List<Conection> connections) async {
    await csvExportatorconnections(
      connections,
      path: path,
    );
  }
}
