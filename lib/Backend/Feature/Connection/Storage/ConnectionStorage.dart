
import 'package:shared_preferences/shared_preferences.dart';

class Connectionstorage {

    static const String _key = 'lastConnectionId';

    Future<void> saveConnectionId(String id) async {

         final prefs = await SharedPreferences.getInstance();
         await prefs.setString(_key, id);
    }

    Future<String?> getConnectionId() async {

      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_key);
    }

    Future<void> clearConnectionId() async {

      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_key);
    }


}