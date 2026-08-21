import 'package:crud_factories/Objects/Conection.dart' show Conection;
import 'package:crud_factories/Objects/Empleoye.dart' show Empleoyee;
import 'package:crud_factories/Objects/Factory.dart' show Factory;
import 'package:crud_factories/Objects/LineSend.dart' show LineSend;
import 'package:crud_factories/Objects/Mail.dart' show Mail;
import 'package:crud_factories/Objects/RouteCSV.dart' show RouteCSV;
import 'package:crud_factories/Objects/Sector.dart' show Sector;

class ImportData {

  List<RouteCSV> routes;
  List<Conection> connections;
  List<Sector> sectors;
  List<Factory> factories;
  List<Empleoyee> employees;
  List<LineSend> lines;
  List<Mail> mails;

  ImportData({
    this.routes = const [],
    this.connections = const [],
    this.sectors = const [],
    this.factories = const [],
    this.employees = const [],
    this.lines = const [],
    this.mails = const [],
  });
}
