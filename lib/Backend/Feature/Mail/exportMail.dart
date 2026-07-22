
import 'package:crud_factories/Backend/CSV/Export_general/export_csv.dart';
import 'package:crud_factories/Objects/Mail.dart';
import 'package:csv/csv.dart';

Future<bool> csvExportatorMails(List<Mail>mail , {required String path}) async {

  final rows = <List<dynamic>>[];

  rows.add(['id','mail','host','port','secure','password']);

  for(final m in mail) {
    rows.add([m.id,m.mail,m.host,m.port,m.secure,m.password]);
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