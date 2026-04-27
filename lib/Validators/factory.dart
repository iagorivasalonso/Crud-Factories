


import 'package:crud_factories/Alertdialogs/error.dart' show error;
import 'package:crud_factories/Backend/Global/controllers/Factory.dart' show factoryController;
import 'package:crud_factories/Functions/validatorCamps.dart' show ValidatorCamps;
import 'package:crud_factories/Objects/Factory.dart' show Factory;
import 'package:crud_factories/generated/l10n.dart' show S;
import 'package:crud_factories/helpers/localization_helper.dart' show LocalizationHelper;
import 'package:fluent_ui/fluent_ui.dart';

class FactoryValidator {

  static String? validate(BuildContext context, factoryController controllers,
      int select,List<Factory> allFactories) {

    final name = controllers.name.text.trim();
    final sector = controllers.sector.text.trim();
    final mail = controllers.mail.text.trim();
    final date = controllers.highDate.text.trim();
    final postal = controllers.postalCode.text.trim();
    final address = controllers.address.text.trim();

    final tel1 = controllers.telephone1.text.replaceAll(" ", "");
    final tel2 = controllers.telephone2.text.replaceAll(" ", "");

    // 🔴 REQUIRED FIELDS
    if (name.isEmpty) return S.of(context).name_required;
    if (sector.isEmpty) return S.of(context).sector_required;

    // 🔴 UNIQUE NAME
    final allNames = allFactories.map((e) => e.name).toList();
    final oldName = select != -1 ? allFactories[select].name : "";

    final nameError = ValidatorCamps.primaryKeyValidate(
      name,
      allNames,
      oldName,
      context,
    );
    if (nameError != null) return nameError;

    // 🔵 OPTIONAL VALIDATIONS

    if (date.isNotEmpty) {
      final err = ValidatorCamps.dateValidate(date, context);
      if (err != null) return err;
    }

    if (mail.isNotEmpty) {
      final err = ValidatorCamps.mailValidate(mail, context);
      if (err != null) return err;
    }

    if (tel1.isNotEmpty) {
      final err = ValidatorCamps.telephoneValidate(tel1, context);
      if (err != null) return err;
    }

    if (tel2.isNotEmpty) {
      final err = ValidatorCamps.telephoneValidate(tel2, context);
      if (err != null) return err;
    }

    if (address.isNotEmpty) {
      final err = ValidatorCamps.addressValidate(address, context);

      if(err != null)
      {
        String array = S.of(context).address;
        String action = LocalizationHelper.format_must(context, array);
        String street = S.of(context).street;
        String number = S.of(context).number;
        String format = '$street , $number';

        error(context, action, format);
      }
    }


    if (postal.isNotEmpty) {
      final err = ValidatorCamps.postalCodeValidate(postal, context);
      if (err != null) return err;
    }

    return null;
  }
}

class AddressParser {
  static Map<String, String> parse(String text) {
    final partsDash = text.split("-");
    final apartament = partsDash.length > 1 ? partsDash[1] : "";

    final partsComma = partsDash[0].split(",");
    final street = partsComma.isNotEmpty ? partsComma[0] : "";
    final number = partsComma.length > 1 ? partsComma[1] : "";

    return {
      "street": street,
      "number": number,
      "apartament": apartament,
    };
  }
}