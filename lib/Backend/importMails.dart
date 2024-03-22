import 'dart:io';

import '../Objects/Mail.dart';

importMail(List<String> fileContent, List<Mail> mails) async {

  List<String> select =[];

  if(fileContent.isEmpty)
  {
    File file =new File('D:/mails.csv');
    fileContent = await file.readAsLines();
  }

  for (int i = 0; i <fileContent.length; i++)
  {
    select = fileContent[i].split(",");
    mails.add(Mail(
        id: select[0],
        company: select[1],
        addrres: select[2],
        password: select[3]));
  }

  return mails;
}
