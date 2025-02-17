import 'package:crud_factories/generated/l10n.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:intl/intl.dart';

class LocalizationHelper {

  static String shippingFactory( BuildContext context,int countFactories) {

    String preVar = S.of(context).el_envio_tiene ;
    String postVar = S.of(context).empresas.toLowerCase();

    return Intl.plural(
      countFactories,
      one: '$preVar $countFactories $postVar',
      other: '$preVar $countFactories $postVar',
      name: "shipmentCompanies",
      args: [countFactories],
      examples: const {"count": 0},
    );
  }

  static String sendMails( BuildContext context,int countMailSend) {

    String preVar = S.of(context).se_han_enviado;
    String postVar = S.of(context).emails.toLowerCase();

    return Intl.plural(
      countMailSend,
      one:  '$preVar $countMailSend $postVar',
      other: '$preVar $countMailSend $postVar',
      name: "sendMails",
      args: [countMailSend],
      examples: const {"count": 0},
    );
  }

  static String factoriesBD( BuildContext context,int countFactoriesBD) {

    String preVar = S.of(context).tiene;
    String postVar = S.of(context).empresas_en_base_datos.toLowerCase();

    return Intl.plural(
      countFactoriesBD,
      one: '$preVar $countFactoriesBD $postVar',
      other: '$preVar $countFactoriesBD $postVar',
      name: "factoriesDatabase",
      args: [countFactoriesBD],
      examples: const {"count": 0},
    );
  }

  static String sendsFactory( BuildContext context,int countSendFactory) {

    String preVar = S.of(context).el_envio_contiene;
    String postVar = S.of(context).empresas.toLowerCase();

    return Intl.plural(
      countSendFactory,
      one: '$preVar $countSendFactory $postVar',
      other: '$preVar $countSendFactory $postVar',
      name: "sendsFactory",
      args: [countSendFactory],
      examples: const {"count": 0},
    );
  }
  static String sendsDay( BuildContext context,int countSendDay) {

    String preVar = S.of(context).este_dia_se_hicieron;
    String postVar = S.of(context).envios.toLowerCase();

    return Intl.plural(
      countSendDay,
      one: '$preVar $countSendDay $postVar',
      other: '$preVar $countSendDay $postVar',
      name: "sendsDay",
      args: [countSendDay],
      examples: const {"count": 0},
    );
  }
  static String cantLinesModify( BuildContext context,int countSendDay) {

    String preVar = S.of(context).fueron_modificadas;
    String postVar = S.of(context).lineas.toLowerCase();

    return Intl.plural(
      countSendDay,
      one: '$preVar $countSendDay $postVar',
      other: '$preVar $countSendDay $postVar',
      name: "modifylines",
      args: [countSendDay],
      examples: const {"count": 0},
    );
  }
  static String importData( BuildContext context, String array, int countSendDay) {

    String preVar = S.of(context).se_importaron;
    String postVar = S.of(context).correctamente.toLowerCase();

    return Intl.plural(
      countSendDay,
      one:  '$preVar $countSendDay $array $postVar',
      other: '$preVar $countSendDay $array $postVar',
      name: "importData",
      args: [countSendDay],
      examples: const {"count": 0},
    );
  }

  static String factorybeBD( BuildContext context,String factory) {

    String preVar = S.of(context).la_empresa;
    String postVar = S.of(context).no_pertenede_a_nuestra_base_de_datos.toLowerCase();

    return Intl.message(
      '$preVar $factory $postVar',
      name: '$preVar $factory $postVar',
      args: [factory],
      examples: const {'factory': 'factory1'},
    );
  }

  static String empleoyesBeFactory( BuildContext context,String empleoye) {

    String preVar = S.of(context).el_empleado;
    String postVar = S.of(context).no_pertenede_a_la_empresa.toLowerCase();

    return Intl.message(
      '$preVar $factory $postVar',
      name: '$preVar $factory $postVar',
      args: [factory],
      examples: const {'empleoye': 'empleoye'},
    );
  }
  static String camp_empty( BuildContext context,String campo) {

    String preVar = "el campo";
    String postVar = "no puede ir vacio";

    return Intl.message(
      '$preVar $factory $postVar',
      name: '$preVar $factory $postVar',
      args: [factory],
      examples: const {'campEmpty': 'campEmpty'},
    );
  }
  static String camp_empty_continue( BuildContext context,String campo) {

    String preVar = "el campo";
    String postVar = "no puede ir vacio ¿Desea continuar?";

    return Intl.message(
      '$preVar $factory $postVar',
      name: '$preVar $factory $postVar',
      args: [factory],
      examples: const {'campEmpty': 'campEmpty'},
    );
  }
  static String no_file( BuildContext context,String array) {

    String preVar = "No existe archivo de";
    String postVar = ", se guardarán en un archivo temporal";

    return Intl.message(
      '$preVar $factory $postVar',
      name: '$preVar $factory $postVar',
      args: [factory],
      examples: const {'campEmpty': 'campEmpty'},
    );
  }

  static String no_do_import( BuildContext context,String array) {

    String preVar = "No hay";
    String postVar = "para importar";

    return Intl.message(
      '$preVar $factory $postVar',
      name: '$preVar $factory $postVar',
      args: [factory],
      examples: const {'campEmpty': 'campEmpty'},
    );
  }

  static String no_companies_without( BuildContext context,String array) {

    String preVar = "No puede cargar";
    String postVar = "sin empresa";

    return Intl.message(
      '$preVar $factory $postVar',
      name: '$preVar $factory $postVar',
      args: [factory],
      examples: const {'campEmpty': 'campEmpty'},
    );
  }

  static String format_must( BuildContext context,String array) {

String preVar = "El formato de la";
String postVar = "debe de ser";

return Intl.message(
'$preVar $factory $postVar',
name: '$preVar $factory $postVar',
args: [factory],
examples: const {'campEmpty': 'campEmpty'},
);
}

  static String manage_array( BuildContext context,String array,String actionArray) {

    String preVar = "La";
    String intermVar = "se";
    String postVar = "correctamente";

    return Intl.message(
      '$preVar $array $intermVar $actionArray $postVar',
      name: '$preVar $factory $postVar',
      args: [factory],
      examples: const {'campEmpty': 'campEmpty'},
    );
  }


static String no_array_departament( BuildContext context,String array) {

String preVar = "No tiene";
String postVar = "en ese departamento";

return Intl.message(
'$preVar $array  $postVar',
name: '$preVar $factory $postVar',
args: [factory],
examples: const {'campEmpty': 'campEmpty'},
);
}

static String askConfirmSupr( BuildContext context,String array) {

    String preVar = "¿Realmente desea eliminar";
    String postVar = "?";

    return Intl.message(
      '$preVar $array  $postVar',
      name: '$preVar $factory $postVar',
      args: [factory],
      examples: const {'campEmpty': 'campEmpty'},
    );
  }

  static String delete_Cant_Lines( BuildContext context,int cantLines) {

    String preVar = "Se han eliminado";
    String postVar = "correctamente";

    return Intl.plural(
      cantLines,
      one:  '$preVar $cantLines $postVar',
      other: '$preVar $cantLines $postVar',
      name: "importData",
      args: [cantLines],
      examples: const {"count": 0},
    );
  }

  static String delete_Factory( BuildContext context,String array) {

    String preVar = "La empresa";
    String postVar = "se ha \n borrado correctamente";

    return Intl.message(
      '$preVar $array  $postVar',
      name: '$preVar $factory $postVar',
      args: [factory],
      examples: const {'campEmpty': 'campEmpty'},
    );
  }




}
