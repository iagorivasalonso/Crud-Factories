import 'package:crud_factories/generated/l10n.dart';
import 'package:crud_factories/helpers/localization_helper.dart';
import 'package:fluent_ui/fluent_ui.dart';

class ValidatorCamps {

  static String? primaryKeyValidate(
      String camp,
      List<String> allKeys,
      String campOld,
      BuildContext context,
      ) {
    if (allKeys.isEmpty || campOld == camp) return null;

    if (allKeys.contains(camp)) {
      return S.of(context).this_field_cannot_be_repeated;
    }

    return null;
  }

  static String? emptyValidate(String camp, BuildContext context, String nameCamp) {
    if (camp.trim().isEmpty) {
      return "$nameCamp ${S.of(context).is_required}";
    }
    return null;
  }

  static String? dateValidate(String date, BuildContext context) {
    final value = date.trim();
    String array = S.of(context).date;
    if (value.isEmpty) return null;

    if (!RegExp(r"^[0-3][0-9]-[0-1][0-9]-[0-9]{4}$").hasMatch(value)) {

      return LocalizationHelper.format_must(context, array);
    }

    final parts = value.split("-");
    if (parts.length != 3) return LocalizationHelper.format_must(context, array);

    final dd = int.tryParse(parts[0]) ?? 0;
    final mm = int.tryParse(parts[1]) ?? 0;
    final aa = int.tryParse(parts[2]) ?? 0;

    if (dd > 31 || mm > 12 || aa > 9999) {
      return LocalizationHelper.format_must(context, array);
    }

    return null;
  }

  static String? telephoneValidate(String telephone, BuildContext context) {
    final value = telephone.trim();
    final camp = S.of(context).phone;

    if (value.isEmpty) return null;

    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return LocalizationHelper.camp_number(context, camp);
    }

    if (value.length != 9) {
      return LocalizationHelper.cant_numbers(context, camp, 9);
    }

    return null;
  }

  static String? mailValidate(String email, BuildContext context) {
    final value = email.trim();

    if (value.isEmpty) return null;

    final valid = RegExp(
      r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$",
    ).hasMatch(value);

    if (!valid) {
      return S.of(context).not_a_valid_mail;
    }

    return null;
  }
  static String? webValidate(String web, BuildContext context) {
    final value = web.trim();

    if (value.isEmpty) return null;

    final valid = RegExp(
      r'^(https?:\/\/)?(www\.)?[a-zA-Z0-9-]+\.[a-zA-Z]{2,}',
    ).hasMatch(value);

    if (!valid) {
      return S.of(context).not_a_valid_webpage;
    }

    return null;
  }

  static String? addressValidate(String address, BuildContext context) {
    final value = address.replaceAll(" ", "");

    if (value.isEmpty) return null;

    final valid = RegExp(
      r"^[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ]+,[0-9a-zA-ZáéíóúÁÉÍÓÚñÑ]+",
    ).hasMatch(value);

    if (!valid) {
      return S.of(context).address;
    }

    return null;
  }

  static String? passwordValidate(
      String pas1,
      String pas2,
      BuildContext context,
      ) {
    if (pas1.isEmpty) {
      return LocalizationHelper.camp_empty(context, S.of(context).password);
    }

    if (pas1 != pas2) {
      return S.of(context).passwords_do_not_match;
    }

    return null;
  }

  static String? postalCodeValidate(String postalCode, BuildContext context) {
    final value = postalCode.trim();
    final camp = S.of(context).postal_code;

    if (value.isEmpty) return null;

    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return LocalizationHelper.camp_number(context, camp);
    }

    if (value.length != 5) {
      return LocalizationHelper.cant_numbers(context, camp, 5);
    }

    return null;
  }
}