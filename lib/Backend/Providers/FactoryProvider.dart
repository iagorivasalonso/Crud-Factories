import 'dart:io';

import 'package:crud_factories/Backend/CSV/importFactories.dart';
import 'package:crud_factories/Backend/Global/files.dart';
import 'package:crud_factories/generated/l10n.dart' show S;
import 'package:flutter/cupertino.dart' show BuildContext;
import 'package:flutter/foundation.dart' hide Factory;
import 'package:crud_factories/Objects/Factory.dart';

import '../Global/list.dart' show errorFiles;

class FactoryProvider extends ChangeNotifier {

  final List<Factory> _factories = [];

  List<Factory> get factories => List.unmodifiable(_factories);

  void setFactories(List<Factory> newFactories) {
    _factories
      ..clear()
      ..addAll(List.from(newFactories));

    notifyListeners();
  }

  void addFactory(Factory factory) {
    _factories.add(factory);
    notifyListeners();
  }

  void updateFactory(int index, Factory factory) {
    _factories[index] = factory;
    notifyListeners();
  }

  void deleteBySector(String sectorId) {
    _factories.removeWhere((f) => f.sector == sectorId);
    notifyListeners();
  }

  List<String> getIdsBySector(String sectorId) {
    return _factories
        .where((f) => f.sector == sectorId)
        .map((f) => f.id)
        .toList();
  }

  void delete(String id) {
    _factories.removeWhere((f) => f.id == id);
    notifyListeners();
  }

  void clear() {
    _factories.clear();
    notifyListeners();
  }

  Future<void> importFactory(BuildContext context, {
    required File file,
    Uint8List? bytes,
    String? content,
    String? assetPath,
  }) async {
    try {
      final imported = await csvImportFactories(
        file: fFactories,
        bytes: bytes,
        content: content,
        assetPath: assetPath,
      );

      _factories.addAll(imported);
    } catch (e) {
      final s = S.of(context);

      final msg = e.toString().toLowerCase();

      if (msg.contains("not found") ||
          msg.contains("archivo") ||
          msg.contains("asset")) {
        errorFiles.add("${s.file_not_found} ${s.company}");
      } else {
        errorFiles.add("${s.file_format_error} ${s.company}");
      }
    }
  }
}