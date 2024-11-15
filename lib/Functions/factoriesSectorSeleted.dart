import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Objects/Factory.dart';

List<Factory> factoriesSectorSeleted(String subIten2Selection) {


  factoriesSector = [];

  if(subIten2Selection == 0.toString())
  {
    for(int i = 0; i <factories.length; i++)
    {
      factoriesSector.add(factories[i]);
    }
  }
  else
  {
    for(int i = 0; i <factories.length; i++)
    {
      if(factories[i].sector == subIten2Selection)
      {
        factoriesSector.add(factories[i]);
      }
    }
  }

  return factoriesSector;
}
