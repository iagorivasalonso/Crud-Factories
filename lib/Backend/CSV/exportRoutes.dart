import 'package:crud_factories/Backend/Global/files.dart' show fRoutes;
import 'package:crud_factories/Objects/RouteCSV.dart' show RouteCSV;
import 'package:csv/csv.dart';


import 'Export_general/export_csv_io.dart';

Future<bool> csvExportatorRoutes(List<RouteCSV> routes) async {
  final rows = <List<dynamic>>[];

  rows.add([
    'id',
    'name',
    'route',
  ]);

  for (final r in routes) {
    rows.add([
      r.id,
      r.name,
      r.route,
    ]);
  }

  final csv = const ListToCsvConverter(
    fieldDelimiter: ';',
  ).convert(rows);

  final success = await exportCsv(csv, file: fRoutes.path);

  return !success;
}