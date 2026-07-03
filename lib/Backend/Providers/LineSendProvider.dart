import 'package:crud_factories/Backend/Data/controlsMessagesError/errors.dart';
import 'package:crud_factories/Backend/Global/controllers/LineSend.dart' show LineSendController;
import 'package:crud_factories/Backend/Providers/FactoryProvider.dart' show FactoryProvider;
import 'package:crud_factories/Backend/Providers/SectorProvider.dart' show SectorProvider;
import 'package:crud_factories/Backend/Repositories/lineSendRepository.dart';
import 'package:crud_factories/Objects/Factory.dart';
import 'package:crud_factories/Objects/LineSend.dart' show LineSend, LineSendState, cardSend;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart' hide Factory;
import 'package:intl/intl.dart';


enum SendFilter {
    date,
    company
}

enum AddLineResult {
  success,
  duplicate,
  invalidData,
  error,
}
class LineSendProvider extends ChangeNotifier {

  LineSendProvider({
    required this.factoryProvider,
    required this.sectorProvider,
  });

  final FactoryProvider factoryProvider;
  final SectorProvider sectorProvider;


  LinesendRepository? repository;

  List<LineSend> _linesSends = [];


  SendFilter selectedFilter = SendFilter.date;

  List<LineSend> get LineSends => List.unmodifiable(_linesSends);

  Set<String> modifiedIds = {};



  // =========================
  // LOAD
  // =========================

  Future<void>load() async {

    try {
         final data = await _repo.load();

         _linesSends = data;
         notifyListeners();
    } catch(e) {
      print("Error load: $e");
      _linesSends = [];
      notifyListeners();
    }
  }

  // =========================
  //  SETLINES
  // =========================


  void setLines(List<LineSend> data) {
    _linesSends
      ..clear()
      ..addAll(List.from(data));

    notifyListeners();
  }

  // =========================
  //  ADDLINES
  // =========================
  void addLine(LineSend lineSend) {

    _linesSends.add(lineSend);

    notifyListeners();
  }
  Future<AddLineResult> addLines(List<LineSend> lines) async {
    try {
      int added = 0;

      for (final line in lines) {
        final exists = _linesSends.any((l) => l.id == line.id);

        if (exists) {
          continue; // 👈 ignoras duplicado
        }

        _linesSends.add(line);

        added++;
      }
      await _repo.insert(lines);
      notifyListeners();

      if (added == 0) {
        return AddLineResult.duplicate;
      }

      return AddLineResult.success;
    } catch (_) {
      return AddLineResult.error;
    }
  }

  // =========================
  //  CLEAR
  // =========================

  void clear() {
    _linesSends.clear();
    notifyListeners();
  }

  // =========================
  // GETREPO
  // =========================

  LinesendRepository get _repo {
      final l = repository;
      if (l == null) {
        throw Exception("Repository not initialized");
      }
      return l;
  }

  // =========================
  //   DISPLAY LINESSEND
  // =========================

  List<cardSend> displayLines({String shipmentText = "",  String? sectorId}){

    final lines = sectorId == "0"
        ? _linesSends
        : _linesSends.where((e) => e.sector == sectorId).toList();



         if(selectedFilter == SendFilter.date)
        {
             final dates = lines.map((e) => e.date).toSet().toList();


             dates.sort((a, b) {
               final dateA = DateFormat('dd-MM-yyyy').parse(a);
               final dateB = DateFormat('dd-MM-yyyy').parse(b);
               return dateA.compareTo(dateB);
             });

             return [
               for (int i = 0; i < dates.length; i++)
                 cardSend(
                   title: "${shipmentText} ${i + 1}",
                   description: dates.elementAt(i),
                 ),
             ];
        }

        final Map<String, int> factoryCount = {};

        for (final line in lines) {
          factoryCount[line.factory] =
              (factoryCount[line.factory] ?? 0) + 1;
        }

        return factoryCount.entries
            .map((entry) => cardSend(
            title: entry.key,
            description: entry.value.toString()
        )).toList();
   }

  // =========================
  // CHANGE LINE
  // =========================

  void changeFilter(SendFilter filter) {
    selectedFilter = filter;
    notifyListeners();
  }

  // =========================
  // EXITS LINE
  // =========================

  bool exist(LineSend line, {LineSend? exclude}) {

    return  _linesSends.any((l) {
      if (exclude != null && l.id == exclude.id) return false;
      return l.id == line.id;
    });

  }

  // ==============================
  // SECTOR HAS LINES
  // ==============================

  bool sectorHasLines ({
    required String sectorId, required List<Factory> factories
 
    }){


    if (factories.isEmpty) return false;
    
    return factories.any(
        (factory) => getLines(factory: factory.name).isNotEmpty);
  }

  // ==============================
  // SEARCH
  // ==============================

  List<LineSend> getLines({
    String? date,
    String? factory,
    String? sectorId,
  }) {
    return _linesSends.where((line) {
      return
        (sectorId == null || sectorId == "0" || line.sector == sectorId) &&
            (date == null || line.date == date) &&
            (factory == null || line.factory == factory);
    }).toList();
  }

  LineSend? getId(String id) {

    try{
      return _linesSends.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  List<cardSend> searchCards(String search,  {
  String shipmentText = "Envio",
    String? sectorId,
  }) {

      if(search.trim().isEmpty)
      {
        return displayLines(
          shipmentText: shipmentText,
          sectorId: sectorId,
        );
      }

      final text = search.toLowerCase();

      bool matchesDate(String dateStr) {
        try {
          final date = DateFormat('dd-MM-yyyy').parse(dateStr);

          final dayNoZero = DateFormat('d', 'es_ES').format(date);
          final dayWithZero = DateFormat('dd', 'es_ES').format(date);
          final month = DateFormat('MMMM', 'es_ES').format(date).toLowerCase();
          final year = DateFormat('yyyy', 'es_ES').format(date);

          final formatted1 = '$dayNoZero de $month de $year';
          final formatted2 = '$dayWithZero de $month de $year';

          return formatted1.contains(text) ||
              formatted2.contains(text) ||
              year.contains(text) ||
              dateStr.toLowerCase().contains(text);
        } catch (_) {
          return false;
        }
      }

      return displayLines(shipmentText: shipmentText).where((card) {
        if (selectedFilter == SendFilter.date) {
          return matchesDate(card.description) ||
              card.title.toLowerCase().contains(text);
        }

        return card.title.toLowerCase().contains(text) ||
            card.description.toLowerCase().contains(text);
      }).toList();


  }

  // ==============================
  // FILTERED LINES
  // ==============================
  List<LineSend> filteredLines(
      String sectorId,
      List<Factory> factories,
      ) {
    final factoryNames = factories
        .where((f) => f.sector == sectorId)
        .map((f) => f.name)
        .toSet();

    return _linesSends.where((line) {
      return factoryNames.contains(line.factory);
    }).toList();
  }

  void enrichWithFactories(List<Factory> factories) async{
    final factoryMap = {
      for (final f in factories) f.name: f.sector,
    };

    for (final line in _linesSends) {
      line.sector = factoryMap[line.factory];
      print(line.sector);
    }

    notifyListeners();
  }

  // ==============================
  // UPDATE LINES
  // ==============================

  void updateLines(String id, {String? state, String? observations}) {

      final index = _linesSends.indexWhere((e) => e.id == id);
      if (index == -1) return;

      bool hasChanged = false;

      final line = _linesSends[index];

      if(state != null && line.state != state)
      {
         line.state = state;
         hasChanged = true;
      }

      if(observations != null && line.observations != observations)
      {
        line.observations = observations;
        hasChanged = true;
      }

      if (!hasChanged) return;


        modifiedIds.add(id);
      notifyListeners();
  }


  //=============================
  // SAVE CHANGES
  //==============================

  Future <bool> saveChanges () async {

      if(modifiedIds.isEmpty) return true;

      final linesToUpdate = _linesSends
             .where((l) => modifiedIds.contains(l.id))
             .toList();

      final success = await repository!.upload(linesToUpdate);

      if(!success)
      {
        modifiedIds.clear();
        notifyListeners();
        return true;
      }

      return false;
  }


  // ==============================
  // DELETE LINES STATE RETURNED
  // ==============================

  Future<DeleteResult> removeReturned({String? factory, String? date}) async {

       try {

         final before = _linesSends.length;

         final linesToDelete = _linesSends.where((line) {
           final isReturned = line.state == LineSendState.returned.name;
           final matchFactory = factory == null || line.factory == factory;
           final matchDate = date == null || line.date == date;

           return isReturned && matchFactory && matchDate;
         }).toList();
         final deleted =  before - _linesSends.length;

         if (deleted == 0) {
           return DeleteResult.notFound;
         }
         await repository!.delete(linesToDelete);

         notifyListeners();

         return DeleteResult.success;

       } catch (_) {
          return DeleteResult.error;
       }
  }

  // =========================
  //  RELOAD REPO
  // =========================

  Future<void> setRepositoryAndReload(LinesendRepository repo) async {
    repository = repo;
    _linesSends = [];
    notifyListeners();

    await load();
  }

}