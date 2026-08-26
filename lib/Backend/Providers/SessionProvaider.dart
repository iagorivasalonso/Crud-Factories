import 'package:crud_factories/Backend/Feature/Session/ISessionService.dart';
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

      try{
          final result = await service.login(username, password);

          _user = result.user;
          _session = result.session;

          _status =SessionStatus.authenticated;

          notifyListeners();

      } catch (_) {
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

      _user = null;
      _session = null;

      _status = SessionStatus.unauthenticated;

      notifyListeners();
   }

   Future<bool> restoreSession (String sessionId) async {

      _status = SessionStatus.loading;

      notifyListeners();

      try{

          final result = await service.restoreSession(
              sessionId
          );

          if(result == null)
          {
            _user = null;
            _session = null;
            _status = SessionStatus.unauthenticated;

            notifyListeners();

            return false;
          }

          _user = result.user;
          _session = result.session;
          _status= SessionStatus.authenticated;

          notifyListeners();

          return true;
      } catch (_) {

         _user = null;
         _session = null;

         _status = SessionStatus.unauthenticated;

         return false;
      }
   }

}