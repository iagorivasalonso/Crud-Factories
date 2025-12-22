import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Objects/Mail.dart';
import 'package:flutter/foundation.dart' as foundation;

sqlImportMails() async {

  try {
    if (!foundation.kIsWeb) {
    var result = await executeQuery.query('select * from mails');

    for (var row in result)
    {
      mails.add(Mail(
          id: row[0].toString(),
          address: row[2],
          company: row[1],
          password: row[3]
      ));
    }


    }
  }catch(Exeption){

  }




}
