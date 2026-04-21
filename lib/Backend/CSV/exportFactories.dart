import 'package:crud_factories/Backend/CSV/Export_general/export_csv_io.dart';
import 'package:crud_factories/Backend/Global/files.dart' show fFactories;
import 'package:crud_factories/Objects/Factory.dart' show Factory;
import 'package:csv/csv.dart' show ListToCsvConverter;

Future<bool> csvExportatorFactories(List<Factory> factories) async {
  final rows = <List<dynamic>>[];

  rows.add([
    'id',
    'name',
    'highDate',
    'sector',
    'telephone1',
    'telephone2',
    'mail',
    'web',
    'street',
    'number',
    'apartament',
    'city',
    'postalCode',
    'province',
  ]);

  for (final f in factories) {
    rows.add([
      f.id,
      f.name,
      f.highDate,
      f.sector,
      f.thelephones.isNotEmpty ? f.thelephones[0] : '',
      f.thelephones.length > 1 ? f.thelephones[1] : '',
      f.mail,
      f.web,
      f.address['street'],
      f.address['number'],
      f.address['apartament'],
      f.address['city'],
      f.address['postalCode'],
      f.address['province'],
    ]);
  }

  final csv = const ListToCsvConverter(
    fieldDelimiter: ';',
  ).convert(rows);

  final success = await exportCsv(csv, file: fFactories.path);

  return !success;
}