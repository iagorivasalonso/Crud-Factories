import 'package:crud_factories/Backend/CSV/importEmpleoyes.dart';
import 'package:crud_factories/Backend/Global/files.dart';
import 'package:crud_factories/generated/l10n.dart' show S;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:crud_factories/Objects/Empleoye.dart';
import 'package:universal_html/html.dart' show File;

import '../Global/list.dart';

class EmployeeProvider extends ChangeNotifier {

  final List<Empleoye> _employees = [];

  List<Empleoye> get employees => List.unmodifiable(_employees);

  void setEmployees(List<Empleoye> data) {
    _employees
      ..clear()
      ..addAll(data);

    notifyListeners();
  }

  void addEmployee(Empleoye employee) {
    _employees.add(employee);
    notifyListeners();
  }

  void deleteById(String id) {
    _employees.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  void deleteByFactory(String factoryId) {
    _employees.removeWhere((e) => e.idFactory == factoryId);
    notifyListeners();
  }

  void deleteByFactories(List<String> factoryIds) {
    _employees.removeWhere((e) => factoryIds.contains(e.idFactory));
    notifyListeners();
  }

  void clear() {
    _employees.clear();
    notifyListeners();
  }

  Future<void> importEmployee(BuildContext context, {
    required File file,
    Uint8List? bytes,
    String? content,
    String? assetPath,
  }) async {

    try {
      final imported = await csvImportEmpleoyees(
        file: fEmpleoyes,
        bytes: bytes,
        content: content,
        assetPath: assetPath,
      );

      _employees.addAll(imported); // ✔ estado del provider
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
  }

}