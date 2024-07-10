import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Objects/Mail.dart';

sqlImportMails() async {

  var result = await conn.query('select * from mails');


  for (var row in result) {

    mails.add(Mail(
        id: row[0].toString(),
        addrres: row[2],
        company: row[1],
        password: row[3]
    ));
  }

}
