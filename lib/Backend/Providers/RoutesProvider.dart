import 'dart:typed_data';

import 'package:crud_factories/Backend/CSV/importRoutes.dart';
import 'package:crud_factories/Backend/Global/files.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Objects/AppRoutesState.dart' show RouteFiles;
import 'package:crud_factories/Objects/RouteCSV.dart' show RouteCSV;
import 'package:crud_factories/generated/l10n.dart' show S;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:universal_html/html.dart' show File;

class RoutesProvider extends ChangeNotifier {

  final List<RouteCSV> _routes = [];

  RouteFiles? _files;


  RouteFiles? get files => _files;

  RouteFiles? state;


  List<RouteCSV> get routes => List.unmodifiable(_routes);

  void setState(RouteFiles newState) {
    state = newState;
    notifyListeners();
  }

  void setRoutes(List<RouteCSV> data) {
    _routes
      ..clear()
      ..addAll(data);

    notifyListeners();
  }


  void setFiles(RouteFiles files) {
    _files = files;
    notifyListeners();
  }

  void updateRoute(int index, String newpath) {
    if (index < 0 || index >= _routes.length) return;


    _routes[index] = RouteCSV(
      id: _routes[index].id,
      name: _routes[index].name,
      route: newpath,
    );

    notifyListeners();
  }

  void addRoute(RouteCSV route) {
    _routes.add(route);
    notifyListeners();
  }

  void delete(RouteCSV route) {
    _routes.remove(route);
    notifyListeners();
  }

  void clear() {
    _routes.clear();
    notifyListeners();
  }

  Future<void> importRoutes(BuildContext context, {
    required File file,
    Uint8List? bytes,
    String? content,
    String? assetPath,
  }) async {
    try {
      final imported = await csvImportRoutes(
        file: fRoutes,
        bytes: bytes,
        content: content,
        assetPath: assetPath,
      );

      _routes.addAll(imported); // ✔ estado del provider
    } catch (e) {
      final s = S.of(context);

      final msg = e.toString().toLowerCase();

      if (msg.contains("not found") ||
          msg.contains("archivo") ||
          msg.contains("asset")) {
        errorFiles.add("${s.file_not_found} ${s.routes}");
      } else {
        errorFiles.add("${s.file_format_error} ${s.routes}");
      }
    }

    notifyListeners();
  }

}