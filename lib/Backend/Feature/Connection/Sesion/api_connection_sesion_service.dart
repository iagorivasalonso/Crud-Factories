
import 'package:crud_factories/Backend/Feature/Connection/Controller/ConnectionController.dart' show DisconnectResponse;
import 'package:crud_factories/Backend/Feature/Connection/ExecuteQuery/IexecuteQuery.dart' show Iexecutequery;
import 'package:crud_factories/Backend/Feature/Connection/ExecuteQuery/apiExecuteQuery.dart' show ApiExecuteQuery;
import 'package:crud_factories/Backend/Feature/Connection/Sesion/IConnection_sesion_service.dart' show IConnectionSesionService;
import 'package:crud_factories/Backend/connectors_API/DbApi.dart' show DbApi;
import 'package:crud_factories/Backend/connectors_API/Models/Api_response.dart';
import 'package:crud_factories/Objects/Conection.dart';


class apiConnectionSesionService implements IConnectionSesionService{

  late final Iexecutequery _executeQuery = ApiExecuteQuery();

  @override
  Future<void> connect(Conection c) async {

    final res = await DbApi.actionApi('connect', c);

    final response = ApiResponse.fromJson(res);

    if (!response.ok) {
      throw Exception(response.message);
    }
  }

  @override
  Iexecutequery get executeQuery => _executeQuery;

  @override
  Future<DisconnectResponse> disconnect() async {

    final res = await DbApi.actionApi('disconnect', null);

    final response = ApiResponse.fromJson(res);


    return DisconnectResponse(
      ok: response.ok,
      message: response.message,
    );
  }
}