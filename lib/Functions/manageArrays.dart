
import 'package:crud_factories/Backend/Global/list.dart';

class manageArrays {

 static List<String> avoidRepeteat(List<String> allElements) {

    List<String> elementsDiferent =[];
    bool disting = false;
print(allElements);
    for(int i = 0; i < allElements.length; i++)
    {

      if(i==0)
      {
        disting = false;
      }
      else {

        disting = false;

        for (int x = 0; x < elementsDiferent.length; x++) {

          if (allElements[i] == elementsDiferent[x]) {
            disting = true;
          }
        }
      }
      if(disting==false)
      {
        elementsDiferent.add(allElements[i]);
      }

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