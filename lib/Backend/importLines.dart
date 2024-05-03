import 'dart:io';
import '../Objects/lineSend.dart';

importLines(List<String> fileContent, List<lineSend> line) async {

  List<String> select =[];

  if(fileContent.isEmpty)
  {
    File file = new File('D:/lineSends.csv');

    if(file.existsSync())
    fileContent = await file.readAsLines();
  }


    for (int i = 0; i <fileContent.length; i++)
    {
      select = fileContent[i].split(",");
      line.add(lineSend(
          id: select[0],
          date:select[1],
          factory:select[2] ,
          observations: select[3] ,
          state: select[4]));

    }



  return line;
}
