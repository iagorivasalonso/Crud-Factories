

import 'package:crud_factories/Backend/connectors_API/DbApi.dart';
import 'package:crud_factories/Backend/connectors_API/Models/Api_response.dart';
import 'package:crud_factories/Objects/Conection.dart';

import 'IConnectionService.dart';

class ApiConnectionService  implements IConnectionService{
  
  @override
  Future<bool> create(Conection c) async {
    
          final res = await DbApi.actionApi(
              'create', 
              c
          );
          
          return ApiResponse.fromJson(res).ok;
  }

  @override
  Future<bool> delete(Conection c) async {
    
      final res = await DbApi.actionApi(
          'delete',
          c
      );
  
      return ApiResponse.fromJson(res).ok;
  }

  @override
  Future<bool> update(Conection old, Conection update) async {

     final res = await DbApi.actionApi(
           'update',
           old,
           update
     );

     return ApiResponse.fromJson(res).ok;
  }
  
  
}