import 'package:crud_factories/Backend/Feature/Connection/ExecuteQuery/IexecuteQuery.dart';
import 'package:crud_factories/Backend/Feature/Session/ISessionService.dart';

class SqlSessionService implements ISessionservice{

  final Iexecutequery executeQuery;

  SqlSessionService({
    required this.executeQuery,
  });

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