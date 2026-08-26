
import 'package:crud_factories/Objects/AppSession.dart';
import 'package:crud_factories/Objects/User.dart';

abstract class ISessionservice {

    Future<SessionResult> login (
        String username,
        String password
     );

    Future<void> logout(
         String sessionId,
        );

    Future<SessionResult?>restoreSession(
          String sessionId,
        );
}

class SessionResult {

    final User user;
    final AppSession session;

    SessionResult ({
        required this.user,
        required this.session,
    });
}