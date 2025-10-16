import 'package:crud_factories/generated/l10n.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:intl/intl.dart';

class LocalizationHelper {

  static String shippingFactory( BuildContext context,int countFactories) {

    String preVar = S.of(context).el_shipment_has;

    return Intl.plural(
      countFactories,
      one: '$preVar $countFactories ${S.of(context).company.toLowerCase()}',
      other: '$preVar $countFactories ${S.of(context).companies.toLowerCase()}',
      name: "shipmentCompanies",
      args: [countFactories],
      examples: const {"countFactories": 0},
    );

  }

  static String sendMails( BuildContext context,int countMailSend) {

    return Intl.plural(
      countMailSend,
      one:  '${S.of(context).has_been_sent} $countMailSend ${S.of(context).mail.toLowerCase()}',
      other: '${S.of(context).have_been_sent} $countMailSend ${S.of(context).mails.toLowerCase()}',
      name: "sendMails",
      args: [countMailSend],
      examples: const {"countMailSend": 0},
    );
  }

  static String factoriesBD( BuildContext context,int countFactoriesBD) {

    String preVar = S.of(context).has;

    return Intl.plural(
      countFactoriesBD,
      one: '$preVar $countFactoriesBD ${S.of(context).company_en_base_datos.toLowerCase()}',
      other: '$preVar $countFactoriesBD ${S.of(context).companies_en_base_datos.toLowerCase()}',
      name: "factoriesDatabase",
      args: [countFactoriesBD],
      examples: const {"countFactoriesBD": 0},
    );
  }

  static String sendsFactory( BuildContext context,int countSendFactory) {


    return Intl.plural(
      countSendFactory,
      one: '${S.of(context).this_company_was_made}  $countSendFactory ${S.of(context).shipment.toLowerCase()}',
      other: '${S.of(context).these_companies_were_made} $countSendFactory ${S.of(context).sends.toLowerCase()}',
      name: "sendsFactory",
      args: [countSendFactory],
      examples: const {"countSendFactory": 0},
    );
  }
  static String sendsDay( BuildContext context,int countSendDay) {

    return Intl.plural(
      countSendDay,
      one: '${S.of(context).this_day_was_made} $countSendDay ${S.of(context).send.toLowerCase()}',
      other: '${S.of(context).this_day_they_were_made} $countSendDay ${S.of(context).sends.toLowerCase()}',
      name: "sendsDay",
      args: [countSendDay],
      examples: const {"countSendDay": 0},
    );
  }


  static String cantLinesModify( BuildContext context,int countSendDay) {

    return Intl.plural(
      countSendDay,
      one: '${S.of(context).was_modified} $countSendDay ${S.of(context).line.toLowerCase()}',
      other: '${S.of(context).were_modified} $countSendDay ${S.of(context).lines.toLowerCase()}',
      name: "modifylines",
      args: [countSendDay],
      examples: const {"countSendDay": 0},
    );
  }

  static String importData( BuildContext context, String array, int countImport) {

    String postVar = S.of(context).correctly.toLowerCase();

    return Intl.plural(
      countImport,
      one:  '${S.of(context).it_was_imported} $countImport $array $postVar',
      other: '${S.of(context).They_were_imported} $countImport $array $postVar',
      name: "importData",
      args: [countImport],
      examples: const {"countImport": 0},
    );
  }

  static String delete_Cant_Lines( BuildContext context,int cantLines) {

    return Intl.plural(
      cantLines,
      one:  '${S.of(context).has_been_removed} $cantLines ${S.of(context).line_correctly}',
      other: '${S.of(context).have_been_removed} $cantLines ${S.of(context).lines_correctly}',
      args: [cantLines],
      examples: const {"cantLines": 0},
    );
  }

  static String factorybeBD( BuildContext context,String factory) {

    String preVar = S.of(context).the_company;
    String postVar = S.of(context).that_company_does_not_belong_to_our_database.toLowerCase();

    return Intl.message(
      '$preVar $factory $postVar',
      name: 'factorybeBD',
      args: [factory, preVar, postVar],
      examples: const {'factory': 'factory', 'preVar': 'the company', 'postVar': 'does not belong to our database'},
    );
  }

  static String empleoyesBeFactory( BuildContext context,String empleoye) {

    String preVar = S.of(context).the_employee;
    String postVar = S.of(context).does_not_belong_to_the_company.toLowerCase();

    return Intl.message(
      '$preVar $empleoye $postVar',
      name: 'empleoyesBeFactory',
      args: [empleoye, preVar, postVar],
      examples: const {'empleoye': 'empleoye','preVar': 'the employee', 'postVar': 'does not belong to the company'},
    );
  }

  static String camp_empty( BuildContext context,String camp) {

    String preVar = S.of(context).the_field;
    String postVar = S.of(context).cannot_go_empty.toLowerCase();

    return Intl.message(
      '$preVar $camp $postVar',
      name: '$preVar $camp $postVar',
      args: [camp, preVar,postVar],
      examples: const {'campEmpty': 'campEmpty','preVar': 'the field', 'postVar': 'cant not go empty'},

    );
  }

  static String camp_empty_continue( BuildContext context,String camp) {

    String preVar = S.of(context).the_field;
    String postVar = S.of(context).You_cannot_leave_the_field_empty_you_want_to_continue.toLowerCase();

    return Intl.message(
      '$preVar $camp $postVar',
      name: '$preVar $camp $postVar',
      args: [camp, preVar,postVar],
      examples: const {'campEmptyContinue': 'campEmptyContinue','preVar': 'the field', 'postVar':'It cannot be empty. Do you want to continue?'},
    );
  }

  static String camp_number( BuildContext context,String camp) {

    String preVar = S.of(context).the_field;
    String postVar = S.of(context).it_must_be_numerical.toLowerCase();

    return Intl.message(
      '$preVar $camp $postVar',
      name: '$preVar $camp $postVar',
      args: [camp, preVar,postVar],
      examples: const {'campEmpty': 'campEmpty','preVar': 'the field', 'postVar': 'it_must_be_numerical'},

    );
  }
  static String cant_numbers( BuildContext context,String camp,int cant) {

    String preVar = S.of(context).theMale;
    String intermVar = S.of(context).must_have;
    String postVar = S.of(context).digits;
    camp = camp.toLowerCase();

    return Intl.message(
      '$preVar $camp $intermVar $cant $postVar',
      name: '$preVar $camp $postVar',
      args: [preVar, camp, postVar],
      examples: const {'manageArray': 'manageArray','preVar': 'the','intermVar': 'must_be', 'postVar':'digits'},
    );
  }
  static String no_file( BuildContext context,String array) {

    String preVar = S.of(context).no_file_exists;
    String postVar = ", ${S.of(context).They_will_be_saved_in_a_temporary_file.toLowerCase()}";

    return Intl.message(
      '$preVar $array $postVar',
      name: '$preVar $array $postVar',
      args: [array, preVar, postVar],
      examples: const {'noFile': 'noFile','preVar': 'no file exists', 'postVar':'will be saved in a temporary file'},
    );
  }

  static String no_do_import( BuildContext context,String array) {

    String preVar = S.of(context).there_is_no;
    String postVar =  S.of(context).to_import.toLowerCase();

    return Intl.message(
      '$preVar $array $postVar',
      name: '$preVar $array $postVar',
      args: [preVar, array, postVar],
      examples: const {'noDoImport': 'noDoImport','preVar': 'there is no', 'postVar':'to import'},
    );
  }

  static String no_companies_without( BuildContext context,String array) {

    String preVar = S.of(context).can_not_load;
    String postVar = S.of(context).Without_company.toLowerCase();

    return Intl.message(
      '$preVar $array $postVar',
      name: '$preVar $array $postVar',
      args: [preVar, array, postVar],
      examples: const {'noCompaniesWithout': 'noCompaniesWithout','preVar': 'can not load', 'postVar':'without company'},
    );
  }

  static String format_must( BuildContext context,String array) {

    String preVar = S.of(context).the_format_of_the;
    String postVar = S.of(context).must_be.toLowerCase();

    return Intl.message(
        '$preVar $array $postVar',
        name: '$preVar $array $postVar',
        args: [preVar, array, postVar],
        examples: const {'formatMust': 'formatMust','preVar': 'format', 'postVar':'must be'},
    );
  }

  static String manage_array( BuildContext context,String array,String actionArray, [String? pr]) {

    String preVar = S.of(context).theMale;

    if( pr != null)
    {
       preVar = S.of(context).theFemale;
    }

    String intermVar = S.of(context).it_has_been.toLowerCase();
    String postVar = S.of(context).correctly.toLowerCase();
    array = array.toLowerCase();
    actionArray = actionArray.toLowerCase();

    return Intl.message(
      '$preVar $array $intermVar $actionArray $postVar',
      name: '$preVar $array $postVar',
      args: [preVar, array, postVar],
      examples: const {'manageArray': 'manageArray','preVar': 'the','intermVar': 'he', 'postVar':'correctly'},
    );
  }

  static String no_array_departament( BuildContext context,String array) {

    String preVar = S.of(context).no_has;
    String postVar = S.of(context).in_that_department;
    array = array.toLowerCase();

    return Intl.message(
    '$preVar $array  $postVar',
    name: '$preVar $array $postVar',
    args: [preVar, array, postVar],
    examples: const {'noArrayDepartament': 'noArrayDepartament','preVar': 'does not have','postVar':'in department'},
    );
  }
  static String ask_confirm_supr( BuildContext context,String array) {

    String preVar = S.of(context).do_you_really_want_to_delete;
    String postVar = "?";
    array = array.toLowerCase();

    return Intl.message(
      '$preVar $array  $postVar',
      name: '$array $array $postVar',
      args: [preVar, array, postVar],
      examples: const {'askConfirmSupr': 'askConfirmSupr','preVar': 'really want to delete','postVar':'?'},
    );
  }


  static String delete_factory( BuildContext context,String array) {

    String preVar = S.of(context).the_company;
    String postVar = S.of(context).has_been_deleted_successfully.toLowerCase();
print(array);
    return Intl.message(
      '$preVar $array  $postVar',
      name: '$preVar $array $postVar',
      args: [array],
      examples: const {'deleteFactory': 'deleteFactory','preVar': 'the company','postVar':'has been successfully deleted'},
    );
  }
  static String no_array_BD( BuildContext context,String array) {

    String preVar = S.of(context).no_has;
    String postVar = S.of(context).in_the_database_what_do_you_want_to_do.toLowerCase();
    array = array.toLowerCase();

    return Intl.message(
      '$preVar $array  $postVar',
      name: '$preVar $array $postVar',
      args: [array],
      examples: const {'noArrayBD': 'noArrayBD','preVar': 'does not have','postVar':'in_database what do you want to do'},
    );
  }
  static String supr_array( BuildContext context,String array) {

    String preVar =  S.of(context).do_you_really_want_to_delete.toLowerCase();
    String postVar = "?";

    return Intl.message(
      '$preVar $array  $postVar',
      name: '$preVar $array $postVar',
      args: [array],
      examples: const {'suprArray': 'suprArray','preVar': 'want to delete','postVar':'?'},
    );
 }

}
