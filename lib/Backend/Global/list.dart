import 'package:crud_factories/Objects/Conection.dart';
import 'package:crud_factories/Objects/Empleoye.dart';
import 'package:crud_factories/Objects/Factory.dart';
import 'package:crud_factories/Objects/LineSend.dart';
import 'package:crud_factories/Objects/Mail.dart';
import 'package:crud_factories/Objects/RouteCSV.dart';
import 'package:crud_factories/Objects/Sector.dart';

import '../../Frontend/Views/listSends.dart';

List<Sector> sectors = [];
List<Factory> allFactories = [];
List<Factory> factoriesSector = [];
List<Empleoye> empleoyes = [];
List<Mail> mails =[];
List<LineSend> allLines = [];
List<LineSend> lineSector = [];
List<cardSend> resultSend = [];
List<Conection> conections = [];
List<String> namesRoutesOrdened = [];
List<RouteCSV> routesCSV = [];
List<String> fileContent = [];
List<String> errorFiles =[];
List<String> dateSends = [];
List <String> SQLRoutes = [];
List <String> allRoutesOrdened = [];
List <String> currentRoutes = [];