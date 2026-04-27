import 'package:crud_factories/Alertdialogs/error.dart' show error;
import 'package:crud_factories/Backend/CSV/exportConections.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Backend/connectors_API/DbApi.dart';
import 'package:crud_factories/Backend/SQL/manageSQl.dart';
import 'package:crud_factories/Backend/SQL/serverService.dart';
import 'package:crud_factories/Objects/Conection.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:mysql1/mysql1.dart';
import '../../generated/l10n.dart';
import '../../helpers/localization_helper.dart' show LocalizationHelper;
import '../connectors_API/Models/Api_response.dart';

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

  final List<Conection> _conections = []; // NEW

  List<Conection> get conections => List.unmodifiable(_conections); // N

  Conection? selected;
  bool _connected = false;
  Conection? _previous;
  BuildContext context = context1;
  Conection? _tempConnection;

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



  void setTempConnection(Conection c) {
    _tempConnection = c;
  }

  void clearTempConnection() {
    _tempConnection = null;
  }

  Conection? get connectionToUse {
    return _tempConnection ?? selected;
  }
  Future<String> connect (BuildContext context) async {
    final con = connectionToUse;

    if (con == null)
      return S.of(context).not_connected_to_any_database;



    try {
      if(!kIsWeb)
      {
         await ServerService.startServer();

        final settings = ConnectionSettings(
          host: con.host,
          port: int.parse(con.port),
          user: con.user,
          password: con.password,
          db: con.database,
        );

        executeQuery = await MySqlConnection.connect(settings);
      }
      else
      {

          final resConnection = await DbApi.actionApi('test-connection', con);
          final dbResponse = ApiResponse.fromJson(resConnection);

          if(dbResponse.message!="Conectado correctamente")
          {
            throw Exception(dbResponse.message);
          }
      }


      _connected = true;
      BaseDateSelected = con.database;
      selectedDb = con.database;

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

  void setConections(List<Conection> data) { // NEW
    _conections
      ..clear()
      ..addAll(data);

    notifyListeners();
  }

  void addConection(Conection c) { // NEW
    _conections.add(c);
    notifyListeners();
  }

  void delete(String database) { // NEW
    _conections.removeWhere((c) => c.database == database);
    notifyListeners();
  }

  void clear() { // NEW
    _conections.clear();
    notifyListeners();
  }

    Future<bool>disconnet() async {

      if(!kIsWeb)
      {
           var resConex = await executeQuery?.close();

           if(resConex == null);
           {
             _connected = false;
           }
      }
      else
      {
        try {
              Conection? con =selected;

              final resConnection = await DbApi.actionApi('disconnect', con);
              final dbResponse = ApiResponse.fromJson(resConnection);

                 if(dbResponse.message=="Desconectado correctamente")
                 {
                   _connected = false;
                 }

        } catch (e) {
          print('Error al desconectar: $e');
          _connected = true;
        }
      }

      selectedDb='';

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

  Map<String, Conection> get _conectionsMap => {for (var c in _conections) c.database: c};

  Future<String> createBD(Conection cNew) async {
    if (_conectionsMap.containsKey(cNew.database)) {
      return "EXISTS";
    }

    final resDb = ApiResponse.fromJson(
      await DbApi.actionApi('createBD', cNew),
    );

    if (resDb.ok) {
      return "ERROR: BD";
    }

    final resTables = ApiResponse.fromJson(
      await DbApi.actionApi('createTables', cNew),
    );

    if (resTables.ok) {
      return "ERROR: TABLES";
    }

    _conections.add(cNew);
    _updateList(_conections, newSelected: cNew);

    return "OK";
  }

  Future<bool> updateBD(Conection current, Conection cNew) async {

    bool error = false;

    if (!_conectionsMap.containsKey(current.database)) {
       error = true;
    }
    else
    {
      if(kIsWeb)
      {
        final ResUpdate = await DbApi.actionApi( 'update',current, cNew)
            .then((data) => ApiResponse.fromJson(data));

        if(!ResUpdate.ok)
        {
          error = false;
        }
      }
      else
      {
        await _withConnection(cNew, (conn) async {
          final err = await actionsBD.editDB(current.database, cNew.database);
          error = err;
        });
      }
      final index = _conections.indexWhere((c) => c.database == current.database);
      _conections[index] = cNew;
      _updateList(_conections, newSelected: cNew);

    }
    return error;
  }


  Future<bool> deleteBD(Conection toDelete,  {bool deleteSQL = false}) async {

    bool error = false;

    if (!_conectionsMap.containsKey(toDelete.database)) {
      error = true;
    }
    else
    {
      if(kIsWeb)
      {
        final ResDelete = await DbApi.actionApi( 'delete', toDelete)
            .then((data) => ApiResponse.fromJson(data));
         print(ResDelete.ok);//false
        if(!ResDelete.ok)
        {
          error = true;
        }
      }
      else
      {
        await _withConnection(toDelete, (conn) async {
          final err = await actionsBD.deleteDB(toDelete.database);
          if (err==true) return err;
        });
      }


      _conections.removeWhere((c) => c.database == toDelete.database);
      _updateList(_conections, newSelected: null);
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

  void _updateList(List<Conection> newList, {Conection? newSelected}) async {

    _conections
      ..clear()
      ..addAll(newList);

    selected = newSelected;
    notifyListeners();

    bool errorExp = await csvExportatorConections(_conections);

    if (!kIsWeb && errorExp) {
      String action = LocalizationHelper.no_file(
        context,
        S.of(context).connections,
      );
      error(context, action);
      return;
    }
  }

  Future<String> controlsErrors(String errorMsg) async {

    String type = S.of(context).sql_error;

    if (errorMsg.contains("Unknown database")) {
      type = "${S.of(context).there_is_no_database_with_that_name} ${selected?.database}";
    }
    else if (errorMsg.contains(" Host desconocido") | errorMsg.contains("Unknown host")) {
      type = S.of(context).unknown_host;
    }
    else if (errorMsg.contains("is not allowed to connect to this MySQL server")) {
      type = S.of(context).could_not_connect_with_the_server;
    }
    else if (errorMsg.contains("SocketException") | errorMsg.contains('Connection refused (check host or port)')) {
      type = S.of(context).the_port_is_not_correct;
    }
    else if (errorMsg.contains("Access denied for user")) {
      type = S.of(context).the_user_or_password_are_incorrect;
    }
    return type;
  }

  }



