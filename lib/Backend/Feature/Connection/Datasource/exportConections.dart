import 'package:crud_factories/Backend/Export_general/csv_builder.dart' show buildCsv;
import 'package:crud_factories/Backend/Export_general/export_csv_io.dart';
import 'package:crud_factories/Objects/Conection.dart';
import 'package:csv/csv.dart';


Future<bool> csvExportatorconnections(List<Conection> connections,{required String path}) async {

  final rows = connections.map((c) => [
    c.id,
    c.database,
    c.host,
    c.port,
    c.user,
    c.password,
  ]).toList();

  final csv = buildCsv(
    headers: ['id', 'database', 'host', 'port', 'user', 'password'],
    rows: rows,
  );

  final success = await exportCsv(
      csv,
      file: path
  );

  return !success;
}

