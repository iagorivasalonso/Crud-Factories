import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:fluent_ui/fluent_ui.dart';


bool primaryKeyCorrect(String camp, String nameCamp, List <String> allKeys, String campOld, BuildContext context) {

  bool keyCorrect = false;

  if(camp.isEmpty) {
    String action = 'El campo $nameCamp no puede estar vacio';
    error(context, action);
  }
  else{

    if(allKeys.isNotEmpty)
    {
      if(campOld == camp)
      {
        keyCorrect = true;
      }
      else {
        keyCorrect = true;

        for(int i = 0; i <allKeys.length;i++)
        {
          if(allKeys[i]==camp)
          {
            String action = 'Este campo no puede ser repetido';
            error(context, action);
            keyCorrect = false;
          }

        }
      }
    }
    else
    {
      keyCorrect = true;
    }

  }

  return keyCorrect;
}

bool campEmpty(String camp) {

  bool campValid = false;

  if(camp.isEmpty) {
    campValid = true;
  }else {
    campValid = false;
  }

  return campValid;
}

bool dateCorrect( String date)
{
  bool dateValid =  RegExp(r"^[0-3][0-9]+-[0-1][0-9]+-[0-9][0-9][0-9][0-9]").hasMatch(date);

  if(dateValid == true)
  {


    if(date.length == 10)
    {

      List <String> partDate = date.split("-");

      if(partDate.length == 3)
      {
        int dd = int.parse(partDate[0]);
        int mm = int.parse(partDate[1]);
        int aa = int.parse(partDate[2]);

        if(dd > 31)
        {
          dateValid = false;
        }
        else if(mm > 12)
        {
          dateValid = false;
        }
        else if (aa > 9999)
        {
          dateValid = false;
        }
      }
      else
      {
        dateValid = false;
      }
    }
    else
    {
      dateValid = false;
    }


  }

  return dateValid;


}
bool telephoneCorrect(String telephone, BuildContext context) {

  bool telephoneValid = false;

  if(telephone.isEmpty)
  {

  }
  else
  {
    telephoneValid = RegExp(r"^[0-9,$]*$").hasMatch(telephone);

    if(telephoneValid != true)
    {
      String action ='El phone debe de ser numerico';
      error(context,action);
    }
    else
    {
      if(telephone.trim().length!=9)
      {
        telephoneValid = false;
        String action ='El phone debe de tener 9 digitos';
        error(context,action);

      }
    };
  }

  return telephoneValid;
}

bool mailCorrect(String email) {

  final bool mailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+(-.*)?$").hasMatch(email);

  return mailValid;
}

bool webCorrect(String web) {

  final bool webValid = RegExp(r"^[www]+.[a-zA-Z0-9]+.[a-zA-Z ,]+").hasMatch(web);

  return webValid;
}

bool adrressCorrect(String adrress) {

  final adrress1 = adrress.replaceAll(" ", "");
  final bool adrressValid =RegExp(r"^[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ.!#$%&'*+-/=?^_`{|}~]+,[0-9a-zA-ZáéíóúÁÉÍÓÚñÑ]+").hasMatch(adrress1);

  return adrressValid;
}

bool passwordCorrect(String pas1, String pas2, BuildContext context)  {

  bool passValid = false;

  if(pas1.isEmpty)
  {
    String action =' el campo de contraseña no puede estar vacio';
    error(context,action);
  }
  else
  {
    if(pas1 != pas2)
    {
      String action ='Las contraseñas no coinciden';
      error(context,action);
    }
    else
    {
      passValid = true;
    }
  }

  return passValid;
}

bool postalCodeCorrect(String postalCode, BuildContext context) {

  bool postalCodeValid = RegExp(r"^[0-9,$]*$").hasMatch(postalCode);

  if(postalCodeValid != true)
  {
    String action ='El código postal debe de ser numerico';
    error(context,action);
  }
  else
  {
    if(postalCode.trim().length!=5)
    {
      postalCodeValid = false;
      String action ='El codigo postal debe de tener 5 digitos';
      error(context,action);

    }
  }


  return postalCodeValid;
}