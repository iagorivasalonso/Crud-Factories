
import 'package:crud_factories/Backend/CSV/Export_general/export_csv.dart';
import 'package:crud_factories/Objects/LineSend.dart';
import 'package:csv/csv.dart';

Future<bool> csvExportatorLineSend(List<LineSend>lineSend , {required String path}) async {

  final rows = <List<dynamic>>[];

  rows.add(['id','date','factory','observations','state']);

  for(final l in lineSend) {
    rows.add([l.id,l.date,l.factory,l.observations,l.state]);
  }

  final csv = const ListToCsvConverter(
    fieldDelimiter: ';',
  ).convert(rows);

  final success = await exportCsv(
      csv,
      file: path
  );

  return success;
}