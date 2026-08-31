import 'package:shared_preferences/shared_preferences.dart';

class SessionStorage {

      static const String _sessionIdKey = 'sessionId';

      Future<void> saveSessionId(String sessionId) async {

           final prefs = await SharedPreferences.getInstance();

           await prefs.setString(
               _sessionIdKey,
               sessionId
           );
      }

      Future<String?> getSessionId() async {

        final prefs = await SharedPreferences.getInstance();

        return prefs.getString(_sessionIdKey);
      }

      Future<void> clearSessionId() async {

        final prefs = await SharedPreferences.getInstance();

        await prefs.remove(_sessionIdKey);
      }
}