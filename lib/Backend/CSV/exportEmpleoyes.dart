
import 'package:crud_factories/Backend/Global/files.dart';
import 'package:crud_factories/Objects/Empleoye.dart';
import 'package:csv/csv.dart';
import 'Export_general/export_csv.dart';


Future<bool> csvExportatorEmpleoyes(List<Empleoye> empleoyes) async {
  final rows = <List<dynamic>>[];

  rows.add(['id', 'name', 'idFactory']);

  for (final e in empleoyes) {
    rows.add([
      e.id,
      e.name,
      e.idFactory,
    ]);
  }

  final csv = const ListToCsvConverter(
    fieldDelimiter: ';',
  ).convert(rows);

  final success = await exportCsv(csv, file: fEmpleoyes.path);

  return !success;
}