import 'package:crud_factories/Backend/CSV/Export_general/csv_builder.dart' show buildCsv;
import 'package:crud_factories/Backend/Global/files.dart';
import 'package:crud_factories/Objects/Conection.dart';
import 'package:csv/csv.dart';
import 'Export_general/export_csv.dart';

Future<bool> csvExportatorConections(List<Conection> connections) async {

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

  final success = await exportCsv(csv, file: fConections.path);

  return !success;
}
