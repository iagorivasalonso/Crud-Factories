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
    final name = (locale.countryCode?.isEmpty ?? false)
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

  /// `Mi aplicación`
  String get appTitle {
    return Intl.message('Mi aplicación', name: 'appTitle', desc: '', args: []);
  }

  /// `Actualizar`
  String get update {
    return Intl.message('Actualizar', name: 'update', desc: '', args: []);
  }

  /// `Archivo`
  String get file {
    return Intl.message('Archivo', name: 'file', desc: '', args: []);
  }

  /// `Base de datos`
  String get data_base {
    return Intl.message('Base de datos', name: 'data_base', desc: '', args: []);
  }

  /// `Calle`
  String get street {
    return Intl.message('Calle', name: 'street', desc: '', args: []);
  }

  /// `Cancelar`
  String get cancel {
    return Intl.message('Cancelar', name: 'cancel', desc: '', args: []);
  }

  /// `Ciudad`
  String get city {
    return Intl.message('Ciudad', name: 'city', desc: '', args: []);
  }

  /// `Código postal`
  String get postal_code {
    return Intl.message(
      'Código postal',
      name: 'postal_code',
      desc: '',
      args: [],
    );
  }

  /// `Digitos`
  String get digits {
    return Intl.message('Digitos', name: 'digits', desc: '', args: []);
  }

  /// `Conexión a base de datos`
  String get database_connection {
    return Intl.message(
      'Conexión a base de datos',
      name: 'database_connection',
      desc: '',
      args: [],
    );
  }

  /// `Conexión no válida`
  String get invalid_connection {
    return Intl.message(
      'Conexión no válida',
      name: 'invalid_connection',
      desc: '',
      args: [],
    );
  }

  /// `Conectar`
  String get connect {
    return Intl.message('Conectar', name: 'connect', desc: '', args: []);
  }

  /// `Contacto`
  String get contact {
    return Intl.message('Contacto', name: 'contact', desc: '', args: []);
  }

  /// `Contactos de la empresa`
  String get company_contacts {
    return Intl.message(
      'Contactos de la empresa',
      name: 'company_contacts',
      desc: '',
      args: [],
    );
  }

  /// `Conexión a BD`
  String get DB_connection {
    return Intl.message(
      'Conexión a BD',
      name: 'DB_connection',
      desc: '',
      args: [],
    );
  }

  /// `Contraseña`
  String get password {
    return Intl.message('Contraseña', name: 'password', desc: '', args: []);
  }

  /// `Crear`
  String get create {
    return Intl.message('Crear', name: 'create', desc: '', args: []);
  }

  /// `Crear sector`
  String get create_sector {
    return Intl.message(
      'Crear sector',
      name: 'create_sector',
      desc: '',
      args: [],
    );
  }

  /// `sector editado correctamente`
  String get sector_edited_correctly {
    return Intl.message(
      'sector editado correctamente',
      name: 'sector_edited_correctly',
      desc: '',
      args: [],
    );
  }

  /// `¿Desea completarlo?`
  String get want_to_complete_it {
    return Intl.message(
      '¿Desea completarlo?',
      name: 'want_to_complete_it',
      desc: '',
      args: [],
    );
  }

  /// `Desconectar`
  String get disconnect {
    return Intl.message('Desconectar', name: 'disconnect', desc: '', args: []);
  }

  /// `Deshacer`
  String get undo {
    return Intl.message('Deshacer', name: 'undo', desc: '', args: []);
  }

  /// `Dirección`
  String get address {
    return Intl.message('Dirección', name: 'address', desc: '', args: []);
  }

  /// `Editar`
  String get edit {
    return Intl.message('Editar', name: 'edit', desc: '', args: []);
  }

  /// `Eliminar`
  String get delete {
    return Intl.message('Eliminar', name: 'delete', desc: '', args: []);
  }

  /// `Email`
  String get mail {
    return Intl.message('Email', name: 'mail', desc: '', args: []);
  }

  /// `Emails`
  String get mails {
    return Intl.message('Emails', name: 'mails', desc: '', args: []);
  }

  /// `Empresa`
  String get company {
    return Intl.message('Empresa', name: 'company', desc: '', args: []);
  }

  /// `Empresas`
  String get companies {
    return Intl.message('Empresas', name: 'companies', desc: '', args: []);
  }

  /// `Envío`
  String get shipment {
    return Intl.message('Envío', name: 'shipment', desc: '', args: []);
  }

  /// `Envíos`
  String get shipments {
    return Intl.message('Envíos', name: 'shipments', desc: '', args: []);
  }

  /// `Envío de emails`
  String get sending_mails {
    return Intl.message(
      'Envío de emails',
      name: 'sending_mails',
      desc: '',
      args: [],
    );
  }

  /// `Está conectado a`
  String get is_connected_to {
    return Intl.message(
      'Está conectado a',
      name: 'is_connected_to',
      desc: '',
      args: [],
    );
  }

  /// `Fecha`
  String get date {
    return Intl.message('Fecha', name: 'date', desc: '', args: []);
  }

  /// `Editar envio`
  String get edit_shipment {
    return Intl.message(
      'Editar envio',
      name: 'edit_shipment',
      desc: '',
      args: [],
    );
  }

  /// `Filtrar`
  String get filter {
    return Intl.message('Filtrar', name: 'filter', desc: '', args: []);
  }

  /// `Fecha de alta`
  String get discharge_date {
    return Intl.message(
      'Fecha de alta',
      name: 'discharge_date',
      desc: '',
      args: [],
    );
  }

  /// `Guardar`
  String get save {
    return Intl.message('Guardar', name: 'save', desc: '', args: []);
  }

  /// `Guardado`
  String get saved {
    return Intl.message('Guardado', name: 'saved', desc: '', args: []);
  }

  /// `Envios`
  String get sends {
    return Intl.message('Envios', name: 'sends', desc: '', args: []);
  }

  /// `Host`
  String get host {
    return Intl.message('Host', name: 'host', desc: '', args: []);
  }

  /// `Importar`
  String get import {
    return Intl.message('Importar', name: 'import', desc: '', args: []);
  }

  /// `Nombre`
  String get name {
    return Intl.message('Nombre', name: 'name', desc: '', args: []);
  }

  /// `Nueva`
  String get newFemale {
    return Intl.message('Nueva', name: 'newFemale', desc: '', args: []);
  }

  /// `Nuevo`
  String get newMale {
    return Intl.message('Nuevo', name: 'newMale', desc: '', args: []);
  }

  /// `Conexión`
  String get connection {
    return Intl.message('Conexión', name: 'connection', desc: '', args: []);
  }

  /// `Creado`
  String get created {
    return Intl.message('Creado', name: 'created', desc: '', args: []);
  }

  /// `Estado`
  String get state {
    return Intl.message('Estado', name: 'state', desc: '', args: []);
  }

  /// `Observaciones`
  String get observations {
    return Intl.message(
      'Observaciones',
      name: 'observations',
      desc: '',
      args: [],
    );
  }

  /// `Listas`
  String get lists {
    return Intl.message('Listas', name: 'lists', desc: '', args: []);
  }

  /// `Lista de empresas`
  String get list_of_companies {
    return Intl.message(
      'Lista de empresas',
      name: 'list_of_companies',
      desc: '',
      args: [],
    );
  }

  /// `Lista de emails`
  String get list_of_emails {
    return Intl.message(
      'Lista de emails',
      name: 'list_of_emails',
      desc: '',
      args: [],
    );
  }

  /// `Lista de envios`
  String get list_of_sends {
    return Intl.message(
      'Lista de envios',
      name: 'list_of_sends',
      desc: '',
      args: [],
    );
  }

  /// `Nuevo mail`
  String get new_mail {
    return Intl.message('Nuevo mail', name: 'new_mail', desc: '', args: []);
  }

  /// `Nuevo envio`
  String get new_shipment {
    return Intl.message(
      'Nuevo envio',
      name: 'new_shipment',
      desc: '',
      args: [],
    );
  }

  /// `Número`
  String get number {
    return Intl.message('Número', name: 'number', desc: '', args: []);
  }

  /// `Página web`
  String get web_page {
    return Intl.message('Página web', name: 'web_page', desc: '', args: []);
  }

  /// `Provincia`
  String get province {
    return Intl.message('Provincia', name: 'province', desc: '', args: []);
  }

  /// `Prueba de conexión`
  String get connection_test {
    return Intl.message(
      'Prueba de conexión',
      name: 'connection_test',
      desc: '',
      args: [],
    );
  }

  /// `Puerto`
  String get port {
    return Intl.message('Puerto', name: 'port', desc: '', args: []);
  }

  /// `Salir`
  String get go_out {
    return Intl.message('Salir', name: 'go_out', desc: '', args: []);
  }

  /// `Sector`
  String get sector {
    return Intl.message('Sector', name: 'sector', desc: '', args: []);
  }

  /// `Sectores`
  String get sectors {
    return Intl.message('Sectores', name: 'sectors', desc: '', args: []);
  }

  /// `Seleccionar`
  String get select {
    return Intl.message('Seleccionar', name: 'select', desc: '', args: []);
  }

  /// `Teléfono`
  String get phone {
    return Intl.message('Teléfono', name: 'phone', desc: '', args: []);
  }

  /// `Teléfono 1`
  String get phone_1 {
    return Intl.message('Teléfono 1', name: 'phone_1', desc: '', args: []);
  }

  /// `Teléfono 2`
  String get phone_2 {
    return Intl.message('Teléfono 2', name: 'phone_2', desc: '', args: []);
  }

  /// `Todas`
  String get allFemale {
    return Intl.message('Todas', name: 'allFemale', desc: '', args: []);
  }

  /// `Todos`
  String get allMale {
    return Intl.message('Todos', name: 'allMale', desc: '', args: []);
  }

  /// `Usuario`
  String get user {
    return Intl.message('Usuario', name: 'user', desc: '', args: []);
  }

  /// `Utilidades`
  String get utilities {
    return Intl.message('Utilidades', name: 'utilities', desc: '', args: []);
  }

  /// `Ver`
  String get ver {
    return Intl.message('Ver', name: 'ver', desc: '', args: []);
  }

  /// `Volver`
  String get back {
    return Intl.message('Volver', name: 'back', desc: '', args: []);
  }

  /// `Para`
  String get para {
    return Intl.message('Para', name: 'para', desc: '', args: []);
  }

  /// `De`
  String get de {
    return Intl.message('De', name: 'de', desc: '', args: []);
  }

  /// `Del`
  String get ofThe {
    return Intl.message('Del', name: 'ofThe', desc: '', args: []);
  }

  /// `Rutas`
  String get routes {
    return Intl.message('Rutas', name: 'routes', desc: '', args: []);
  }

  /// `Ruta`
  String get route {
    return Intl.message('Ruta', name: 'route', desc: '', args: []);
  }

  /// `Tiene`
  String get has {
    return Intl.message('Tiene', name: 'has', desc: '', args: []);
  }

  /// `Empresas en su base de datos`
  String get company_en_base_datos {
    return Intl.message(
      'Empresas en su base de datos',
      name: 'company_en_base_datos',
      desc: '',
      args: [],
    );
  }

  /// `Empresas en su base de datos`
  String get companies_en_base_datos {
    return Intl.message(
      'Empresas en su base de datos',
      name: 'companies_en_base_datos',
      desc: '',
      args: [],
    );
  }

  /// `Fuente`
  String get source {
    return Intl.message('Fuente', name: 'source', desc: '', args: []);
  }

  /// `SQL`
  String get sql {
    return Intl.message('SQL', name: 'sql', desc: '', args: []);
  }

  /// `CSV`
  String get csv {
    return Intl.message('CSV', name: 'csv', desc: '', args: []);
  }

  /// `Cerrar`
  String get close {
    return Intl.message('Cerrar', name: 'close', desc: '', args: []);
  }

  /// `Cuidado`
  String get careful {
    return Intl.message('Cuidado', name: 'careful', desc: '', args: []);
  }

  /// `Otro`
  String get orther {
    return Intl.message('Otro', name: 'orther', desc: '', args: []);
  }

  /// `Examinar`
  String get examine {
    return Intl.message('Examinar', name: 'examine', desc: '', args: []);
  }

  /// `Remitente`
  String get sender {
    return Intl.message('Remitente', name: 'sender', desc: '', args: []);
  }

  /// `Enviar`
  String get send {
    return Intl.message('Enviar', name: 'send', desc: '', args: []);
  }

  /// `Enviar a`
  String get send_a {
    return Intl.message('Enviar a', name: 'send_a', desc: '', args: []);
  }

  /// `Seleccionar envío`
  String get select_shipment {
    return Intl.message(
      'Seleccionar envío',
      name: 'select_shipment',
      desc: '',
      args: [],
    );
  }

  /// `Asunto`
  String get affair {
    return Intl.message('Asunto', name: 'affair', desc: '', args: []);
  }

  /// `Adjuntar`
  String get attach {
    return Intl.message('Adjuntar', name: 'attach', desc: '', args: []);
  }

  /// `Mensaje`
  String get message {
    return Intl.message('Mensaje', name: 'message', desc: '', args: []);
  }

  /// `Reiniciar`
  String get reboot {
    return Intl.message('Reiniciar', name: 'reboot', desc: '', args: []);
  }

  /// `El envío tiene`
  String get el_shipment_has {
    return Intl.message(
      'El envío tiene',
      name: 'el_shipment_has',
      desc: '',
      args: [],
    );
  }

  /// `Preparado`
  String get prepared {
    return Intl.message('Preparado', name: 'prepared', desc: '', args: []);
  }

  /// `En curso`
  String get in_progress {
    return Intl.message('En curso', name: 'in_progress', desc: '', args: []);
  }

  /// `Devuelto`
  String get returned {
    return Intl.message('Devuelto', name: 'returned', desc: '', args: []);
  }

  /// `Respondió`
  String get he_responded {
    return Intl.message('Respondió', name: 'he_responded', desc: '', args: []);
  }

  /// `Pendiente`
  String get pending {
    return Intl.message('Pendiente', name: 'pending', desc: '', args: []);
  }

  /// `Línea`
  String get line {
    return Intl.message('Línea', name: 'line', desc: '', args: []);
  }

  /// `Líneas`
  String get lines {
    return Intl.message('Líneas', name: 'lines', desc: '', args: []);
  }

  /// `Enviado`
  String get enviado {
    return Intl.message('Enviado', name: 'enviado', desc: '', args: []);
  }

  /// `Debe de ser numérico`
  String get it_must_be_numerical {
    return Intl.message(
      'Debe de ser numérico',
      name: 'it_must_be_numerical',
      desc: '',
      args: [],
    );
  }

  /// `Debe de tener`
  String get must_have {
    return Intl.message('Debe de tener', name: 'must_have', desc: '', args: []);
  }

  /// `Datos no encontrados`
  String get data_not_found {
    return Intl.message(
      'Datos no encontrados',
      name: 'data_not_found',
      desc: '',
      args: [],
    );
  }

  /// `No se encontraron datos en memoria. ¿Qué desea hacer?`
  String get no_data_in_memory {
    return Intl.message(
      'No se encontraron datos en memoria. ¿Qué desea hacer?',
      name: 'no_data_in_memory',
      desc: '',
      args: [],
    );
  }

  /// `Ver demo`
  String get view_demo {
    return Intl.message('Ver demo', name: 'view_demo', desc: '', args: []);
  }

  /// `Cargar datos`
  String get load_data {
    return Intl.message('Cargar datos', name: 'load_data', desc: '', args: []);
  }

  /// `El empleado se ha eliminado correctamente`
  String get the_employee_has_been_correctly_removed {
    return Intl.message(
      'El empleado se ha eliminado correctamente',
      name: 'the_employee_has_been_correctly_removed',
      desc: '',
      args: [],
    );
  }

  /// `En el sector, se mostrarán todas las`
  String get all_the_sector_will_be_showcased {
    return Intl.message(
      'En el sector, se mostrarán todas las',
      name: 'all_the_sector_will_be_showcased',
      desc: '',
      args: [],
    );
  }

  /// `El sector se ha creado correctamente`
  String get the_sector_has_been_created_successfully {
    return Intl.message(
      'El sector se ha creado correctamente',
      name: 'the_sector_has_been_created_successfully',
      desc: '',
      args: [],
    );
  }

  /// `El sector se ha eliminado correctamente`
  String get the_sector_has_been_successfully_removed {
    return Intl.message(
      'El sector se ha eliminado correctamente',
      name: 'the_sector_has_been_successfully_removed',
      desc: '',
      args: [],
    );
  }

  /// `Esta es una prueba de conexión desde la aplicación`
  String get this_is_a_connection_test_from_the_application {
    return Intl.message(
      'Esta es una prueba de conexión desde la aplicación',
      name: 'this_is_a_connection_test_from_the_application',
      desc: '',
      args: [],
    );
  }

  /// `Se ha eliminado correctamente`
  String get has_been_deleted_successfully {
    return Intl.message(
      'Se ha eliminado correctamente',
      name: 'has_been_deleted_successfully',
      desc: '',
      args: [],
    );
  }

  /// `No tienes un archivo de rutas completo`
  String get you_do_not_have_a_complete_route_file {
    return Intl.message(
      'No tienes un archivo de rutas completo',
      name: 'you_do_not_have_a_complete_route_file',
      desc: '',
      args: [],
    );
  }

  /// `No tienes correos electrónicos en tu base de datos`
  String get you_do_not_have_mails_in_your_database {
    return Intl.message(
      'No tienes correos electrónicos en tu base de datos',
      name: 'you_do_not_have_mails_in_your_database',
      desc: '',
      args: [],
    );
  }

  /// `No es un correo electrónico válido`
  String get not_a_valid_mail {
    return Intl.message(
      'No es un correo electrónico válido',
      name: 'not_a_valid_mail',
      desc: '',
      args: [],
    );
  }

  /// `No es una página web válida`
  String get not_a_valid_webpage {
    return Intl.message(
      'No es una página web válida',
      name: 'not_a_valid_webpage',
      desc: '',
      args: [],
    );
  }

  /// `No estás conectado a ninguna base de datos`
  String get not_connected_to_any_database {
    return Intl.message(
      'No estás conectado a ninguna base de datos',
      name: 'not_connected_to_any_database',
      desc: '',
      args: [],
    );
  }

  /// `No pueden quedar campos en blanco`
  String get can_not_go_blank_fields {
    return Intl.message(
      'No pueden quedar campos en blanco',
      name: 'can_not_go_blank_fields',
      desc: '',
      args: [],
    );
  }

  /// `No puedes realizar el envío porque no tienes empresas en tu base de datos`
  String
  get you_can_not_make_the_shipping_because_you_do_not_have_companies_in_your_database {
    return Intl.message(
      'No puedes realizar el envío porque no tienes empresas en tu base de datos',
      name:
          'you_can_not_make_the_shipping_because_you_do_not_have_companies_in_your_database',
      desc: '',
      args: [],
    );
  }

  /// `Todos los cambios se perderán. ¿Desea continuar?`
  String get all_changes_will_be_lost_do_you_want_to_continue {
    return Intl.message(
      'Todos los cambios se perderán. ¿Desea continuar?',
      name: 'all_changes_will_be_lost_do_you_want_to_continue',
      desc: '',
      args: [],
    );
  }

  /// `No se pudo eliminar`
  String get could_not_be_deleted {
    return Intl.message(
      'No se pudo eliminar',
      name: 'could_not_be_deleted',
      desc: '',
      args: [],
    );
  }

  /// `No se pudo editar`
  String get could_not_be_edited {
    return Intl.message(
      'No se pudo editar',
      name: 'could_not_be_edited',
      desc: '',
      args: [],
    );
  }

  /// `No se pudo conectar con el servidor`
  String get could_not_connect_with_the_server {
    return Intl.message(
      'No se pudo conectar con el servidor',
      name: 'could_not_connect_with_the_server',
      desc: '',
      args: [],
    );
  }

  /// `la prueba de conexion se envio correctamente`
  String get the_connection_test_was_sent_successfully {
    return Intl.message(
      'la prueba de conexion se envio correctamente',
      name: 'the_connection_test_was_sent_successfully',
      desc: '',
      args: [],
    );
  }

  /// `No se pudo crear la base de datos`
  String get could_not_create_database {
    return Intl.message(
      'No se pudo crear la base de datos',
      name: 'could_not_create_database',
      desc: '',
      args: [],
    );
  }

  /// `No se pudieron crear las tablas de la base de datos`
  String get database_tables_could_not_be_created {
    return Intl.message(
      'No se pudieron crear las tablas de la base de datos',
      name: 'database_tables_could_not_be_created',
      desc: '',
      args: [],
    );
  }

  /// `No se pudo eliminar la base de datos`
  String get could_not_delete_database {
    return Intl.message(
      'No se pudo eliminar la base de datos',
      name: 'could_not_delete_database',
      desc: '',
      args: [],
    );
  }

  /// `Error al modificar el el nombre de la base de datos`
  String get error_modifying_the_database_name {
    return Intl.message(
      'Error al modificar el el nombre de la base de datos',
      name: 'error_modifying_the_database_name',
      desc: '',
      args: [],
    );
  }

  /// `No tienes correos electrónicos registrados`
  String get no_have_registered_mails {
    return Intl.message(
      'No tienes correos electrónicos registrados',
      name: 'no_have_registered_mails',
      desc: '',
      args: [],
    );
  }

  /// `No tienes ningún servidor conectado`
  String get has_no_server_connected {
    return Intl.message(
      'No tienes ningún servidor conectado',
      name: 'has_no_server_connected',
      desc: '',
      args: [],
    );
  }

  /// `No se encontró la conexión`
  String get sqlConnectionNotFound {
    return Intl.message(
      'No se encontró la conexión',
      name: 'sqlConnectionNotFound',
      desc: '',
      args: [],
    );
  }

  /// `La conexión ya existe`
  String get sqlConnectionAlreadyExists {
    return Intl.message(
      'La conexión ya existe',
      name: 'sqlConnectionAlreadyExists',
      desc: '',
      args: [],
    );
  }

  /// `La conexión se ha eliminado correctamente`
  String get connection_has_been_successfully_deleted {
    return Intl.message(
      'La conexión se ha eliminado correctamente',
      name: 'connection_has_been_successfully_deleted',
      desc: '',
      args: [],
    );
  }

  /// `No se puede establecer la conexión`
  String get connection_cannot_be_established {
    return Intl.message(
      'No se puede establecer la conexión',
      name: 'connection_cannot_be_established',
      desc: '',
      args: [],
    );
  }

  /// `No se puede leer el archivo de rutas`
  String get route_file_cannot_be_read {
    return Intl.message(
      'No se puede leer el archivo de rutas',
      name: 'route_file_cannot_be_read',
      desc: '',
      args: [],
    );
  }

  /// `Servidor`
  String get server {
    return Intl.message('Servidor', name: 'server', desc: '', args: []);
  }

  /// `Verificar contraseña`
  String get verify_password {
    return Intl.message(
      'Verificar contraseña',
      name: 'verify_password',
      desc: '',
      args: [],
    );
  }

  /// `Las contraseñas no coinciden`
  String get passwords_do_not_match {
    return Intl.message(
      'Las contraseñas no coinciden',
      name: 'passwords_do_not_match',
      desc: '',
      args: [],
    );
  }

  /// `No hay`
  String get there_is_no {
    return Intl.message('No hay', name: 'there_is_no', desc: '', args: []);
  }

  /// `No hay conexión con el servidor`
  String get There_is_no_connection_to_the_server {
    return Intl.message(
      'No hay conexión con el servidor',
      name: 'There_is_no_connection_to_the_server',
      desc: '',
      args: [],
    );
  }

  /// `Error SQL`
  String get sql_error {
    return Intl.message('Error SQL', name: 'sql_error', desc: '', args: []);
  }

  /// `Error de categoría`
  String get category_error {
    return Intl.message(
      'Error de categoría',
      name: 'category_error',
      desc: '',
      args: [],
    );
  }

  /// `No existe una base de datos con ese nombre`
  String get there_is_no_database_with_that_name {
    return Intl.message(
      'No existe una base de datos con ese nombre',
      name: 'there_is_no_database_with_that_name',
      desc: '',
      args: [],
    );
  }

  /// `El puerto no es correcto`
  String get the_port_is_not_correct {
    return Intl.message(
      'El puerto no es correcto',
      name: 'the_port_is_not_correct',
      desc: '',
      args: [],
    );
  }

  /// `El usuario o la contraseña son incorrectos`
  String get the_user_or_password_are_incorrect {
    return Intl.message(
      'El usuario o la contraseña son incorrectos',
      name: 'the_user_or_password_are_incorrect',
      desc: '',
      args: [],
    );
  }

  /// `Ha cerrado la conexión`
  String get has_closed_the_connection {
    return Intl.message(
      'Ha cerrado la conexión',
      name: 'has_closed_the_connection',
      desc: '',
      args: [],
    );
  }

  /// `Lista de`
  String get list_of {
    return Intl.message('Lista de', name: 'list_of', desc: '', args: []);
  }

  /// `Para importar`
  String get to_import {
    return Intl.message('Para importar', name: 'to_import', desc: '', args: []);
  }

  /// `Selector de rutas`
  String get route_selector {
    return Intl.message(
      'Selector de rutas',
      name: 'route_selector',
      desc: '',
      args: [],
    );
  }

  /// `Seleccionar archivo`
  String get select_file {
    return Intl.message(
      'Seleccionar archivo',
      name: 'select_file',
      desc: '',
      args: [],
    );
  }

  /// `Gestión de sectores`
  String get sector_management {
    return Intl.message(
      'Gestión de sectores',
      name: 'sector_management',
      desc: '',
      args: [],
    );
  }

  /// `Se ha enviado`
  String get has_been_sent {
    return Intl.message(
      'Se ha enviado',
      name: 'has_been_sent',
      desc: '',
      args: [],
    );
  }

  /// `Se han enviado`
  String get have_been_sent {
    return Intl.message(
      'Se han enviado',
      name: 'have_been_sent',
      desc: '',
      args: [],
    );
  }

  /// `Un destinatario`
  String get a_recipient {
    return Intl.message(
      'Un destinatario',
      name: 'a_recipient',
      desc: '',
      args: [],
    );
  }

  /// `Varios destinatarios`
  String get multiple_recipients {
    return Intl.message(
      'Varios destinatarios',
      name: 'multiple_recipients',
      desc: '',
      args: [],
    );
  }

  /// `Empleados`
  String get employees {
    return Intl.message('Empleados', name: 'employees', desc: '', args: []);
  }

  /// `Conexiones`
  String get connections {
    return Intl.message('Conexiones', name: 'connections', desc: '', args: []);
  }

  /// `Se importó`
  String get it_was_imported {
    return Intl.message(
      'Se importó',
      name: 'it_was_imported',
      desc: '',
      args: [],
    );
  }

  /// `Se importaron`
  String get They_were_imported {
    return Intl.message(
      'Se importaron',
      name: 'They_were_imported',
      desc: '',
      args: [],
    );
  }

  /// `correctamente`
  String get correctly {
    return Intl.message('correctamente', name: 'correctly', desc: '', args: []);
  }

  /// `La empresa`
  String get the_company {
    return Intl.message('La empresa', name: 'the_company', desc: '', args: []);
  }

  /// `La`
  String get theFemale {
    return Intl.message('La', name: 'theFemale', desc: '', args: []);
  }

  /// `El`
  String get theMale {
    return Intl.message('El', name: 'theMale', desc: '', args: []);
  }

  /// `El empleado`
  String get the_employee {
    return Intl.message(
      'El empleado',
      name: 'the_employee',
      desc: '',
      args: [],
    );
  }

  /// `el`
  String get he {
    return Intl.message('el', name: 'he', desc: '', args: []);
  }

  /// `Filtrar por`
  String get filter_by {
    return Intl.message('Filtrar por', name: 'filter_by', desc: '', args: []);
  }

  /// `Buscar...`
  String get search {
    return Intl.message('Buscar...', name: 'search', desc: '', args: []);
  }

  /// `Tipo de fuente`
  String get font_type {
    return Intl.message(
      'Tipo de fuente',
      name: 'font_type',
      desc: '',
      args: [],
    );
  }

  /// `Confirmar`
  String get confirm {
    return Intl.message('Confirmar', name: 'confirm', desc: '', args: []);
  }

  /// `Sí`
  String get yes {
    return Intl.message('Sí', name: 'yes', desc: '', args: []);
  }

  /// `No`
  String get no {
    return Intl.message('No', name: 'no', desc: '', args: []);
  }

  /// `Aceptar`
  String get acept {
    return Intl.message('Aceptar', name: 'acept', desc: '', args: []);
  }

  /// `Error`
  String get error {
    return Intl.message('Error', name: 'error', desc: '', args: []);
  }

  /// `Enviado`
  String get sent {
    return Intl.message('Enviado', name: 'sent', desc: '', args: []);
  }

  /// `Enero`
  String get january {
    return Intl.message('Enero', name: 'january', desc: '', args: []);
  }

  /// `Febrero`
  String get february {
    return Intl.message('Febrero', name: 'february', desc: '', args: []);
  }

  /// `Marzo`
  String get march {
    return Intl.message('Marzo', name: 'march', desc: '', args: []);
  }

  /// `Abril`
  String get april {
    return Intl.message('Abril', name: 'april', desc: '', args: []);
  }

  /// `Mayo`
  String get may {
    return Intl.message('Mayo', name: 'may', desc: '', args: []);
  }

  /// `Junio`
  String get june {
    return Intl.message('Junio', name: 'june', desc: '', args: []);
  }

  /// `Julio`
  String get july {
    return Intl.message('Julio', name: 'july', desc: '', args: []);
  }

  /// `Agosto`
  String get august {
    return Intl.message('Agosto', name: 'august', desc: '', args: []);
  }

  /// `Septiembre`
  String get september {
    return Intl.message('Septiembre', name: 'september', desc: '', args: []);
  }

  /// `Octubre`
  String get october {
    return Intl.message('Octubre', name: 'october', desc: '', args: []);
  }

  /// `Noviembre`
  String get november {
    return Intl.message('Noviembre', name: 'november', desc: '', args: []);
  }

  /// `Diciembre`
  String get december {
    return Intl.message('Diciembre', name: 'december', desc: '', args: []);
  }

  /// `No hay ningún envío seleccionado`
  String get there_is_no_shipping_selected {
    return Intl.message(
      'No hay ningún envío seleccionado',
      name: 'there_is_no_shipping_selected',
      desc: '',
      args: [],
    );
  }

  /// `Tu correo electrónico no es válido`
  String get your_mail_is_invalid {
    return Intl.message(
      'Tu correo electrónico no es válido',
      name: 'your_mail_is_invalid',
      desc: '',
      args: [],
    );
  }

  /// `Debes seleccionar una lista correcta`
  String get You_must_select_a_correct_list {
    return Intl.message(
      'Debes seleccionar una lista correcta',
      name: 'You_must_select_a_correct_list',
      desc: '',
      args: [],
    );
  }

  /// `Debes seleccionar una conexion`
  String get You_must_select_a_connection {
    return Intl.message(
      'Debes seleccionar una conexion',
      name: 'You_must_select_a_connection',
      desc: '',
      args: [],
    );
  }

  /// `El correo electrónico se ha enviado correctamente`
  String get the_mail_has_been_successfully_sent {
    return Intl.message(
      'El correo electrónico se ha enviado correctamente',
      name: 'the_mail_has_been_successfully_sent',
      desc: '',
      args: [],
    );
  }

  /// `No hay correos electrónicos para enviar`
  String get there_is_no_mails_para_send {
    return Intl.message(
      'No hay correos electrónicos para enviar',
      name: 'there_is_no_mails_para_send',
      desc: '',
      args: [],
    );
  }

  /// `El destinatario no es un correo electrónico válido`
  String get The_recipient_is_not_a_valid_mail {
    return Intl.message(
      'El destinatario no es un correo electrónico válido',
      name: 'The_recipient_is_not_a_valid_mail',
      desc: '',
      args: [],
    );
  }

  /// `Este día se realizaron`
  String get this_day_they_were_made {
    return Intl.message(
      'Este día se realizaron',
      name: 'this_day_they_were_made',
      desc: '',
      args: [],
    );
  }

  /// `Este día se realizó`
  String get this_day_was_made {
    return Intl.message(
      'Este día se realizó',
      name: 'this_day_was_made',
      desc: '',
      args: [],
    );
  }

  /// `A esta empresa se le realizó`
  String get this_company_was_made {
    return Intl.message(
      'A esta empresa se le realizó',
      name: 'this_company_was_made',
      desc: '',
      args: [],
    );
  }

  /// `A esta empresa se le realizaron`
  String get these_companies_were_made {
    return Intl.message(
      'A esta empresa se le realizaron',
      name: 'these_companies_were_made',
      desc: '',
      args: [],
    );
  }

  /// `Seleccionar todos`
  String get select_all {
    return Intl.message(
      'Seleccionar todos',
      name: 'select_all',
      desc: '',
      args: [],
    );
  }

  /// `El envío contiene`
  String get the_shipment_contains {
    return Intl.message(
      'El envío contiene',
      name: 'the_shipment_contains',
      desc: '',
      args: [],
    );
  }

  /// `No tienes ninguna línea para modificar`
  String get has_no_line_to_modify {
    return Intl.message(
      'No tienes ninguna línea para modificar',
      name: 'has_no_line_to_modify',
      desc: '',
      args: [],
    );
  }

  /// `No tenemos ningún envío en esa fecha`
  String get we_do_not_have_any_shipping_on_that_date {
    return Intl.message(
      'No tenemos ningún envío en esa fecha',
      name: 'we_do_not_have_any_shipping_on_that_date',
      desc: '',
      args: [],
    );
  }

  /// `Fue modificado`
  String get was_modified {
    return Intl.message(
      'Fue modificado',
      name: 'was_modified',
      desc: '',
      args: [],
    );
  }

  /// `Fueron modificados`
  String get were_modified {
    return Intl.message(
      'Fueron modificados',
      name: 'were_modified',
      desc: '',
      args: [],
    );
  }

  /// `Modificada`
  String get modifiedFemale {
    return Intl.message(
      'Modificada',
      name: 'modifiedFemale',
      desc: '',
      args: [],
    );
  }

  /// `Importar datos`
  String get import_data {
    return Intl.message(
      'Importar datos',
      name: 'import_data',
      desc: '',
      args: [],
    );
  }

  /// `Importar datos en formato CSV`
  String get Import_data_in_CSV_format {
    return Intl.message(
      'Importar datos en formato CSV',
      name: 'Import_data_in_CSV_format',
      desc: '',
      args: [],
    );
  }

  /// `El sector no existe`
  String get The_sector_does_not_exist {
    return Intl.message(
      'El sector no existe',
      name: 'The_sector_does_not_exist',
      desc: '',
      args: [],
    );
  }

  /// `No existe el archivo de`
  String get no_file_exists {
    return Intl.message(
      'No existe el archivo de',
      name: 'no_file_exists',
      desc: '',
      args: [],
    );
  }

  /// `El archivo ya existe`
  String get file_already_exists {
    return Intl.message(
      'El archivo ya existe',
      name: 'file_already_exists',
      desc: '',
      args: [],
    );
  }

  /// `Se guardarán en un archivo temporal`
  String get They_will_be_saved_in_a_temporary_file {
    return Intl.message(
      'Se guardarán en un archivo temporal',
      name: 'They_will_be_saved_in_a_temporary_file',
      desc: '',
      args: [],
    );
  }

  /// `No pertenece a la empresa`
  String get does_not_belong_to_the_company {
    return Intl.message(
      'No pertenece a la empresa',
      name: 'does_not_belong_to_the_company',
      desc: '',
      args: [],
    );
  }

  /// `No pertenece al sector`
  String get does_not_belong_to_the_sector {
    return Intl.message(
      'No pertenece al sector',
      name: 'does_not_belong_to_the_sector',
      desc: '',
      args: [],
    );
  }

  /// `No hay empresas para importar`
  String get there_is_no_companies_to_import {
    return Intl.message(
      'No hay empresas para importar',
      name: 'there_is_no_companies_to_import',
      desc: '',
      args: [],
    );
  }

  /// `No se pueden cargar las empresas porque no hay sectores`
  String get Cannot_Load_Companies_because_it_does_not_have_sectors {
    return Intl.message(
      'No se pueden cargar las empresas porque no hay sectores',
      name: 'Cannot_Load_Companies_because_it_does_not_have_sectors',
      desc: '',
      args: [],
    );
  }

  /// `Archivo no válido`
  String get invalid_file {
    return Intl.message(
      'Archivo no válido',
      name: 'invalid_file',
      desc: '',
      args: [],
    );
  }

  /// `Esa empresa no pertenece a nuestra base de datos`
  String get that_company_does_not_belong_to_our_database {
    return Intl.message(
      'Esa empresa no pertenece a nuestra base de datos',
      name: 'that_company_does_not_belong_to_our_database',
      desc: '',
      args: [],
    );
  }

  /// `No pertenece a nuestra base de datos`
  String get does_not_belong_to_our_database {
    return Intl.message(
      'No pertenece a nuestra base de datos',
      name: 'does_not_belong_to_our_database',
      desc: '',
      args: [],
    );
  }

  /// `Solo puedes eliminar las líneas que fueron devueltas. ¿Desea eliminar?`
  String
  get You_can_only_delete_the_lines_that_were_returned_Do_you_want_to_delete {
    return Intl.message(
      'Solo puedes eliminar las líneas que fueron devueltas. ¿Desea eliminar?',
      name:
          'You_can_only_delete_the_lines_that_were_returned_Do_you_want_to_delete',
      desc: '',
      args: [],
    );
  }

  /// `¿Qué tipo de base de datos desea utilizar?`
  String get what_type_of_database_do_you_want_to_use {
    return Intl.message(
      '¿Qué tipo de base de datos desea utilizar?',
      name: 'what_type_of_database_do_you_want_to_use',
      desc: '',
      args: [],
    );
  }

  /// `Salida de la aplicación`
  String get Application_exit {
    return Intl.message(
      'Salida de la aplicación',
      name: 'Application_exit',
      desc: '',
      args: [],
    );
  }

  /// `¿Desea salir de la aplicación?`
  String get desea_go_out {
    return Intl.message(
      '¿Desea salir de la aplicación?',
      name: 'desea_go_out',
      desc: '',
      args: [],
    );
  }

  /// `Modificación del sector`
  String get modification_of_the_sector {
    return Intl.message(
      'Modificación del sector',
      name: 'modification_of_the_sector',
      desc: '',
      args: [],
    );
  }

  /// `Creación del sector`
  String get creation_of_the_sector {
    return Intl.message(
      'Creación del sector',
      name: 'creation_of_the_sector',
      desc: '',
      args: [],
    );
  }

  /// `Nombre del sector`
  String get name_sector {
    return Intl.message(
      'Nombre del sector',
      name: 'name_sector',
      desc: '',
      args: [],
    );
  }

  /// `Ese sector ya existe`
  String get that_sector_already_exists {
    return Intl.message(
      'Ese sector ya existe',
      name: 'that_sector_already_exists',
      desc: '',
      args: [],
    );
  }

  /// `El campo no puede estar en blanco`
  String get the_field_cannot_be_blank {
    return Intl.message(
      'El campo no puede estar en blanco',
      name: 'the_field_cannot_be_blank',
      desc: '',
      args: [],
    );
  }

  /// `No puede cargar`
  String get cant_not_load {
    return Intl.message(
      'No puede cargar',
      name: 'cant_not_load',
      desc: '',
      args: [],
    );
  }

  /// `Porque no tiene`
  String get because_it_does_not_have {
    return Intl.message(
      'Porque no tiene',
      name: 'because_it_does_not_have',
      desc: '',
      args: [],
    );
  }

  /// `en  el departamento`
  String get in_the_department {
    return Intl.message(
      'en  el departamento',
      name: 'in_the_department',
      desc: '',
      args: [],
    );
  }

  /// `La linea`
  String get the_line {
    return Intl.message('La linea', name: 'the_line', desc: '', args: []);
  }

  /// `no puede quedar vacío`
  String get cannot_go_empty {
    return Intl.message(
      'no puede quedar vacío',
      name: 'cannot_go_empty',
      desc: '',
      args: [],
    );
  }

  /// `No puede dejar el campo vacío. ¿Desea continuar?`
  String get You_cannot_leave_the_field_empty_you_want_to_continue {
    return Intl.message(
      'No puede dejar el campo vacío. ¿Desea continuar?',
      name: 'You_cannot_leave_the_field_empty_you_want_to_continue',
      desc: '',
      args: [],
    );
  }

  /// `El campo`
  String get the_field {
    return Intl.message('El campo', name: 'the_field', desc: '', args: []);
  }

  /// `No se encontró el archivo`
  String get file_not_found {
    return Intl.message(
      'No se encontró el archivo',
      name: 'file_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Error al crear el archivo`
  String get error_creating_file {
    return Intl.message(
      'Error al crear el archivo',
      name: 'error_creating_file',
      desc: '',
      args: [],
    );
  }

  /// `Error en el formato del archivo`
  String get file_format_error {
    return Intl.message(
      'Error en el formato del archivo',
      name: 'file_format_error',
      desc: '',
      args: [],
    );
  }

  /// `Error al importar`
  String get error_importing {
    return Intl.message(
      'Error al importar',
      name: 'error_importing',
      desc: '',
      args: [],
    );
  }

  /// `Ha sido`
  String get it_has_been {
    return Intl.message('Ha sido', name: 'it_has_been', desc: '', args: []);
  }

  /// `Se ha eliminado`
  String get has_been_removed {
    return Intl.message(
      'Se ha eliminado',
      name: 'has_been_removed',
      desc: '',
      args: [],
    );
  }

  /// `Se han eliminado`
  String get have_been_removed {
    return Intl.message(
      'Se han eliminado',
      name: 'have_been_removed',
      desc: '',
      args: [],
    );
  }

  /// `Líneas correctamente`
  String get lines_correctly {
    return Intl.message(
      'Líneas correctamente',
      name: 'lines_correctly',
      desc: '',
      args: [],
    );
  }

  /// `Línea correctamente`
  String get line_correctly {
    return Intl.message(
      'Línea correctamente',
      name: 'line_correctly',
      desc: '',
      args: [],
    );
  }

  /// `No se puede cargar`
  String get can_not_load {
    return Intl.message(
      'No se puede cargar',
      name: 'can_not_load',
      desc: '',
      args: [],
    );
  }

  /// `Sin empresa`
  String get Without_company {
    return Intl.message(
      'Sin empresa',
      name: 'Without_company',
      desc: '',
      args: [],
    );
  }

  /// `El formato de`
  String get the_format_of_the {
    return Intl.message(
      'El formato de',
      name: 'the_format_of_the',
      desc: '',
      args: [],
    );
  }

  /// `Debe ser`
  String get must_be {
    return Intl.message('Debe ser', name: 'must_be', desc: '', args: []);
  }

  /// `No tiene`
  String get no_has {
    return Intl.message('No tiene', name: 'no_has', desc: '', args: []);
  }

  /// `en ese departamento`
  String get in_that_department {
    return Intl.message(
      'en ese departamento',
      name: 'in_that_department',
      desc: '',
      args: [],
    );
  }

  /// `Este campo no puede ser repetido`
  String get this_field_cannot_be_repeated {
    return Intl.message(
      'Este campo no puede ser repetido',
      name: 'this_field_cannot_be_repeated',
      desc: '',
      args: [],
    );
  }

  /// `¿Realmente desea eliminar`
  String get do_you_really_want_to_delete {
    return Intl.message(
      '¿Realmente desea eliminar',
      name: 'do_you_really_want_to_delete',
      desc: '',
      args: [],
    );
  }

  /// `En la base de datos. ¿Qué desea hacer?`
  String get in_the_database_what_do_you_want_to_do {
    return Intl.message(
      'En la base de datos. ¿Qué desea hacer?',
      name: 'in_the_database_what_do_you_want_to_do',
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
