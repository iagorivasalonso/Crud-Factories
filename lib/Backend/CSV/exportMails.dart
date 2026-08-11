
import 'package:crud_factories/Backend/Global/files.dart';
import 'package:crud_factories/Objects/Mail.dart';
import 'package:csv/csv.dart';

import 'Export_general/export_csv_io.dart';


Future<bool> csvExportatorMails(List<Mail> mails) async {
  final rows = <List<dynamic>>[];

  rows.add([
    'id',
    'address',
    'company',
    'password',
  ]);

  for (final m in mails) {
    rows.add([
      m.id,
      m.address,
      m.company,
      m.password,
    ]);
  }

  final csv = const ListToCsvConverter(
    fieldDelimiter: ';',
  ).convert(rows);

  final success = await exportCsv(csv, file: fMails.path);

  return !success;
}