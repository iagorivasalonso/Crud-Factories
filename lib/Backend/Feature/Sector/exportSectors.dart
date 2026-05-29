import 'package:crud_factories/Objects/Sector.dart' show Sector;
import 'package:csv/csv.dart';

import '../../CSV/Export_general/export_csv_io.dart';

Future<bool> csvExportatorSectors(List<Sector> sectors, {required String path}) async {

  final rows = <List<dynamic>>[];

  rows.add(['id', 'name']);

  for (final s in sectors) {
    rows.add([s.id, s.name]);
  }

  final csv = const ListToCsvConverter(
    fieldDelimiter: ';',
  ).convert(rows);

  final success = await exportCsv(
    csv,
    file: path,
  );

  return success;
}