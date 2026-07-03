import 'package:crud_factories/Backend/Providers/LineSendProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:collection/collection.dart';

import 'package:crud_factories/Backend/Global/controllers/LineSend.dart';
import 'package:crud_factories/Backend/Providers/FactoryProvider.dart';
import 'package:crud_factories/Backend/Providers/SectorProvider.dart';
import 'package:crud_factories/Functions/manageState.dart';
import 'package:crud_factories/Objects/LineSend.dart';

class SendFromViewModel extends ChangeNotifier {


  List<LineSendController> controllers = [];

  List<bool> send = [];

  String sectorId = "0";

  final FactoryProvider factoryProvider;
  final SectorProvider sectorProvider;

  SendFromViewModel({
    required this.factoryProvider,
    required this.sectorProvider,
  });

  void init({
    required bool isEditing,
    List<LineSend> lines = const [],
  }) {
    if (isEditing) {
      _loadEdit(lines);
    } else {
      _loadNew();
    }
  }

  // -------------------------
  // SELECT
  // -------------------------

  void toggleSend(int index, bool value) {

    send[index] = value;
    notifyListeners();
  }

  void toggleAllSend(bool value) {
    for (int i = 0; i < send.length; i++) {
      send[i] = value;
    }
    notifyListeners();
  }

  // -------------------------
  // SECTOR
  // -------------------------

  void changeSector(String newSectorId) {
    if (sectorId == newSectorId) return;

    sectorId = newSectorId;
    _disposeControllers();
    _loadNew();
    notifyListeners();
  }

  // -------------------------
  // NEW MODE
  // -------------------------
  void _loadNew() {
    final factories =
    factoryProvider.factoriesBySector(sectorId);

    _disposeControllers();

    controllers = factories.map((f) {
      return LineSendController(
        id: "",
        date: "",
        factory: f.name,
        sector: f.sector,
        observations: TextEditingController(),
        state: LineSendState.prepared,
      );
    }).toList();

    send = List<bool>.filled(controllers.length, false);

    notifyListeners();
  }

  // -------------------------
  // CHANGUE FILTER
  // -------------------------

  void changueFilter (List<LineSend> linesSelected,String value, SendFilter? filter) {

    final lines = linesSelected.where((line) {
      switch(filter)
      {

        case null:
        // TODO: Handle this case.
          throw UnimplementedError();
        case SendFilter.date:
          return line.date == value;
        case SendFilter.company:
          return line.factory == value;
      }
    }).toList();

    _loadEdit(lines);

    notifyListeners();
  }


  // -------------------------
  // LOAD LINES
  // -------------------------
  void _loadEdit(List<LineSend> lines) {
    final sectors = sectorProvider.sectors;

    _disposeControllers();

    controllers = lines.map((line) {
      final sectorName = sectors
          .firstWhereOrNull((s) => s.id == line.sector)
          ?.name ?? "";

      return LineSendController(
        id: line.id,
        date: line.date,
        factory: line.factory,
        sector: sectorName,
        observations: TextEditingController(
          text: line.observations,
        ),
        state: manageState.stringToState(line.state),
      );
    }).toList();

    notifyListeners();
  }

  // -------------------------
  // RESET
  // -------------------------
  void reset() {
    send = List.filled(controllers.length, false);

    for (final c in controllers) {
      c.observations.clear();
      c.state = LineSendState.prepared;
    }

    notifyListeners();
  }

  // -------------------------
  // SAFE DISPOSE
  // -------------------------
  void _disposeControllers() {
    for (final c in controllers) {
      c.dispose();
    }
    controllers = [];
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }
}