import 'package:crud_factories/Objects/Conection.dart';
import 'package:crud_factories/Objects/Empleoye.dart';
import 'package:crud_factories/Objects/Factory.dart';
import 'package:crud_factories/Objects/Mail.dart';
import 'package:crud_factories/Objects/LineSend.dart';
import 'package:crud_factories/Objects/Sector.dart';
import 'package:fluent_ui/fluent_ui.dart';

List<Sector> sectors = [];
List<Factory> allFactories = [];
List<Factory> factoriesSector = [];
List<Empleoye> empleoyes = [];
List<Mail> mails =[];
List<LineSend> allLines = [];
List<LineSend> lineSector = [];
List<String> fileContent =[];
List<String> dateSends =[];
List<Conection> conections = [];

TextEditingController controllerSearchSend = TextEditingController();

var conn;

String BaseDateSelected = "Nuevo";
int itenSelect = -1;
int itenSelection = 0;
int subIten1Select = -1;
int subIten2Select = -1;
bool saveChanges = false;
