
import 'package:crud_factories/Backend/Global/list.dart';

class manageArrays {

 static List<String> avoidRepeteat(List<String> allElements) {

    List<String> elementsDiferent =[];

      for(var element in allElements)
      {
          if(!elementsDiferent.contains(element))
             elementsDiferent.add(element);
      }
    return elementsDiferent;
  }

  static addDateSend (String dateNew) {

    if (!dateSends.contains(dateNew))
    {
        dateSends.add(dateNew);
    }
  }
}