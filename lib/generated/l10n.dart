// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Archivo`
  String get archivo {
    return Intl.message('Archivo', name: 'archivo', desc: '', args: []);
  }

  /// `ConexionBD`
  String get conexionBD {
    return Intl.message('ConexionBD', name: 'conexionBD', desc: '', args: []);
  }

  /// `¿Desea completarlo?`
  String get desea_completarlo {
    return Intl.message(
      '¿Desea completarlo?',
      name: 'desea_completarlo',
      desc: '',
      args: [],
    );
  }

  /// `El sector Se ha creado correctamente`
  String get el_sector_se_ha_creado_correctamente {
    return Intl.message(
      'El sector Se ha creado correctamente',
      name: 'el_sector_se_ha_creado_correctamente',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Emails`
  String get emails {
    return Intl.message('Emails', name: 'emails', desc: '', args: []);
  }

  /// `Empresa`
  String get empresa {
    return Intl.message('Empresa', name: 'empresa', desc: '', args: []);
  }

  /// `Empresas`
  String get empresas {
    return Intl.message('Empresas', name: 'empresas', desc: '', args: []);
  }

  /// `Envio`
  String get envio {
    return Intl.message('Envio', name: 'envio', desc: '', args: []);
  }

  /// `Envio de emails`
  String get envio_de_emails {
    return Intl.message(
      'Envio de emails',
      name: 'envio_de_emails',
      desc: '',
      args: [],
    );
  }

  /// `Envios`
  String get envios {
    return Intl.message('Envios', name: 'envios', desc: '', args: []);
  }

  /// `Importar`
  String get importar {
    return Intl.message('Importar', name: 'importar', desc: '', args: []);
  }

  /// `Listas`
  String get listas {
    return Intl.message('Listas', name: 'listas', desc: '', args: []);
  }

  /// `Nuevo`
  String get nuevo {
    return Intl.message('Nuevo', name: 'nuevo', desc: '', args: []);
  }

  /// `No tienes Completo el archivo de rutas`
  String get no_archivo_rutas {
    return Intl.message(
      'No tienes Completo el archivo de rutas',
      name: 'no_archivo_rutas',
      desc: '',
      args: [],
    );
  }

  /// `No existe Archivo de sectores`
  String get no_existe_archivo_de_sectores {
    return Intl.message(
      'No existe Archivo de sectores',
      name: 'no_existe_archivo_de_sectores',
      desc: '',
      args: [],
    );
  }

  /// `No puede Hacer el envio porque no tiene empresas en su base de datos`
  String
  get no_puede_hacer_el_envio_porque_no_tiene_empresas_en_su_base_de_datos {
    return Intl.message(
      'No puede Hacer el envio porque no tiene empresas en su base de datos',
      name:
          'no_puede_hacer_el_envio_porque_no_tiene_empresas_en_su_base_de_datos',
      desc: '',
      args: [],
    );
  }

  /// `No tiene Emails registrados`
  String get no_tiene_emails_registrados {
    return Intl.message(
      'No tiene Emails registrados',
      name: 'no_tiene_emails_registrados',
      desc: '',
      args: [],
    );
  }

  /// `Rutas`
  String get rutas {
    return Intl.message('Rutas', name: 'rutas', desc: '', args: []);
  }

  /// `Salir`
  String get salir {
    return Intl.message('Salir', name: 'salir', desc: '', args: []);
  }

  /// `Sectores`
  String get sectores {
    return Intl.message('Sectores', name: 'sectores', desc: '', args: []);
  }

  /// `Todas`
  String get todas {
    return Intl.message('Todas', name: 'todas', desc: '', args: []);
  }

  /// `Todos`
  String get todos {
    return Intl.message('Todos', name: 'todos', desc: '', args: []);
  }

  /// `Utilidades`
  String get utilidades {
    return Intl.message('Utilidades', name: 'utilidades', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[Locale.fromSubtags(languageCode: 'es')];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
