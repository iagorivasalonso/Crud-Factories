import 'package:crud_factories/Backend/DataSources/RoutesBundle.dart' show RoutesBundle;


abstract class AppDataSource {

  Future<RoutesBundle> loadRoutes();
}