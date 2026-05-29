
import 'package:crud_factories/Backend/Feature/Connection/Sesion/IConnection_sesion_service.dart' show IConnectionSesionService;
import 'package:crud_factories/Backend/connectors_API/DbApi.dart' show DbApi;
import 'package:crud_factories/Backend/connectors_API/Models/Api_response.dart';
import 'package:crud_factories/Objects/Conection.dart';
import 'package:mysql1/mysql1.dart' show MySqlConnection;

class apiConnectionService implements IConnectionSesionService{

  @override
  Future<MySqlConnection> connect(Conection c) async {

      final res = await DbApi.actionApi(
          'connect',
          c
      );

      final response = ApiResponse.fromJson(res);


      if (!response.ok) {
        throw Exception(response.message);
      }

      return response.data;
  }

  @override
  Future<bool> disconnect(Conection c) async {

    await DbApi.actionApi(
      'disconnect',
      null,
    );

    return true;
  }

}