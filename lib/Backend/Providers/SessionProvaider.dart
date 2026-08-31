import 'package:crud_factories/Backend/Feature/Session/ISessionService.dart';
import 'package:crud_factories/Backend/Feature/Session/SessionStorage.dart';
import 'package:crud_factories/Objects/AppSession.dart';
import 'package:crud_factories/Objects/User.dart' show User;
import 'package:fluent_ui/fluent_ui.dart';

enum SessionStatus {
  unauthenticated,
  loading,
  authenticated,
}

class SessionProvider extends ChangeNotifier {

   final ISessionservice service;
   final SessionStorage _storage = SessionStorage();

   SessionProvider ({
      required this.service,
   });

   User? _user;
   AppSession? _session;

   SessionStatus _status = SessionStatus.unauthenticated;

   User? get user => _user;
   AppSession? get session => _session;
   SessionStatus get status => _status;

   bool get isAuthenticated =>
       _status == SessionStatus.authenticated;


   Future<void> login(String username, String password) async {


     _status = SessionStatus.loading;
     notifyListeners();

     try {



       final result = await service.login(username, password);

       print('Login correcto');
       print('User: ${result.user}');
       print('Session: ${result.session.id}');

       _user = result.user;
       _session = result.session;

       await _storage.saveSessionId(_session!.id);

       print('SessionId guardado: ${_session!.id}');

       _status = SessionStatus.authenticated;

       notifyListeners();

     } catch (e) {

       print('ERROR LOGIN: $e');

       _user = null;
       _session = null;

       _status = SessionStatus.unauthenticated;

       notifyListeners();
     }
   }

   Future<void> logout() async {

      final currentSession = _session;

      if(currentSession != null)
      {
         await service.logout(currentSession.id);
      }

      await _storage.clearSessionId();

      _user = null;
      _session = null;

      _status = SessionStatus.unauthenticated;

      notifyListeners();
   }

   Future<bool> restoreSession() async {

     print('========== RESTORE SESSION ==========');

     final sessionId = await _storage.getSessionId();

     print('SessionId guardado: $sessionId');

     if (sessionId == null) {
       print('No hay sesión guardada');

       _status = SessionStatus.unauthenticated;
       notifyListeners();
       return false;
     }

     print('Intentando restaurar sesión...');

     _status = SessionStatus.loading;
     notifyListeners();

     try {

       final result = await service.restoreSession(sessionId);

       print('Resultado restoreSession: $result');

       if (result == null) {

         print('Sesión no válida');

         await _storage.clearSessionId();

         _user = null;
         _session = null;
         _status = SessionStatus.unauthenticated;

         notifyListeners();

         return false;
       }

       print('Sesión restaurada correctamente');
       print('Usuario: ${result.user}');
       print('Session: ${result.session.id}');

       _user = result.user;
       _session = result.session;
       _status = SessionStatus.authenticated;

       notifyListeners();

       return true;

     } catch (e) {

       print('ERROR restoreSession: $e');

       _user = null;
       _session = null;
       _status = SessionStatus.unauthenticated;

       return false;
     }
   }

}