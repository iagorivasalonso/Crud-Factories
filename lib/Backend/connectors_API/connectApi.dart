
import '../Global/list.dart';

Future<Uri> connectApi(String nameTable) async {

  return Uri(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '${controlerConex.namebd.text}/$nameTable',
    queryParameters: {
      'host': controlerConex.hostbd.text,
      'port': controlerConex.portbd.text,
      'user': controlerConex.userbd.text,
      'password': controlerConex.passbd.text,
    },
  );
}
