import 'package:crud_factories/Objects/RouteCSV.dart';
import 'package:csv/csv.dart';

class csvParse {
  static List<RouteCSV> parseRoutes(String raw) {
    print('===== PARSE ROUTES =====');
    print('RAW LENGTH: ${raw.length}');
    print('RAW:');
    print(raw);

    final data = CsvToListConverter(
      fieldDelimiter: ';',
      eol: '\n',
    ).convert(raw);

    print('FILAS: ${data.length}');

    for (final row in data) {
      print('ROW: $row | LENGTH: ${row.length}');
    }

    final result = <RouteCSV>[];

    for (final row in data) {
      if (row.length < 3) {
        print('DESCARTADA: $row');
        continue;
      }

      result.add(
        RouteCSV(
          id: row[0].toString().trim(),
          name: row[1].toString().trim(),
          route: row[2].toString().trim(),
        ),
      );
    }

    print('RESULTADO: ${result.length}');
    print('===== FIN PARSE ROUTES =====');

    return result;
  }
}