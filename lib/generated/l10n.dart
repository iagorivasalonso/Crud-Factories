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

  /// `Actualizar`
  String get actualizar {
    return Intl.message('Actualizar', name: 'actualizar', desc: '', args: []);
  }

  /// `Archivo`
  String get archivo {
    return Intl.message('Archivo', name: 'archivo', desc: '', args: []);
  }

  /// `Base de datos`
  String get base_de_datos {
    return Intl.message(
      'Base de datos',
      name: 'base_de_datos',
      desc: '',
      args: [],
    );
  }

  /// `Borrar`
  String get borrar {
    return Intl.message('Borrar', name: 'borrar', desc: '', args: []);
  }

  /// `Calle`
  String get calle {
    return Intl.message('Calle', name: 'calle', desc: '', args: []);
  }

  /// `Cancelar`
  String get cancelar {
    return Intl.message('Cancelar', name: 'cancelar', desc: '', args: []);
  }

  /// `Ciudad`
  String get ciudad {
    return Intl.message('Ciudad', name: 'ciudad', desc: '', args: []);
  }

  /// `Código postal`
  String get codigo_postal {
    return Intl.message(
      'Código postal',
      name: 'codigo_postal',
      desc: '',
      args: [],
    );
  }

  /// `Conexión base de datos`
  String get conexion_base_datos {
    return Intl.message(
      'Conexión base de datos',
      name: 'conexion_base_datos',
      desc: '',
      args: [],
    );
  }

  /// `Conexión no válida`
  String get conexion_no_valida {
    return Intl.message(
      'Conexión no válida',
      name: 'conexion_no_valida',
      desc: '',
      args: [],
    );
  }

  /// `Conectar`
  String get conectar {
    return Intl.message('Conectar', name: 'conectar', desc: '', args: []);
  }

  /// `Contacto`
  String get contacto {
    return Intl.message('Contacto', name: 'contacto', desc: '', args: []);
  }

  /// `Contactos en la empresa`
  String get contactos_en_la_empresa {
    return Intl.message(
      'Contactos en la empresa',
      name: 'contactos_en_la_empresa',
      desc: '',
      args: [],
    );
  }

  /// `Conexion BD`
  String get conexion_BD {
    return Intl.message('Conexion BD', name: 'conexion_BD', desc: '', args: []);
  }

  /// `Contraseña`
  String get contrasena {
    return Intl.message('Contraseña', name: 'contrasena', desc: '', args: []);
  }

  /// `Crear`
  String get crear {
    return Intl.message('Crear', name: 'crear', desc: '', args: []);
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

  /// `Desconectar`
  String get desconectar {
    return Intl.message('Desconectar', name: 'desconectar', desc: '', args: []);
  }

  /// `Deshacer`
  String get deshacer {
    return Intl.message('Deshacer', name: 'deshacer', desc: '', args: []);
  }

  /// `Dirección`
  String get direccion {
    return Intl.message('Dirección', name: 'direccion', desc: '', args: []);
  }

  /// `Editar`
  String get editar {
    return Intl.message('Editar', name: 'editar', desc: '', args: []);
  }

  /// `Eliminar`
  String get eliminar {
    return Intl.message('Eliminar', name: 'eliminar', desc: '', args: []);
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

  /// `Envío`
  String get envio {
    return Intl.message('Envío', name: 'envio', desc: '', args: []);
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

  /// `Está conectado a`
  String get esta_conectado_a {
    return Intl.message(
      'Está conectado a',
      name: 'esta_conectado_a',
      desc: '',
      args: [],
    );
  }

  /// `Envíos`
  String get envios {
    return Intl.message('Envíos', name: 'envios', desc: '', args: []);
  }

  /// `Fecha`
  String get fecha {
    return Intl.message('Fecha', name: 'fecha', desc: '', args: []);
  }

  /// `Filtrar`
  String get filtrar {
    return Intl.message('Filtrar', name: 'filtrar', desc: '', args: []);
  }

  /// `Fecha de alta`
  String get fecha_de_alta {
    return Intl.message(
      'Fecha de alta',
      name: 'fecha_de_alta',
      desc: '',
      args: [],
    );
  }

  /// `Guardar`
  String get guardar {
    return Intl.message('Guardar', name: 'guardar', desc: '', args: []);
  }

  /// `Guardado`
  String get guardado {
    return Intl.message('Guardado', name: 'guardado', desc: '', args: []);
  }

  /// `Ha cerrado la conexión`
  String get ha_cerrado_la_conexion {
    return Intl.message(
      'Ha cerrado la conexión',
      name: 'ha_cerrado_la_conexion',
      desc: '',
      args: [],
    );
  }

  /// `Host`
  String get host {
    return Intl.message('Host', name: 'host', desc: '', args: []);
  }

  /// `Importar`
  String get importar {
    return Intl.message('Importar', name: 'importar', desc: '', args: []);
  }

  /// `Nombre`
  String get nombre {
    return Intl.message('Nombre', name: 'nombre', desc: '', args: []);
  }

  /// `Nueva`
  String get nueva {
    return Intl.message('Nueva', name: 'nueva', desc: '', args: []);
  }

  /// `Nuevo`
  String get nuevo {
    return Intl.message('Nuevo', name: 'nuevo', desc: '', args: []);
  }

  /// `Conexion`
  String get conexion {
    return Intl.message('Conexion', name: 'conexion', desc: '', args: []);
  }

  /// `Creado`
  String get creado {
    return Intl.message('Creado', name: 'creado', desc: '', args: []);
  }

  /// `Estado`
  String get estado {
    return Intl.message('Estado', name: 'estado', desc: '', args: []);
  }

  /// `Observaciones`
  String get observaciones {
    return Intl.message(
      'Observaciones',
      name: 'observaciones',
      desc: '',
      args: [],
    );
  }

  /// `Listas`
  String get listas {
    return Intl.message('Listas', name: 'listas', desc: '', args: []);
  }

  /// `Nuevo email`
  String get nuevo_email {
    return Intl.message('Nuevo email', name: 'nuevo_email', desc: '', args: []);
  }

  /// `Número`
  String get numero {
    return Intl.message('Número', name: 'numero', desc: '', args: []);
  }

  /// `Página web`
  String get pagina_web {
    return Intl.message('Página web', name: 'pagina_web', desc: '', args: []);
  }

  /// `Provincia`
  String get provincia {
    return Intl.message('Provincia', name: 'provincia', desc: '', args: []);
  }

  /// `prueba de conexion`
  String get prueba_de_conexion {
    return Intl.message(
      'prueba de conexion',
      name: 'prueba_de_conexion',
      desc: '',
      args: [],
    );
  }

  /// `Puerto`
  String get puerto {
    return Intl.message('Puerto', name: 'puerto', desc: '', args: []);
  }

  /// `Salir`
  String get salir {
    return Intl.message('Salir', name: 'salir', desc: '', args: []);
  }

  /// `Sector`
  String get sector {
    return Intl.message('Sector', name: 'sector', desc: '', args: []);
  }

  /// `Sectores`
  String get sectores {
    return Intl.message('Sectores', name: 'sectores', desc: '', args: []);
  }

  /// `Seleccionar`
  String get seleccionar {
    return Intl.message('Seleccionar', name: 'seleccionar', desc: '', args: []);
  }

  /// `Teléfono`
  String get telefono {
    return Intl.message('Teléfono', name: 'telefono', desc: '', args: []);
  }

  /// `Teléfono 1`
  String get telefono_1 {
    return Intl.message('Teléfono 1', name: 'telefono_1', desc: '', args: []);
  }

  /// `Teléfono 2`
  String get telefono_2 {
    return Intl.message('Teléfono 2', name: 'telefono_2', desc: '', args: []);
  }

  /// `Todas`
  String get todas {
    return Intl.message('Todas', name: 'todas', desc: '', args: []);
  }

  /// `Todos`
  String get todos {
    return Intl.message('Todos', name: 'todos', desc: '', args: []);
  }

  /// `Usuario`
  String get usuario {
    return Intl.message('Usuario', name: 'usuario', desc: '', args: []);
  }

  /// `Utilidades`
  String get utilidades {
    return Intl.message('Utilidades', name: 'utilidades', desc: '', args: []);
  }

  /// `Ver`
  String get ver {
    return Intl.message('Ver', name: 'ver', desc: '', args: []);
  }

  /// `Volver`
  String get volver {
    return Intl.message('Volver', name: 'volver', desc: '', args: []);
  }

  /// `Rutas`
  String get rutas {
    return Intl.message('Rutas', name: 'rutas', desc: '', args: []);
  }

  /// `Tiene`
  String get tiene {
    return Intl.message('Tiene', name: 'tiene', desc: '', args: []);
  }

  /// `empresas en su base de datos`
  String get empresas_en_base_datos {
    return Intl.message(
      'empresas en su base de datos',
      name: 'empresas_en_base_datos',
      desc: '',
      args: [],
    );
  }

  /// `Fuente`
  String get fuente {
    return Intl.message('Fuente', name: 'fuente', desc: '', args: []);
  }

  /// `SQL`
  String get sql {
    return Intl.message('SQL', name: 'sql', desc: '', args: []);
  }

  /// `Cerrar`
  String get cerrar {
    return Intl.message('Cerrar', name: 'cerrar', desc: '', args: []);
  }

  /// `Otro`
  String get otro {
    return Intl.message('Otro', name: 'otro', desc: '', args: []);
  }

  /// `De`
  String get de {
    return Intl.message('De', name: 'de', desc: '', args: []);
  }

  /// `Examinar`
  String get examinar {
    return Intl.message('Examinar', name: 'examinar', desc: '', args: []);
  }

  /// `Remitente`
  String get remitente {
    return Intl.message('Remitente', name: 'remitente', desc: '', args: []);
  }

  /// `Para`
  String get para {
    return Intl.message('Para', name: 'para', desc: '', args: []);
  }

  /// `Ruta`
  String get ruta {
    return Intl.message('Ruta', name: 'ruta', desc: '', args: []);
  }

  /// `enviar`
  String get enviar {
    return Intl.message('enviar', name: 'enviar', desc: '', args: []);
  }

  /// `enviar a`
  String get enviar_a {
    return Intl.message('enviar a', name: 'enviar_a', desc: '', args: []);
  }

  /// `seleccionar envio`
  String get seleccionar_envio {
    return Intl.message(
      'seleccionar envio',
      name: 'seleccionar_envio',
      desc: '',
      args: [],
    );
  }

  /// `asunto`
  String get asunto {
    return Intl.message('asunto', name: 'asunto', desc: '', args: []);
  }

  /// `adjuntar`
  String get adjuntar {
    return Intl.message('adjuntar', name: 'adjuntar', desc: '', args: []);
  }

  /// `mensaje`
  String get mensaje {
    return Intl.message('mensaje', name: 'mensaje', desc: '', args: []);
  }

  /// `Reiniciar`
  String get reiniciar {
    return Intl.message('Reiniciar', name: 'reiniciar', desc: '', args: []);
  }

  /// `El envio tiene`
  String get el_envio_tiene {
    return Intl.message(
      'El envio tiene',
      name: 'el_envio_tiene',
      desc: '',
      args: [],
    );
  }

  /// `En curso`
  String get en_curso {
    return Intl.message('En curso', name: 'en_curso', desc: '', args: []);
  }

  /// `Devuelto`
  String get devuelto {
    return Intl.message('Devuelto', name: 'devuelto', desc: '', args: []);
  }

  /// `Respondió`
  String get respondio {
    return Intl.message('Respondió', name: 'respondio', desc: '', args: []);
  }

  /// `El código postal debe de tener 5 dígitos`
  String get el_codigo_postal_debe_de_tener_5_digitos {
    return Intl.message(
      'El código postal debe de tener 5 dígitos',
      name: 'el_codigo_postal_debe_de_tener_5_digitos',
      desc: '',
      args: [],
    );
  }

  /// `El empleado se ha quitado correctamente`
  String get el_empleado_se_ha_quitado_correctamente {
    return Intl.message(
      'El empleado se ha quitado correctamente',
      name: 'el_empleado_se_ha_quitado_correctamente',
      desc: '',
      args: [],
    );
  }

  /// `El sector se ha creado correctamente`
  String get el_sector_se_ha_creado_correctamente {
    return Intl.message(
      'El sector se ha creado correctamente',
      name: 'el_sector_se_ha_creado_correctamente',
      desc: '',
      args: [],
    );
  }

  /// `esto es una prueba de conexion desde la aplicacion`
  String get esto_es_una_prueba_de_conexion_desde_la_aplicacion {
    return Intl.message(
      'esto es una prueba de conexion desde la aplicacion',
      name: 'esto_es_una_prueba_de_conexion_desde_la_aplicacion',
      desc: '',
      args: [],
    );
  }

  /// `se ha borrado correctamente`
  String get se_ha_borrado_correctamente {
    return Intl.message(
      'se ha borrado correctamente',
      name: 'se_ha_borrado_correctamente',
      desc: '',
      args: [],
    );
  }

  /// `No tienes completo el archivo de rutas`
  String get no_tienes_completo_el_archivo_de_rutas {
    return Intl.message(
      'No tienes completo el archivo de rutas',
      name: 'no_tienes_completo_el_archivo_de_rutas',
      desc: '',
      args: [],
    );
  }

  /// `No tiene el archivo de rutas`
  String get no_tiene_el_archivo_de_rutas {
    return Intl.message(
      'No tiene el archivo de rutas',
      name: 'no_tiene_el_archivo_de_rutas',
      desc: '',
      args: [],
    );
  }

  /// `No tiene emails en su base de datos`
  String get no_tiene_emails_en_su_base_de_datos {
    return Intl.message(
      'No tiene emails en su base de datos',
      name: 'no_tiene_emails_en_su_base_de_datos',
      desc: '',
      args: [],
    );
  }

  /// `No es un correo electrónico válido`
  String get no_es_un_correo_electronico_valido {
    return Intl.message(
      'No es un correo electrónico válido',
      name: 'no_es_un_correo_electronico_valido',
      desc: '',
      args: [],
    );
  }

  /// `No es una página web válida`
  String get no_es_una_pagina_web_valida {
    return Intl.message(
      'No es una página web válida',
      name: 'no_es_una_pagina_web_valida',
      desc: '',
      args: [],
    );
  }

  /// `No está conectado a ninguna base de datos`
  String get no_esta_conectado_a_ninguna_base_de_datos {
    return Intl.message(
      'No está conectado a ninguna base de datos',
      name: 'no_esta_conectado_a_ninguna_base_de_datos',
      desc: '',
      args: [],
    );
  }

  /// `No pueden ir campos en blanco`
  String get no_pueden_ir_campos_en_blanco {
    return Intl.message(
      'No pueden ir campos en blanco',
      name: 'no_pueden_ir_campos_en_blanco',
      desc: '',
      args: [],
    );
  }

  /// `No puede hacer el envío porque no tiene empresas en su base de datos`
  String
  get no_puede_hacer_el_envio_porque_no_tiene_empresas_en_su_base_de_datos {
    return Intl.message(
      'No puede hacer el envío porque no tiene empresas en su base de datos',
      name:
          'no_puede_hacer_el_envio_porque_no_tiene_empresas_en_su_base_de_datos',
      desc: '',
      args: [],
    );
  }

  /// `No se pudo eliminar`
  String get no_se_pudo_eliminar {
    return Intl.message(
      'No se pudo eliminar',
      name: 'no_se_pudo_eliminar',
      desc: '',
      args: [],
    );
  }

  /// `No se pudo conectar con el servidor`
  String get no_se_pudo_conectar_con_el_servidor {
    return Intl.message(
      'No se pudo conectar con el servidor',
      name: 'no_se_pudo_conectar_con_el_servidor',
      desc: '',
      args: [],
    );
  }

  /// `No tiene emails registrados`
  String get no_tiene_emails_registrados {
    return Intl.message(
      'No tiene emails registrados',
      name: 'no_tiene_emails_registrados',
      desc: '',
      args: [],
    );
  }

  /// `No tiene ningun servidor conectado`
  String get no_tiene_ningun_servidor_conectado {
    return Intl.message(
      'No tiene ningun servidor conectado',
      name: 'no_tiene_ningun_servidor_conectado',
      desc: '',
      args: [],
    );
  }

  /// `Compruebe su usuario o contraseña`
  String get compruebe_su_usuario_o_contrasena {
    return Intl.message(
      'Compruebe su usuario o contraseña',
      name: 'compruebe_su_usuario_o_contrasena',
      desc: '',
      args: [],
    );
  }

  /// `Se ha eliminado correctamente la conexión`
  String get se_ha_eliminado_correctamente_la_conexion {
    return Intl.message(
      'Se ha eliminado correctamente la conexión',
      name: 'se_ha_eliminado_correctamente_la_conexion',
      desc: '',
      args: [],
    );
  }

  /// `No se puede establecer conexión`
  String get no_se_puede_establecer_conexion {
    return Intl.message(
      'No se puede establecer conexión',
      name: 'no_se_puede_establecer_conexion',
      desc: '',
      args: [],
    );
  }

  /// `Verificar contraseña`
  String get verificar_contrasena {
    return Intl.message(
      'Verificar contraseña',
      name: 'verificar_contrasena',
      desc: '',
      args: [],
    );
  }

  /// `No hay conexión con el servidor`
  String get no_hay_conexion_con_el_servidor {
    return Intl.message(
      'No hay conexión con el servidor',
      name: 'no_hay_conexion_con_el_servidor',
      desc: '',
      args: [],
    );
  }

  /// `Error SQL`
  String get error_sql {
    return Intl.message('Error SQL', name: 'error_sql', desc: '', args: []);
  }

  /// `No hay base de datos con ese nombre`
  String get no_base_de_datos_con_el_nombre {
    return Intl.message(
      'No hay base de datos con ese nombre',
      name: 'no_base_de_datos_con_el_nombre',
      desc: '',
      args: [],
    );
  }

  /// `El puerto no es correcto`
  String get el_puerto_no_es_correcto {
    return Intl.message(
      'El puerto no es correcto',
      name: 'el_puerto_no_es_correcto',
      desc: '',
      args: [],
    );
  }

  /// `El usuario o la contraseña son incorrectos`
  String get el_usuario_o_la_contrasena_son_incorrectos {
    return Intl.message(
      'El usuario o la contraseña son incorrectos',
      name: 'el_usuario_o_la_contrasena_son_incorrectos',
      desc: '',
      args: [],
    );
  }

  /// `Lista de`
  String get lista_de {
    return Intl.message('Lista de', name: 'lista_de', desc: '', args: []);
  }

  /// `Selector de rutas`
  String get selector_de_rutas {
    return Intl.message(
      'Selector de rutas',
      name: 'selector_de_rutas',
      desc: '',
      args: [],
    );
  }

  /// `Seleccionar archivo`
  String get seleccionar_archivo {
    return Intl.message(
      'Seleccionar archivo',
      name: 'seleccionar_archivo',
      desc: '',
      args: [],
    );
  }

  /// `Manejo de sectores`
  String get manejo_de_sectores {
    return Intl.message(
      'Manejo de sectores',
      name: 'manejo_de_sectores',
      desc: '',
      args: [],
    );
  }

  /// `Se han enviado`
  String get se_han_enviado {
    return Intl.message(
      'Se han enviado',
      name: 'se_han_enviado',
      desc: '',
      args: [],
    );
  }

  /// `un destinatario`
  String get un_destinatario {
    return Intl.message(
      'un destinatario',
      name: 'un_destinatario',
      desc: '',
      args: [],
    );
  }

  /// `varios destinatarios`
  String get varios_destinatarios {
    return Intl.message(
      'varios destinatarios',
      name: 'varios_destinatarios',
      desc: '',
      args: [],
    );
  }

  /// `Mo hay ningún envio seleccionado`
  String get no_hay_envios_seleccionados {
    return Intl.message(
      'Mo hay ningún envio seleccionado',
      name: 'no_hay_envios_seleccionados',
      desc: '',
      args: [],
    );
  }

  /// `El correo electrónico no es válido`
  String get correo_invalido {
    return Intl.message(
      'El correo electrónico no es válido',
      name: 'correo_invalido',
      desc: '',
      args: [],
    );
  }

  /// `Debe seleccionar una lista correcta`
  String get lista_incorrecta {
    return Intl.message(
      'Debe seleccionar una lista correcta',
      name: 'lista_incorrecta',
      desc: '',
      args: [],
    );
  }

  /// `El email se ha enviado correctamente`
  String get email_enviado_correctamente {
    return Intl.message(
      'El email se ha enviado correctamente',
      name: 'email_enviado_correctamente',
      desc: '',
      args: [],
    );
  }

  /// `No hay emails para enviar`
  String get no_hay_emails_para_enviar {
    return Intl.message(
      'No hay emails para enviar',
      name: 'no_hay_emails_para_enviar',
      desc: '',
      args: [],
    );
  }

  /// `El destinatario no es un correo electrónico válido`
  String get destinatario_no_valido {
    return Intl.message(
      'El destinatario no es un correo electrónico válido',
      name: 'destinatario_no_valido',
      desc: '',
      args: [],
    );
  }

  /// `Este día se hicieron`
  String get este_dia_se_hicieron {
    return Intl.message(
      'Este día se hicieron',
      name: 'este_dia_se_hicieron',
      desc: '',
      args: [],
    );
  }

  /// `A esta empresa se le hicieron`
  String get a_esta_empresa_se_le_hicieron {
    return Intl.message(
      'A esta empresa se le hicieron',
      name: 'a_esta_empresa_se_le_hicieron',
      desc: '',
      args: [],
    );
  }

  /// `Seleccionar todas`
  String get seleccionar_todas {
    return Intl.message(
      'Seleccionar todas',
      name: 'seleccionar_todas',
      desc: '',
      args: [],
    );
  }

  /// `El envio contiene`
  String get el_envio_contiene {
    return Intl.message(
      'El envio contiene',
      name: 'el_envio_contiene',
      desc: '',
      args: [],
    );
  }

  /// `No tiene ninguna línea a modificar`
  String get no_tiene_ninguna_linea_a_modificar {
    return Intl.message(
      'No tiene ninguna línea a modificar',
      name: 'no_tiene_ninguna_linea_a_modificar',
      desc: '',
      args: [],
    );
  }

  /// `No tenemos ningún envio en esa fecha`
  String get no_tenemos_ningun_envio_en_esa_fecha {
    return Intl.message(
      'No tenemos ningún envio en esa fecha',
      name: 'no_tenemos_ningun_envio_en_esa_fecha',
      desc: '',
      args: [],
    );
  }

  /// `Líneas`
  String get lineas {
    return Intl.message('Líneas', name: 'lineas', desc: '', args: []);
  }

  /// `Enviado`
  String get enviado {
    return Intl.message('Enviado', name: 'enviado', desc: '', args: []);
  }

  /// `Fueron modificadas`
  String get fueron_modificadas {
    return Intl.message(
      'Fueron modificadas',
      name: 'fueron_modificadas',
      desc: '',
      args: [],
    );
  }

  /// `Importar datos`
  String get importar_datos {
    return Intl.message(
      'Importar datos',
      name: 'importar_datos',
      desc: '',
      args: [],
    );
  }

  /// `Importar datos en formato CSV`
  String get importar_datos_csv {
    return Intl.message(
      'Importar datos en formato CSV',
      name: 'importar_datos_csv',
      desc: '',
      args: [],
    );
  }

  /// `No existe el sector`
  String get no_existe_sector {
    return Intl.message(
      'No existe el sector',
      name: 'no_existe_sector',
      desc: '',
      args: [],
    );
  }

  /// `No pertenede a la empresa`
  String get no_pertenede_a_la_empresa {
    return Intl.message(
      'No pertenede a la empresa',
      name: 'no_pertenede_a_la_empresa',
      desc: '',
      args: [],
    );
  }

  /// `No hay ninguna empresa para importar`
  String get no_hay_empresas_para_importar {
    return Intl.message(
      'No hay ninguna empresa para importar',
      name: 'no_hay_empresas_para_importar',
      desc: '',
      args: [],
    );
  }

  /// `No puede cargar las empresas porque no tiene sectores`
  String get no_puede_cargar_sin_sectores {
    return Intl.message(
      'No puede cargar las empresas porque no tiene sectores',
      name: 'no_puede_cargar_sin_sectores',
      desc: '',
      args: [],
    );
  }

  /// `Archivo no válido`
  String get archivo_no_valido {
    return Intl.message(
      'Archivo no válido',
      name: 'archivo_no_valido',
      desc: '',
      args: [],
    );
  }

  /// `Empleados`
  String get empleados {
    return Intl.message('Empleados', name: 'empleados', desc: '', args: []);
  }

  /// `Conexiones`
  String get conexiones {
    return Intl.message('Conexiones', name: 'conexiones', desc: '', args: []);
  }

  /// `Se importaron`
  String get se_importaron {
    return Intl.message(
      'Se importaron',
      name: 'se_importaron',
      desc: '',
      args: [],
    );
  }

  /// `Correctamente`
  String get correctamente {
    return Intl.message(
      'Correctamente',
      name: 'correctamente',
      desc: '',
      args: [],
    );
  }

  /// `La empresa`
  String get la_empresa {
    return Intl.message('La empresa', name: 'la_empresa', desc: '', args: []);
  }

  /// `Esa_empresa no pertenede a nuestra base de datos`
  String get esa_empresa_no_pertenede_a_nuestra_base_de_datos {
    return Intl.message(
      'Esa_empresa no pertenede a nuestra base de datos',
      name: 'esa_empresa_no_pertenede_a_nuestra_base_de_datos',
      desc: '',
      args: [],
    );
  }

  /// `No pertenede a nuestra base de datos`
  String get no_pertenede_a_nuestra_base_de_datos {
    return Intl.message(
      'No pertenede a nuestra base de datos',
      name: 'no_pertenede_a_nuestra_base_de_datos',
      desc: '',
      args: [],
    );
  }

  /// `La`
  String get la {
    return Intl.message('La', name: 'la', desc: '', args: []);
  }

  /// `El empleado`
  String get el_empleado {
    return Intl.message('El empleado', name: 'el_empleado', desc: '', args: []);
  }

  /// `El`
  String get el {
    return Intl.message('El', name: 'el', desc: '', args: []);
  }

  /// `Filtrar por`
  String get filtrar_por {
    return Intl.message('Filtrar por', name: 'filtrar_por', desc: '', args: []);
  }

  /// `buscar...`
  String get buscar {
    return Intl.message('buscar...', name: 'buscar', desc: '', args: []);
  }

  /// `Solo puede eliminar las líneas que fueron devueltas. ¿Desea eliminar?`
  String get solo_puede_eliminar_las_lineas_devueltas {
    return Intl.message(
      'Solo puede eliminar las líneas que fueron devueltas. ¿Desea eliminar?',
      name: 'solo_puede_eliminar_las_lineas_devueltas',
      desc: '',
      args: [],
    );
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
