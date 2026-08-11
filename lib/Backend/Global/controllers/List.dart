import 'package:crud_factories/Objects/Conection.dart';
import 'package:crud_factories/Objects/Empleoye.dart';
import 'package:crud_factories/Objects/Factory.dart';
import 'package:crud_factories/Objects/LineSend.dart';
import 'package:crud_factories/Objects/Mail.dart';
import 'package:crud_factories/Objects/RouteCSV.dart';
import 'package:crud_factories/Objects/Sector.dart';

class ListController {

  List<RouteCSV> routesNew;
  List<Sector> sectorsNew;
  List<Empleoyee> employeesNew;
  List<Mail> mailsNew;
  List<LineSend> linesNew;
  List<Conection> connectionsNew;
  List<Factory> factoriesNew;

  ListController ({
    required this.routesNew,
    required this.sectorsNew,
    required this.employeesNew,
    required this.mailsNew,
    required this.linesNew,
    required this.connectionsNew,
    required this.factoriesNew
});
}