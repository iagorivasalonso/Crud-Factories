import 'package:crud_factories/Backend/CSV/Export_general/export_csv_io.dart';
import 'package:crud_factories/Backend/Global/files.dart' show fLines;
import 'package:crud_factories/Objects/LineSend.dart' show LineSend;
import 'package:csv/csv.dart' show ListToCsvConverter;

Future<bool> csvExportatorLines(List<LineSend> listSend) async {
  final rows = <List<dynamic>>[];

  rows.add([
    'id',
    'date',
    'factory',
    'observations',
    'state',
  ]);

  for (final l in listSend) {
    rows.add([
      l.id,
      l.date,
      l.factory,
      l.observations,
      l.state,
    ]);
  }

  final csv = const ListToCsvConverter(
    fieldDelimiter: ';',
  ).convert(rows);
  print("PATH: ${fLines.path}");

  final success = await exportCsv(csv, file: fLines.path);
  print("SUCCESS: $success");
  return !success;
}