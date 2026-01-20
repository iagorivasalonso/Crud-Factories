import 'package:crud_factories/Backend/CSV/exportConections.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Backend/SQL/DbApi.dart';
import 'package:crud_factories/Backend/SQL/manageSQl.dart';
import 'package:crud_factories/Objects/Conection.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:mysql1/mysql1.dart';
import '../../Alertdialogs/confirm.dart';
import '../../Alertdialogs/error.dart';
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
  bool _connected = false;
  Conection? _previous;
  BuildContext context = context1;

  Conection? get previous => _previous;

   ConnectionViewMode viewMode = ConnectionViewMode.normal;

  ConnectionStatus get status {
    if(selected == null) return ConnectionStatus.none;
    return _connected
        ? ConnectionStatus.connected
        : ConnectionStatus.disconnected;
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
    return viewMode == ConnectionViewMode.editing
        ? S.of(context).undo
        : S.of(context).delete;

  }

  String actionEditLabel(BuildContext context) {
    return viewMode == ConnectionViewMode.editing
        ? S.of(context).back
        : S.of(context).edit;
  }


  Future<void> selectConnection(Conection? c) async {
    if (status == ConnectionStatus.connected) {
      await disconnet();
    }
    selected = c;
    notifyListeners();
  }

  Future<String> connect (BuildContext context) async {
    if (selected == null) return S.of(context).not_connected_to_any_database;


    try {
      if(!kIsWeb)
      {
        final settings = ConnectionSettings(
          host: selected!.host,
          port: int.parse(selected!.port),
          user: selected!.user,
          password: selected!.password,
          db: selected!.database,
        );

        executeQuery = await MySqlConnection.connect(settings);
      }
      else
      {
        await DbApi.actionApi('connect', selected!);
      }


      _connected = true;
      BaseDateSelected = selected!.database;
      selectedDb = selected!.database;

      notifyListeners();
      return BaseDateSelected;
    } catch (e) {

      _connected = false;
      executeQuery = null;

      final errorMsg = e.toString();
      String type = await controlsErrors(errorMsg);

      return type;
    }

  }

  bool toggleEditMode() {

    if (status != ConnectionStatus.connected || selected == null) {
      return false;
    }

    if (viewMode == ConnectionViewMode.normal) {
      // Guardamos copia para undo
      _previous = Conection(
        id: selected!.id,
        database: selected!.database,
        host: selected!.host,
        port: selected!.port,
        user: selected!.user,
        password: selected!.password,
      );

      viewMode = ConnectionViewMode.editing;
    } else {
      viewMode = ConnectionViewMode.normal;
    }

    notifyListeners();
    return true;
  }
  void undoEdit() {
    if (_previous == null) return;

    selected = Conection(
      id: _previous!.id,
      database: _previous!.database,
      host: _previous!.host,
      port: _previous!.port,
      user: _previous!.user,
      password: _previous!.password,
    );

    _previous = null;
    viewMode = ConnectionViewMode.normal;

    notifyListeners();
  }
    Future<bool>disconnet() async {

      await executeQuery?.close();
      _connected = false;
      selectedDb='';
      executeQuery = null;

      notifyListeners();
     return _connected;
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

  Future<String> create(Conection cNew) async {

    bool type_err = false;
    String type =" ";
    try{
      if (_conectionsMap.containsKey(cNew.database)) {
        type_err = true;
      }
      else
      {
        if(kIsWeb)
        {
          await DbApi.actionApi( 'create',cNew);

          await createTables();
        }
        else
        {

          await _withConnection(cNew, (conn) async {
            type_err = await createDB( cNew.database, conn);

            if (!type_err) {
              type_err = await createTables();

            }
          });

        }

        conections.add(cNew);
        _updateList(conections, newSelected: cNew);

      }

    }catch(e){
      final errorMsg = e.toString();
      type = await controlsErrors(errorMsg);
    }

    return type;

    }

  Future<bool> update(Conection old, Conection cNew) async {

    bool error = false;

    if (!_conectionsMap.containsKey(old.database)) {
       error = true;
    }
    else
    {
      if(kIsWeb)
      {
        await DbApi.actionApi( 'update',old, cNew);
      }
      else
      {
        await _withConnection(cNew, (conn) async {
          final err = await editDB(old.database, cNew.database);
          error = err;
        });
      }
      final index = conections.indexWhere((c) => c.database == old.database);
      conections[index] = cNew;
      _updateList(conections, newSelected: cNew);

    }
    return error;
  }


  Future<bool> delete(Conection toDelete,  {bool deleteSQL = false}) async {

    bool error = false;

    if (!_conectionsMap.containsKey(toDelete.database)) {
      error = true;
    }
    else
    {
      if(kIsWeb)
      {
        await DbApi.actionApi( 'delete', toDelete);
      }
      else
      {
        await _withConnection(toDelete, (conn) async {
          final err = await deleteDB(toDelete.database);
          if (err==true) return err;
        });
      }


      conections.removeWhere((c) => c.database == toDelete.database);
      _updateList(conections, newSelected: null);
      return false;
    }
    return error;
  }



  Future<T>_withConnection<T>(Conection c, Future<T> Function(MySqlConnection conn) action) async {

    if(kIsWeb) {
      return await action(null as MySqlConnection);
    }
    MySqlConnection? conn;

    try {
      conn = await connectSQL(c);
      return await action(conn);
    } catch (e) {
      rethrow;
    } finally {
      try {
        await conn?.close();
      } catch (exeption) {

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

  Future<String> controlsErrors(String errorMsg) async {

    String type = S.of(context).sql_error;

    if (errorMsg.contains("Unknown database")) {
      type = "${S.of(context).there_is_no_database_with_that_name} ${selected?.database}";
    }
    else if (errorMsg.contains("is not allowed to connect to this MySQL server")) {
      type = S.of(context).could_not_connect_with_the_server;
    }
    else if (errorMsg.contains("SocketException")) {
      type = S.of(context).the_port_is_not_correct;
    }
    else if (errorMsg.contains("Access denied for user")) {
      type = S.of(context).the_user_or_password_are_incorrect;
    }
    return type;
  }

  }


