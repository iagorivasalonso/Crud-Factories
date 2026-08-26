import 'package:crud_factories/Objects/RouteCSV.dart';
import 'package:csv/csv.dart';

class csvParse {
  static List<RouteCSV> parseRoutes(String raw) {

    final data = CsvToListConverter(
      fieldDelimiter: ';',
      eol: '\n',
    ).convert(raw);


    final result = <RouteCSV>[];

    for (final row in data) {
      if (row.length < 3) {
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



    return result;
  }
}