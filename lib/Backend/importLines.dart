import 'dart:io';
import '../Objects/lineSend.dart';

importLines(List<String> fileContent, List<lineSend> line) async {

  List<String> select =[];

  if(fileContent.isEmpty)
  {
    File file = new File('D:/lineSends.csv');
    fileContent = await file.readAsLines();
  }


    for (int i = 0; i <fileContent.length; i++)
    {
      select = fileContent[i].split(",");
      line.add(lineSend(
          date:select[0] ,
          factory:select[1] ,
          observations: select[2] ,
          state: select[3] ));
    }



  return line;
}
