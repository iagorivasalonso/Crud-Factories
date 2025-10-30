


import 'package:crud_factories/Objects/Conection.dart';
import 'package:crud_factories/Objects/Empleoye.dart';
import 'package:crud_factories/Objects/Factory.dart';
import 'package:crud_factories/Objects/LineSend.dart';
import 'package:crud_factories/Objects/Mail.dart';
import 'package:crud_factories/Objects/RouteCSV.dart';
import 'package:crud_factories/Objects/Sector.dart';

class ListController {

  final List<RouteCSV> routesNew;
  final List<Sector> sectorsNew;
  final List<Empleoye> empleoyesNew;
  final List<Mail> mailsNew;
  final List<LineSend> linesNew;
  final List<Conection> conectionsNew;
  final List<Factory> factoriesNew;

  ListController ({
    required this.routesNew,
    required this.sectorsNew,
    required this.empleoyesNew,
    required this.mailsNew,
    required this.linesNew,
    required this.conectionsNew,
    required this.factoriesNew
});
}