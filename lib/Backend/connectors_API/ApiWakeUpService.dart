

import 'package:crud_factories/Backend/connectors_API/ApiConfigUrl.dart';
import 'package:http/http.dart' as http;

class ApiWakeUpService {

   static Future<bool> waitUntilReady({
                  int maxAttempts = 12,
                  Duration retryDelay = const Duration(seconds: 5),
            })async {

            final url = Uri.parse('${ApiConfigUrl.baseUrl}/health');

             for(int attempt = 1; attempt <= maxAttempts; attempt++)
             {
                   try{
                       final response = await http
                           .get(url)
                           .timeout(Duration(seconds: 10));

                       if(response.statusCode == 200)
                       {
                            return true;
                       }

                   }catch(e) {
                     print('La API todavía no responde ($attempt/$maxAttempts): $e');
                   }

                   if(attempt < maxAttempts)
                   {
                     await Future.delayed(retryDelay);
                   }
             }

           return false;
        }

}