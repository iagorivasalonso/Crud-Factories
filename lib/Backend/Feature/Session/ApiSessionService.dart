import 'package:crud_factories/Backend/Feature/Session/ISessionService.dart';
import 'package:crud_factories/Objects/ApiConfig.dart' show ApiConfig;

class ApiSessionService implements ISessionservice{


  @override
  Future<SessionResult> login(String username, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<void> logout(String sessionId) {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<SessionResult?> restoreSession(String sessionId) {
    // TODO: implement restoreSession
    throw UnimplementedError();
  }
}