

import 'package:crud_factories/Backend/Global/files.dart';
import 'package:crud_factories/Objects/Sector.dart';
import 'package:csv/csv.dart';
import 'Export_general/export_csv.dart';


Future<bool> csvExportatorSectors(List<Sector> sectors) async {
  final rows = <List<dynamic>>[];

  rows.add([
    'id',
    'name',
  ]);

  for (final s in sectors) {
    rows.add([
      s.id,
      s.name,
    ]);
  }

  final csv = const ListToCsvConverter(
    fieldDelimiter: ';',
  ).convert(rows);

  final success = await exportCsv(csv, file: fSectors.path);

  return !success;
}