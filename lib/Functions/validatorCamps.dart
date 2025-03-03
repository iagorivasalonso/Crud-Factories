import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:crud_factories/helpers/localization_helper.dart';
import 'package:fluent_ui/fluent_ui.dart';

class validatorCamps {

  static bool primaryKeyCorrect(String camp, String nameCamp, List <String> allKeys, String campOld, BuildContext context) {

        bool keyCorrect = false;

        if(camp.isEmpty)
        {
             String action = LocalizationHelper.camp_empty(context, nameCamp);
             error(context, action);
        }
        else
        {

              if(allKeys.isNotEmpty)
              {
                    if(campOld == camp)
                    {
                      keyCorrect = true;
                    }
                    else
                    {
                          keyCorrect = true;

                          for(int i = 0; i <allKeys.length;i++)
                          {
                                if(allKeys[i]==camp)
                                {
                                  String action = S.of(context).this_field_cannot_be_repeated;
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

  static bool campEmpty(String camp) {

    bool campValid = false;

    if(camp.isEmpty)
    {
      campValid = true;
    }else
    {
      campValid = false;
    }

    return campValid;
  }

  static bool dateCorrect( String date)
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

  static bool telephoneCorrect(String telephone, BuildContext context) {

    bool telephoneValid = false;

    if(telephone.isNotEmpty)
    {
      telephoneValid = RegExp(r"^[0-9,$]*$").hasMatch(telephone);

      if(telephoneValid != true)
      {
         String camp = S.of(context).phone;
        String action =LocalizationHelper.camp_number(context, camp);
        error(context,action);
      }
      else
      {
        if(telephone.trim().length!=9)
        {
          telephoneValid = false;
          String action = LocalizationHelper.cant_numbers(context,telephone, 9);
          error(context,action);

        }
      };
    }

    return telephoneValid;
  }

  static bool mailCorrect(String email) {

    final bool mailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+(-.*)?$").hasMatch(email);

    return mailValid;
  }

  static bool webCorrect(String web) {

    final bool webValid = RegExp(r"^[www]+.[a-zA-Z0-9]+.[a-zA-Z ,]+").hasMatch(web);

    return webValid;
  }

  static bool adrressCorrect(String adrress) {

    final adrress1 = adrress.replaceAll(" ", "");
    final bool adrressValid =RegExp(r"^[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ.!#$%&'*+-/=?^_`{|}~]+,[0-9a-zA-ZáéíóúÁÉÍÓÚñÑ]+").hasMatch(adrress1);

    return adrressValid;
  }

  static bool passwordCorrect(String pas1, String pas2, BuildContext context)  {

    bool passValid = false;

    if(pas1.isEmpty)
    {
      String camp = S.of(context).password;
      String action =LocalizationHelper.camp_number(context, camp);
      error(context,action);
    }
    else
    {
      if(pas1 != pas2)
      {
        String action =S.of(context).passwords_do_not_match;
        error(context,action);
      }
      else
      {
        passValid = true;
      }
    }

    return passValid;
  }

  static bool postalCodeCorrect(String postalCode, BuildContext context) {

    bool postalCodeValid = RegExp(r"^[0-9,$]*$").hasMatch(postalCode);

    if(postalCodeValid != true)
    {
      String camp = S.of(context).postal_code;
      String action =LocalizationHelper.camp_number(context, camp);
      error(context,action);
    }
    else
    {
      if(postalCode.trim().length!=5)
      {
        postalCodeValid = false;
        String action = LocalizationHelper.cant_numbers(context,postalCode, 5);
        error(context,action);

      }
    }


    return postalCodeValid;
  }
}
