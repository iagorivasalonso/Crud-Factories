
import 'package:crud_factories/Backend/Feature/Connection/Datasource/IConnection_repository.dart';
import 'package:crud_factories/Backend/Feature/Connection/ExecuteQuery/IexecuteQuery.dart';
import 'package:crud_factories/Backend/Feature/Connection/ExecuteQuery/sqlExecuteQuery.dart' show sqlExecuteQuery;
import 'package:crud_factories/Backend/Feature/Connection/Service/IConnectionService.dart';
import 'package:crud_factories/Backend/Feature/Connection/Sesion/IConnection_sesion_service.dart';
import 'package:crud_factories/Backend/Feature/Connection/SeverService/ServerService.dart' show Serverservice;
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Backend/Providers/ConectionProvider.dart';
import 'package:crud_factories/Backend/Data/controlsMessagesError/errors.dart';
import 'package:crud_factories/Functions/createId.dart' show createId;
import 'package:crud_factories/Objects/AppRoutesState.dart' show RouteFiles;
import 'package:crud_factories/Objects/Conection.dart';
import 'package:crud_factories/Objects/ConnectionSesion.dart' show Connectionsesion;
import 'package:crud_factories/generated/l10n.dart' show S;
import 'package:flutter/material.dart';

//=========================
//  ENUMS RESPONSE
//=========================

enum ConnectResult {
    success,
    noConnectionSelected,
    error
}

enum DisconnectResult {
  success,
  noConnection,
  error,
}


class Connectioncontroller {

   final ConnectionProvider provider;
   final IConnectionDataSource repository;
   final IConnectionService service;
   final IConnectionSesionService sessionService;


   Connectioncontroller({
       required this.provider,
       required this.service,
       required this.repository,
       required this.sessionService
       });


   // =========================
   // LOAD
   // =========================

   Future<void> load() async {

     final data = await repository.load();
     provider.setConnections(data);

   }

   // =========================
   // CONNECTSQL
   // =========================

   Future<ConnectResultModel>connectSQL(BuildContext context, String? serverPath) async {

     await Serverservice.startServer(serverPath!);

     final selected = provider.selected;

     if (selected == null)
       return ConnectResultModel.error(S.of(context).There_is_no_connection_to_the_server);

     provider.setStatus(ConnectionStatus.connecting);

     try {

       await sessionService.connect(selected);


       provider.setExecuteQuery(sessionService.executeQuery);
       provider.setSession(Connectionsesion(
           selectedDb: selected.database,
           baseDate: DateTime.now().toString()
       ));

       provider.setStatus(ConnectionStatus.connected);
       provider.setViewMode(ConnectionViewMode.normal);

       return ConnectResultModel.success();

    ;

     } catch (e) {

       provider.setStatus(ConnectionStatus.disconnected);

       final message = await controlsErrors (context,e.toString(),provider);

       return ConnectResultModel.error(message);
     }
   }

   // =========================
   // DISCONNECTED
   // =========================

   Future<DisconnectResult> disconnect() async {

     try {

       final result = await sessionService.disconnect();

       provider.setSession(null);
       provider.setStatus(ConnectionStatus.disconnected);
       provider.setViewMode(ConnectionViewMode.normal);

       if (result.ok) {
         return DisconnectResult.success;
       } else {
         return DisconnectResult.error;
       }

     } catch (e,stackTrace) {
       print("error disconnect $e");
       print(stackTrace);
       return DisconnectResult.error;
     }
   }

   // =========================
   //  EXISTCONECTION
   // =========================

   bool exist(String name, {String? exclude}) {
     final nameLower = name.toLowerCase();

     return provider.connections.any((c) {
       final connectionName = c.database.toLowerCase();

       if (exclude != null && connectionName == exclude.toLowerCase()) {
         return false;
       }

       return connectionName == nameLower;
     });
   }

   // =========================
   // CREATE
   // =========================

   Future<CreateResult>create(Conection conection) async {

     try{
          final name = conection.database?.trim();

          if(name == null ||name.isEmpty){
             return CreateResult.invalidData;
          }

          final exits = exist(name);

          if (exits) {
            return CreateResult.alreadyExists;
          }

          final idNew = provider.connections.isNotEmpty
              ? createId(provider.connections.last.id)
              : "1";
          conection.id = idNew; //asignamos el id

          await service.create(conection);


       repository.save(conection);

       provider.selected = conection;
       provider.addConnection(conection);



          return CreateResult.success;
     } catch(e) {
       print(e.toString());
          return CreateResult.invalidData;
     }

   }


   // =========================
   // UPDATE
   // =========================

   Future<EditResult> update(Conection oldConnection, Conection newC) async {

     try {
        final name =newC.database?.trim();

        if(name == null || name.isEmpty) {
           return EditResult.invalidData;
        }
        await service.update(oldConnection, newC);

        final index = provider.connections.indexWhere(
             (x) => x.database == oldConnection.database,
        );
        if (exist(name, exclude: oldConnection.database)) {
          return EditResult.alreadyExists;
        }

       if (index != -1) {
         provider.connections[index] = newC;
         repository.save(newC);
       }
       else
       {
         return EditResult.notFound;
       }
       return EditResult.success;
     } catch (e) {
       print(e);
        return  EditResult.error;
     }
   }

   // =========================
   // DELETE
   // =========================

   Future<DeleteResult> delete(Conection c) async {

     try {

       final exits = provider.connections.any(
           (x) => x.id == c.id
       );

       if(!exits) {
          DeleteResult.notFound;
       }
       await service.delete(c);

       provider.connections.removeWhere(
             (x) => x.database == c.database,
       );

       if (provider.selected?.id == c.id) {
         provider.selected = null;
       }

       return DeleteResult.success;

     } catch (e) {
       print("Error update: $e");
       return DeleteResult.error;

     }
   }



}

//============================
//     MESSAGES VIEW
//============================

class ConnectResultModel {

  final bool success;
  final String? errorMessage;

  ConnectResultModel.success()
      : success = true,
        errorMessage = null;

  ConnectResultModel.error(this.errorMessage)
      : success = false;

  @override
  String toString() {
    return 'ConnectResultModel(success: $success, message: $errorMessage)';
  }
}

Future<String> controlsErrors(BuildContext context,String errorMsg,ConnectionProvider provider) async {

  String type = S.of(context).sql_error;

  if (errorMsg.contains("Unknown database")) {
    type = "${S.of(context).there_is_no_database_with_that_name} ${provider.selected?.database}";
  }
  else if (errorMsg.contains(" Host desconocido") || errorMsg.contains("Unknown host")) {
    type = S.of(context).unknown_host;
  }
  else if (errorMsg.contains("is not allowed to connect to this MySQL server")) {
    type = S.of(context).could_not_connect_with_the_server;
  }
  else if (errorMsg.contains("SocketException") || errorMsg.contains('Connection refused (check host or port)')) {
    type = S.of(context).the_port_is_not_correct;
  }
  else if (errorMsg.contains("Access denied for user")) {
    type = S.of(context).the_user_or_password_are_incorrect;
  }
  return type;
}

class ConnectionResult {
  final bool ok;
  final String message;

  ConnectionResult(this.ok, this.message);
}

class DisconnectResponse {
  final bool ok;
  final bool noActiveSession;
  final String? message;

  DisconnectResponse({
    required this.ok,
    this.noActiveSession = false,
    this.message,
  });
}