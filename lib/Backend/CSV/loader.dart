import 'dart:convert';
import 'dart:io';
import 'package:crud_factories/Alertdialogs/defaultData.dart';
import 'package:crud_factories/Backend/Global/files.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Objects/RouteCSV.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../Global/controllers/Conection.dart';
import '../Global/controllers/List.dart';
import '../Global/controllers/Router.dart';
import 'ImportGeneral/AppFile.dart';
import 'ImportGeneral/importAppFile.dart';
import 'loader.dart';
import 'package:path/path.dart' as p;

class csvLoaderService {


  static Future<List<RouteCSV>> loadInitialRoutes(BuildContext context,[String? newRoutePath]) async {
   clearAllData();

   Directory? parentDir;
   var fileRoutes='';

   if (!kIsWeb) {
     parentDir = Directory.current.parent;
   }
       fileRoutes= 'routes.csv';

   final String defaultRoutesPath =
   parentDir?.path != null
       ? p.join(parentDir!.path,fileRoutes)
       : '';

    routeFirst = defaultRoutesPath;

    final String pathToLoad = await resolveRoutesPath(context,defaultRoutesPath);


   namesRoutesOrdened = [S.of(context).routes,S.of(context).connections,S.of(context).server,S.of(context).sectors,S.of(context).companies,S.of(context).employees,S.of(context).lines, S.of(context).mails];

   if (pathToLoad == 'fail') {
     return [];
   }
   else
   {
     routeFirst = pathToLoad;
   }


    fRoutes = File(pathToLoad);


     List<RouteCSV> loadedRoutes = await _createData(pathToLoad);


    if (loadedRoutes.isEmpty) {
      errorFiles.add(S.of(context).route_file_cannot_be_read);
      return [];
    }
    else
    {


      loadedRoutes  = reorderRouter(namesRoutesOrdened, loadedRoutes);
    }

    return loadedRoutes;
  }

  static Future<bool> loadRemainingRoutes(BuildContext context, List<RouteCSV> routesCSV, [bool recharged= false]) async {

    final cantidadRoutes=routesCSV.length;
    bool isCorrect= true;

    for(int i = 1; i <cantidadRoutes; i++)
    {
      final route = routesCSV[i].route;

      if (route.isEmpty || recharged ==true && routesCSV[i].name=='Conexiones') continue;

      try {
        AppFile file;
        if(route.startsWith('assets/'))
        {
           file = fromAsset(route);
        }
        else
        {
          file = fromPath(route);
        }

        await importAppFile(context, file);
      } catch (e, s) {

        String array =routesCSV[i].name;
        errorFiles.add("${S.of(context).file_not_found} $array");
        isCorrect=false;
      }

    }

    return isCorrect; // Devuelve true si todo bien
  }

  static Future<String> resolveRoutesPath (BuildContext context, [String? newRoutePath]) async {

    final String userPath = newRoutePath!;

    final String assetPath = 'assets/dataDefault/routes.csv';

    if(newRoutePath.isNotEmpty)
    {
          final file = File(newRoutePath);
          if (await file.exists())
          {
            return newRoutePath;
          }
          else
          {
             bool errData = await defaultData(context);

             if(errData==true)
             {
               useDataDefault = true;
               return assetPath;
             }
             else
             {
               return 'fail';
             }
          }
    }

    if(kIsWeb)
        return assetPath;

    final file = File(userPath);

    if(await file.exists())
            return userPath;

    print(assetPath);
    return assetPath;

  }
  static Future<List<RouteCSV>> _createData(String path) async {

    final String rawData = path.startsWith('assets/')
        ? await rootBundle.loadString(path)
        : await File(path).readAsString();

    final List<List<dynamic>> listData = CsvToListConverter(fieldDelimiter: ';').convert(rawData);

    List<RouteCSV> routes = [];

    for (final row in listData) {
      // Seguridad básica
      if (row.length < 3) continue;

      routes.add(RouteCSV(
        id: row[0].toString(),
        name: row[1],
        route: row[2],
      ));
    }


    return routes;

  }
  static AppFile fromAsset(String assetPath) {
    return AppFile(
      name: p.basename(assetPath),
      assetPath: assetPath,
    );
  }

  static AppFile fromPath(String path) {
    return AppFile(
      name:  p.basename(path),
      path: path,
    );
  }

  static AppFile fromPlatformFile(PlatformFile file) {
    return AppFile(
      name: file.name,
      path: file.path,
      bytes: file.bytes,
    );
  }

  static void createControllerList(List<RouteCSV> initialRoutes) {

    routeControllers = List.generate(namesRoutesOrdened.length, (i) => RouterController(
      name: TextEditingController(text: namesRoutesOrdened[i]),
      router:  routesCSV.isNotEmpty && routesCSV[i].route.isNotEmpty
              ? TextEditingController(text: routesCSV[i].route)
              : TextEditingController(text: ''),
    ));

    listController = new ListController(
        routesNew: [],
        sectorsNew: [],
        empleoyesNew: [],
        mailsNew: [],
        linesNew: [],
        conectionsNew: [],
        factoriesNew: []);

  }

  static void createControllerBD() {

    controlerConex = connectionControler(
        namebd: TextEditingController(),
        hostbd: TextEditingController(),
        portbd: TextEditingController(),
        userbd: TextEditingController(),
        passbd: TextEditingController()
    );

  }
}

List<RouteCSV> reorderRouter ( List<String> orderRoutes, List<RouteCSV> routesCsv) {

   final routeMap = {
     for(var r in routesCsv)
        if(r.name.isNotEmpty)
           r.name:r
   };

   final reordered = orderRoutes.map((name) {
     final existingRoute = routeMap[name];
     if (existingRoute != null) {
       return existingRoute;
     } else {
       return RouteCSV(name: name, id: '', route: '');
     }
   }).toList();

   return reordered;
}

void clearAllData() {
  routesCSV.clear();
  errorFiles.clear();

  // ⚠️ TODAS las listas que llenan los CSV
  allFactories.clear();
  empleoyes.clear();
  sectors.clear();
  conections.clear();
  mails.clear();
  allLines.clear();
}