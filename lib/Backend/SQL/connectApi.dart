import 'package:crud_factories/Backend/Global/controllers/Conection.dart';

Future<Uri> connectApi(connectionControler controllers, String nameTable) async {


  return Uri(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '${controllers.namebd.text}/$nameTable',
    queryParameters: {
      'host': controllers.hostbd.text,
      'port': controllers.portbd.text,
      'user': controllers.userbd.text,
      'password': controllers.passbd.text,
    },
  );
}
