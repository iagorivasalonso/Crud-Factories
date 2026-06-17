import 'package:crud_factories/Backend/CSV/Export_general/export_csv_io.dart';
import 'package:crud_factories/Objects/Empleoye.dart' show Empleoyee;
import 'package:csv/csv.dart' show ListToCsvConverter;

Future<bool> csvExportatorEmpleoyes(List<Empleoyee> empleoyees, {required String path}) async {

  final rows = <List<dynamic>>[];

  rows.add(['id', 'name', 'idFactory']);

  for (final e in empleoyees) {
    rows.add([
      e.id,
      e.name,
      e.idFactory,
    ]);
  }

  final csv = const ListToCsvConverter(
    fieldDelimiter: ';',
  ).convert(rows);

  final success = await exportCsv(
      csv,
      file: path);

  return !success;
}