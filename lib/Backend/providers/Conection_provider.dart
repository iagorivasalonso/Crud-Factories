import 'package:crud_factories/Backend/CSV/exportConections.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Backend/SQL/manageSQl.dart';
import 'package:crud_factories/Objects/Conection.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:mysql1/mysql1.dart';

import '../../Alertdialogs/confirm.dart';
import '../../Alertdialogs/error.dart';
import '../../Functions/createId.dart';
import '../../generated/l10n.dart';

enum ConnectionStatus {

  none,
  disconnected,
  connected,
}

enum ConnectionViewMode {
   normal,
   editing,
}
class ConectionProvider extends ChangeNotifier {

  Conection? selected;

   ConnectionViewMode viewMode = ConnectionViewMode.normal;

  ConnectionStatus get status {
    if(selected == null) return ConnectionStatus.none;
    return executeQuery == null
        ? ConnectionStatus.disconnected
        : ConnectionStatus.connected;
  }

  String editButtonLabel(BuildContext context) {
     return viewMode == ConnectionViewMode.editing
         ? S.of(context).back
         : S.of(context).edit;
  }
  String action1Label(BuildContext context) {
    if(viewMode == ConnectionViewMode.editing)
         return S.of(context).acept;

     switch(status) {
       case ConnectionStatus.none:
         return S.of(context).newFemale;
       case ConnectionStatus.disconnected:
         return S.of(context).connect;
       case ConnectionStatus.connected:
         return S.of(context).disconnect;
     }

  }

  String action2Label(BuildContext context) {

    if(viewMode == ConnectionViewMode.editing)
    {
      return S.of(context).cancel;
    }
    else
    {
      return  S.of(context).delete;
    }

  }

  String actionEditLabel(BuildContext context) {
    return viewMode == ConnectionViewMode.editing
        ? S.of(context).back
        : S.of(context).edit;
  }


  Future<void> selectConnection(Conection? c, BuildContext context) async {
    if (status == ConnectionStatus.connected) {
      await disconnet(context);
    }
    selected = c;
    notifyListeners();
  }

  Future<void> connect (BuildContext context) async {
    if (selected == null) return;

    final settings = ConnectionSettings(
      host: selected!.host,
      port: int.parse(selected!.port),
      user: selected!.user,
      password: selected!.password,
      db: selected!.database,
    );

    try {
      executeQuery = await MySqlConnection.connect(settings);
      BaseDateSelected = selected!.database;

      selectedDb =  selected!.database;

      confirm(context, '${S
          .of(context)
          .is_connected_to} ${selected!.database}');
      notifyListeners();
    } catch (e) {
      error(context, S
          .of(context)
          .sql_error);
    }
  }

  bool toggleEditMode(ConectionProvider provider) {

    if (executeQuery == null) return false;

    viewMode =
    viewMode == ConnectionViewMode.editing
        ? ConnectionViewMode.normal
        : ConnectionViewMode.editing;

    notifyListeners();
    return true;
  }
    Future<void>disconnet(BuildContext context) async {

      await executeQuery?.close();
      selectedDb='';
      executeQuery = null;

      notifyListeners();

      if (context.mounted) {
        confirm(context, S.of(context).has_closed_the_connection);
      }
    }

    void clearSelection() {

      selected = null;
      executeQuery = null;

      notifyListeners();
    }

    // =================
    //    CRUD
   // ==================

  Map<String, Conection> get _conectionsMap => {for (var c in conections) c.database: c};

  Future<String?> create(BuildContext context, Conection cNew) async {

      if (_conectionsMap.containsKey(cNew.database)) {
        return 'La conexión ya existe';
      }

      return await _withConnection(cNew, (conn) async {
        final err = await createDB(context, cNew.database, conn);
        if (err.isNotEmpty) return err;

        conections.add(cNew);
        _updateList(conections, newSelected: cNew);
        return null;

      });
    }

  Future<String?> update(BuildContext context,Conection old, Conection cNew) async {

    if (!_conectionsMap.containsKey(old.database)) {
      return 'no se encontro la conecxion';
    }

    return await _withConnection(cNew, (conn) async {
      final err = await editDB(context, old.database, cNew.database);
      if (err.isNotEmpty) return err;

      final index = conections.indexWhere((c) => c.database == old.database);
      conections[index] = cNew;
      _updateList(conections, newSelected: cNew);
      return null;

    });
  }


  Future<String?> delete(BuildContext context, Conection toDelete,  {bool deleteSQL = false}) async {

    if (!_conectionsMap.containsKey(toDelete.database)) {
      return 'no se encontro la conecxion';
    }

    return await _withConnection(toDelete, (conn) async {
      final err = await deleteDB(context, toDelete.database);
      if (err.isNotEmpty) return err;

      conections.removeWhere((c) => c.database == toDelete.database);
      _updateList(conections, newSelected: null);
      return null;

    });
  }



  Future<T>_withConnection<T>(Conection c, Future<T> Function(MySqlConnection conn) action) async {

    MySqlConnection? conn;

    try {
      conn = await connectSQL(c);
      return await action(conn);
    } catch (e) {
      return Future.value('Error de conexión SQL: $e' as T);
    } finally {

      try {
        await conn?.close();
      } catch (_) {

      }
    }
  }
  Future<MySqlConnection> connectSQL(Conection cNew) async {
    
    final settings = ConnectionSettings(
      host: cNew.host,
      port: int.parse(cNew.port),
      user: cNew.user,
      password: cNew.password,
    );

    return await MySqlConnection.connect(settings);
  }

  void _updateList(List<Conection> newList, {Conection? newSelected}) {
    conections = newList;
    selected = newSelected;
    notifyListeners();
    csvExportatorConections(conections);
  }

  }


