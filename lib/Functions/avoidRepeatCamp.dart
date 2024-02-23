import 'package:crud_factories/Objects/Factory.dart';
import 'package:fluent_ui/fluent_ui.dart';
import '../Alertdialogs/noDat.dart';

bool avoidRepeteatCamp(BuildContext context, bool repeat,  List<String>campSearch, TextEditingController controllerName, int select) {


    for (int i = 0; i < campSearch.length; i++) {

      if (controllerName.text == campSearch[i])
      {
        repeat =true;
      }
      else
      {
        repeat = false;
      }
    }



  return repeat;
}