import 'package:csv/csv.dart' show ListToCsvConverter;

String buildCsv({
  required List<String> headers,
  required List<List<dynamic>> rows,
}) {
  final data = <List<dynamic>>[];

  data.add(headers);
  data.addAll(rows);

  return const ListToCsvConverter(
    fieldDelimiter: ';',
  ).convert(data);
}