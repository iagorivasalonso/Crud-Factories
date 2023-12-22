import 'package:crud_factories/Objects/Factory.dart';
import 'package:fluent_ui/fluent_ui.dart';
import '../Alertdialogs/noDat.dart';

void avoidRepeteatCamp(BuildContext context, bool repeat, String nameCamp, TextEditingController controllerName, List<Factory> factories, int select) {

  if(controllerName.text != factories[select].name)
  {
    for(int i = 0; i < factories.length; i++)
    {
      if(controllerName.text == factories[i].name)
        noDat(context, nameCamp);
    }
  }
}