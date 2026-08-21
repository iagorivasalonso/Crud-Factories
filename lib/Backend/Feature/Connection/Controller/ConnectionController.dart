
import 'package:crud_factories/Backend/Feature/Connection/Service/IConnectionService.dart' show IConnectionService;
import 'package:crud_factories/Backend/Feature/Connection/Sesion/IConnection_sesion_service.dart';
import 'package:crud_factories/Backend/Feature/Connection/SeverService/ServerService.dart' show Serverservice;
import 'package:crud_factories/Backend/ImportGeneral/import_Processor.dart' show processImport;
import 'package:crud_factories/Backend/Providers/ConectionProvider.dart';
import 'package:crud_factories/Backend/Data/controlsMessagesError/errors.dart';
import 'package:crud_factories/Backend/Repositories/connectionRepository.dart' show ConnectionRepository;
import 'package:crud_factories/Functions/createId.dart' show createId;
import 'package:crud_factories/Objects/Conection.dart';
import 'package:crud_factories/Objects/ConnectionSesion.dart' show Connectionsesion;
import 'package:crud_factories/Objects/importResult.dart' show ImportResult;
import 'package:crud_factories/generated/l10n.dart' show S;
import 'package:flutter/material.dart';

//=========================
//  ENUMS RESPONSE
//=========================

enum ConnectResult {
    success,
    noConnectionSelected,
    error,
   protected
}

enum DisconnectResult {
  success,
  noConnection,
  error,
}


class ConnectionController {

   final ConnectionProvider provider;
   final ConnectionRepository repository;
   final IConnectionService service;
   final IConnectionSesionService sessionService;


   ConnectionController({
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
   //  IMPORTLIST
   // =========================
   Future<ImportResult> import({
     required BuildContext context,
     required List<Conection> connectionsNew,
   }) async {

     final result = ImportResult(
       entity: S.of(context).connections,
     );

     if (connectionsNew.isEmpty) return result;

     final connections = await repository.load();

     final newConnections = await processImport(
       newList: connectionsNew,
       existingList: connections,
       getKey: (c) => c.database,
       setId: (c, id) => c.id = id,
     );

     result.inserted = newConnections.length;

     if (newConnections.isNotEmpty) {
       await repository.saveAll(newConnections);
       await load();
     }

     return result;
   }
   // =========================
   // CONNECTSQL
   // =========================

   Future<ConnectResultModel>connectSQL(BuildContext context, String? serverPath) async {

     if (serverPath == null) {
       return ConnectResultModel.error(
         S.of(context).There_is_no_connection_to_the_server,
       );
     }

     final selected = provider.selected;

     if (selected == null) {
       return ConnectResultModel.error(
         S.of(context).There_is_no_connection_to_the_server,
       );
     }

     provider.setStatus(ConnectionStatus.connecting);

     try {
       await Serverservice.startServer(serverPath);

       await sessionService.connect(selected);

       provider.setExecuteQuery(sessionService.executeQuery);
       provider.setSession(Connectionsesion(
           selectedDb: selected.database,
           baseDate: DateTime.now().toString()
       ));

       provider.setStatus(ConnectionStatus.connected);
       provider.setViewMode(ConnectionViewMode.normal);

       return ConnectResultModel.success();

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

       if (!result.ok) {
         return DisconnectResult.error;
       }

       provider.setSession(null);
       provider.clearExecuteQuery();
       provider.clearConfig();
       provider.setStatus(ConnectionStatus.disconnected);
       provider.setViewMode(ConnectionViewMode.normal);


         return DisconnectResult.success;

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
     final nameLower = name.trim().toLowerCase();

     return provider.connections.any((c) {
       final connectionName = c.database.trim().toLowerCase();

       if (exclude != null && connectionName == exclude.trim().toLowerCase()) {
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

          final success = await service.create(conection);

          if (!success) {
            return CreateResult.invalidData;
          }


            await repository.save(conection);

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
        final name = newC.database?.trim();

        if(name == null || name.isEmpty) {
           return EditResult.invalidData;
        }

        if (exist(name, exclude: oldConnection.database)) {
          return EditResult.alreadyExists;
        }

        if (oldConnection.database.trim().toLowerCase() == "defaultdb") {
          return EditResult.invalidData;
        }

        final index = provider.connections.indexWhere(
              (x) => x.id == oldConnection.id,
        );

        if (index == -1) {
          return EditResult.notFound;
        }

        final success = await service.update(
          oldConnection,
          newC,
        );

        if (!success) {
          return EditResult.error;
        }
        newC.id = oldConnection.id;
        await repository.save(newC);

             provider.connections[index] = newC;

        if (provider.selected?.id == oldConnection.id) {
          provider.selected = newC;
        }

        provider.notifyListeners();

       return EditResult.success;
     } catch (e) {
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
       if (c.database.trim().toLowerCase() == "defaultdb") {
         return DeleteResult.error;
       }

       if(!exits) {
         return DeleteResult.notFound;
       }

       final success = await service.delete(c);

       if (!success) {
         return DeleteResult.error;
       }

       await repository.delete(c.id);

       provider.connections.removeWhere(
             (x) => x.id == c.id,
       );

       if (provider.selected?.id == c.id) {
         provider.selected = null;
       }

       provider.notifyListeners();

       return DeleteResult.success;

     } catch (e) {
       print("Error delete: $e");
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
