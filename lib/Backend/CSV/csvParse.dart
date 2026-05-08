import 'package:crud_factories/Objects/RouteCSV.dart';
import 'package:csv/csv.dart' show CsvToListConverter;

class csvParse {

  static List<RouteCSV> parseRoutes(String raw) {

    final List<List<dynamic>> data = CsvToListConverter(fieldDelimiter: ';').convert(raw);

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