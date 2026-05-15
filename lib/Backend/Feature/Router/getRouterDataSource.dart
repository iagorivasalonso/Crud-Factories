
import 'package:crud_factories/Backend/Feature/Router/CsvRouterDataSource.dart' show CsvRouterDataSource;
import 'package:crud_factories/Backend/Feature/Router/IRouterDataSource.dart';

IRouterDataSource getRouterDataSource (){

  return CsvRouterDataSource("");
}