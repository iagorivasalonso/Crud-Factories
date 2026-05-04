import 'dart:typed_data';

import 'package:crud_factories/Alertdialogs/error.dart' show error;
import 'package:crud_factories/Alertdialogs/warning.dart' show warning;
import 'package:crud_factories/Backend/CSV/importRoutes.dart';
import 'package:crud_factories/Backend/CSV/loader.dart' show csvLoaderService;
import 'package:crud_factories/Backend/Global/files.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Objects/AppRoutesState.dart' show RouteFiles;
import 'package:crud_factories/Objects/RouteCSV.dart' show RouteCSV;
import 'package:crud_factories/generated/l10n.dart' show S;
import 'package:file_picker/file_picker.dart' show FilePicker, FileType;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:universal_html/html.dart' show File;

class RoutesProvider extends ChangeNotifier {

  final List<RouteCSV> _routes = [];

  RouteFiles? _files;
  RouteFiles? get files => _files;

  List<RouteCSV> get routes => List.unmodifiable(_routes);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
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
  Future<void> pickFile(BuildContext context, int index) async {
    if (_isLoading) return;
    _setLoading(true);

    try {
      final result = await FilePicker.platform.pickFiles(
        dialogTitle: S.of(context).select_file,
        type: FileType.custom,
        allowedExtensions: ['csv', 'exe'],
        withData: true,
      );

      if (result == null) return;

      final file = result.files.single;

      final routeValue = kIsWeb ? file.name : file.path;
      if (routeValue == null) return;

       updateRoute(index, routeValue);

      // SOLO auto-fill desde el primero
      if (index != 0) return;

      final confirm = await warning(
        context,
        S.of(context).other_fields_will_be_autofilled_do_you_want_to_continue,
      );

      if (!confirm) return;

      final (routesLoaded, files) = await csvLoaderService.loadInitialRoutes(
        context,
        routeValue,
      );

      if (routesLoaded.isEmpty) {
       await error(context, S.of(context).route_file_cannot_be_read);
        return;
      }

      _routes
        ..clear()
        ..addAll(routesLoaded);
      _files = files;

      notifyListeners();
    } finally {
      _setLoading(false);
    }
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