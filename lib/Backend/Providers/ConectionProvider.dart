

import 'package:crud_factories/Backend/Feature/Connection/Service/IConnectionService.dart' show IConnectionService;
import 'package:crud_factories/Backend/Feature/Connection/Sesion/IConnection_sesion_service.dart' show IConnectionSesionService;
import 'package:crud_factories/Backend/Feature/Connection/SeverService/ServerService.dart';
import 'package:crud_factories/Backend/Feature/Sector/apiSectorDataSource%20.dart';
import 'package:crud_factories/Backend/Repositories/connectionRepository.dart' show ConnectionRepository;
import 'package:crud_factories/Backend/connectors_API/DbApi.dart' show DbApi;
import 'package:crud_factories/Objects/ApiConfig.dart';
import 'package:crud_factories/Objects/Conection.dart' show Conection;
import 'package:crud_factories/Objects/ConnectionSesion.dart';
import 'package:crud_factories/generated/l10n.dart' show S;
import 'package:fluent_ui/fluent_ui.dart';

import '../Feature/Connection/ExecuteQuery/IexecuteQuery.dart';

enum ConnectionStatus {

  none,
  disconnected,
  connected,
  connecting,
}

enum ConnectionViewMode {
   normal,
   editing,
}
class ConnectionProvider extends ChangeNotifier {

  List<Conection> connections = [];


  Conection? selected;
  Connectionsesion? session;

  ApiConfig? _config;

  ConnectionStatus status = ConnectionStatus.disconnected;
  Iexecutequery? executeQuery;
  bool get isConnected => session != null;

  // =========================
  // 🔥 ENGINE (SQL / API SWITCH HERE)
  // =========================

  ConnectionViewMode _viewMode = ConnectionViewMode.normal;
  ConnectionViewMode get viewMode => _viewMode;


  void setConfig(ApiConfig config) {
    _config = config;
    notifyListeners();
  }

  ApiConfig get config {
    final c = _config;
    if (c == null) {
      throw Exception("ApiConfig not initialized");
    }
    return c;
  }

  void setExecuteQuery(Iexecutequery query) {
    executeQuery = query;
    notifyListeners();
  }


  // =========================
  // SET_CONNECTION
  // =========================


  void setConnections(List<Conection> data) {

    connections = data;

    notifyListeners();
  }

  // =========================
  // SET_SESSION
  // =========================

  void setSession(Connectionsesion? connectionsesion) {

    session = connectionsesion;

    notifyListeners();
  }

  // =========================
  // SET_CONNECTED_SESSION
  // =========================

  void setConnectedSession(Connectionsesion? s) {
    session = s;

    status = s == null
        ? ConnectionStatus.disconnected
        : ConnectionStatus.connected;

    _viewMode = ConnectionViewMode.normal;

    notifyListeners();
  }

   // =========================
  // SET_VIEW_MODE
  // =========================
  void setViewMode(ConnectionViewMode mode) {
    _viewMode = mode;
    notifyListeners();
  }
  // =========================
  // SET_STATUS
  // =========================

  void setStatus(ConnectionStatus s,) {

    status = s;
    notifyListeners();
  }




  // =========================
  // SELECT
  // =========================

  void select(Conection? c) {

    selected= c;
    notifyListeners();
  }

  // =========================
  // ADD
  // =========================
  void addConnection(Conection connection) {
    connections.add(connection);
    notifyListeners();
  }

  // =========================
  // SELECT EDIT MODE
  // =========================
  bool toggleEditMode() {
    if (!isConnected) return false;

    _viewMode = _viewMode == ConnectionViewMode.editing
        ? ConnectionViewMode.normal
        : ConnectionViewMode.editing;

    notifyListeners();
    return true;
  }

  // =========================
  // BUTTON EDIT
  // =========================

  String editButtonLabel(BuildContext context) {
    return viewMode == ConnectionViewMode.editing
        ? S.of(context).back
        : S.of(context).edit;
  }

  // ===========================================
  // BUTTON NEW/CONNECT/DISCONNECT/ACCEPT
  // ===========================================

  String action1Label(BuildContext context) {

    if(viewMode == ConnectionViewMode.editing)
              return S.of(context).acept;

    if(selected == null){
      return S.of(context).newFemale;
    }

    if (session == null) {
      return S.of(context).connect;
    }

    return S.of(context).disconnect;
  }

  // ===========================================
  // BUTTON CANCEL/DELETE
  // ===========================================

  String action2Label(BuildContext context) {

    return viewMode == ConnectionViewMode.editing
        ? S.of(context).cancel
        : S.of(context).delete;
  }


}




