import 'package:crud_factories/Objects/RouteCSV.dart';
import 'package:csv/csv.dart' show CsvToListConverter;

class csvParse {

  static List<RouteCSV> parseRoutes(String raw) {
    print('===== RAW =====');
    print(raw);
    print('===== FIN RAW =====');

    final data = CsvToListConverter(
      fieldDelimiter: ';',
    ).convert(raw);

    print('===== CSV PARSED =====');
    print('Filas: ${data.length}');

    for (final row in data) {
      print('ROW: $row');
    }

    print('===== FIN CSV PARSED =====');

    return data.skip(1).map((row) {
      if (row.length < 3) return null;

      return RouteCSV(
        id: row[0].toString(),
        name: row[1].toString().trim().toLowerCase(),
        route: row[2].toString().trim(),
      );
    }).whereType<RouteCSV>().toList();
  }
}