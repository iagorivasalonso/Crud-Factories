import 'package:crud_factories/Objects/Conection.dart';
import 'package:crud_factories/Objects/Factory.dart';
import 'package:crud_factories/Objects/Mail.dart';
import 'package:crud_factories/Objects/LineSend.dart';
import 'package:crud_factories/Objects/Sector.dart';

int itenSelect = -1;
int itenSelection = 0;
int subIten1Select = -1;
int subIten2Select = -1;

String BaseDateSelected ="Nuevo";
var conn;

List<Factory> factories = [];
List<Factory> factoriesSector = [];
List<Sector> sectors = [];
List<Mail> mails =[];
List<LineSend> line = [];
List<String> fileContent =[];
List<String> dateSends =[];
List<Conection> conections = [];
