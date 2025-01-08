import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Objects/Factory.dart';

List<Factory> factoriesSectorSeleted(String subIten2Selection) {


  factoriesSector = [];

  if(subIten2Selection == 0.toString())
  {
    for(int i = 0; i <allFactories.length; i++)
    {
      factoriesSector.add(allFactories[i]);
    }
  }
  else
  {
    for(int i = 0; i <allFactories.length; i++)
    {
      if(allFactories[i].sector == subIten2Selection)
      {
        factoriesSector.add(allFactories[i]);
      }
    }
  }

  return factoriesSector;
}
