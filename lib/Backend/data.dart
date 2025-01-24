import 'dart:io';

import 'package:crud_factories/Objects/Conection.dart';
import 'package:crud_factories/Objects/Empleoye.dart';
import 'package:crud_factories/Objects/Factory.dart';
import 'package:crud_factories/Objects/Mail.dart';
import 'package:crud_factories/Objects/LineSend.dart';
import 'package:crud_factories/Objects/RouteCSV.dart';
import 'package:crud_factories/Objects/Sector.dart';
import 'package:fluent_ui/fluent_ui.dart';

List<Sector> sectors = [];
List<Factory> allFactories = [];
List<Factory> factoriesSector = [];
List<Empleoye> empleoyes = [];
List<Mail> mails =[];
List<LineSend> allLines = [];
List<LineSend> lineSector = [];
List<Conection> conections = [];
List<dynamic> routesCSV = [];
List<RouteCSV> routesManage = [];
List<String> fileContent = [];
List<String> errorFiles =[];
List<String> dateSends = [];
TextEditingController controllerSearchSend = TextEditingController();

List <String> SQLRoutes = [];
List <String> allRoutes = [];
List <String> currentRoutes = [];
var conn;

String BaseDateSelected = "Nuevo";
int itenSelect = -1;
int itenSelection = 0;
int subIten1Select = -1;
int subIten2Select = -1;
bool saveChanges = false;

File fRoutes = File("");
File fSectors = File("");
File fFactories = File("");
File fEmpleoyes = File("");
File fLines = File("");
File fMails = File("");
File fConections = File("");

var fServer;