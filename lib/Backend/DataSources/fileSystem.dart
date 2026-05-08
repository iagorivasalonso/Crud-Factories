
import 'package:crud_factories/Backend/CSV/FileReader.dart';
import 'package:crud_factories/Backend/CSV/csvReader.dart';
import 'package:crud_factories/Backend/CSV/csvParse.dart';
import 'package:crud_factories/Backend/DataSources/AppDataSource.dart';
import 'package:crud_factories/Backend/DataSources/RoutesBundle.dart' show RoutesBundle;
import 'package:crud_factories/Objects/buldRouteFiles.dart';

class filesDataSource implements AppDataSource {

  final String path;

  filesDataSource(this.path);

  @override
  Future<RoutesBundle> loadRoutes() async {

    final raw = await FileReader.fromFile(path);

    final routes = csvParse.parseRoutes(raw);

    final files = RouteFilesBuilder.buildRouteFiles(routes);

    return RoutesBundle(routes, files);
  }
}