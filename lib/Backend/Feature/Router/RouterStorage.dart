
import 'package:shared_preferences/shared_preferences.dart';

class RoutersStorage {

    static const String _routesPathKey = 'RUTASAPP';

    static Future<void> saveRoutesPath(String path) async {

       final prefs = await SharedPreferences.getInstance();
       await prefs.setString(_routesPathKey, path);

    }

    static Future<String>loadRoutesPath() async {

         final prefs = await SharedPreferences.getInstance();
         return prefs.getString(_routesPathKey) ?? '';
    }


}