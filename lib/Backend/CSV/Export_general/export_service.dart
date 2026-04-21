import 'package:crud_factories/Backend/CSV/Export_general/csv_builder.dart' show buildCsv;
import 'package:crud_factories/Backend/CSV/Export_general/export_csv_web.dart' show downloadZip;
import 'package:crud_factories/Backend/CSV/Export_general/zip_builder.dart' show ZipBuilder;
import 'package:crud_factories/Objects/Conection.dart';
import 'package:crud_factories/Objects/Empleoye.dart';
import 'package:crud_factories/Objects/Factory.dart';
import 'package:crud_factories/Objects/LineSend.dart';
import 'package:crud_factories/Objects/Mail.dart';
import 'package:crud_factories/Objects/RouteCSV.dart';
import 'package:crud_factories/Objects/Sector.dart';



class ExportService {
  static Future<void> exportAllZip({
    required List<RouteCSV> routes,
    required List<Conection> connections,
    required List<Sector> sectors,
    required List<Factory> factories,
    required List<Empleoye> employees,
    required List<LineSend> lines,
    required List<Mail> mails,
  }) async {

    final files = {
      'routes.csv': buildCsv(
        headers: ['id', 'name', 'route'],
        rows: routes.map((r) => [
          r.id,
          r.name,
          r.route,
        ]).toList(),
      ),

      'connections.csv': buildCsv(
        headers: ['id', 'database', 'host', 'port', 'user', 'password'],
        rows: connections.map((c) => [
          c.id,
          c.database,
          c.host,
          c.port,
          c.user,
          c.password,
        ]).toList(),
      ),

      'sectors.csv': buildCsv(
        headers: ['id', 'name'],
        rows: sectors.map((s) => [
          s.id,
          s.name,
        ]).toList(),
      ),

      'factories.csv': buildCsv(
        headers: [
          'id',
          'name',
          'highDate',
          'sector',
          'telephone1',
          'telephone2',
          'mail',
          'web',
          'street',
          'number',
          'apartament',
          'city',
          'postalCode',
          'province',
        ],
        rows: factories.map((f) => [
          f.id,
          f.name,
          f.highDate,
          f.sector,
          f.thelephones.isNotEmpty ? f.thelephones[0] : '',
          f.thelephones.length > 1 ? f.thelephones[1] : '',
          f.mail,
          f.web,
          f.address['street'],
          f.address['number'],
          f.address['apartament'],
          f.address['city'],
          f.address['postalCode'],
          f.address['province'],
        ]).toList(),
      ),

      'employees.csv': buildCsv(
        headers: ['id', 'name', 'idFactory'],
        rows: employees.map((e) => [
          e.id,
          e.name,
          e.idFactory,
        ]).toList(),
      ),

      'lines.csv': buildCsv(
        headers: ['id', 'date', 'factory', 'observations', 'state'],
        rows: lines.map((l) => [
          l.id,
          l.date,
          l.factory,
          l.observations,
          l.state,
        ]).toList(),
      ),

      'mails.csv': buildCsv(
        headers: ['id', 'address', 'company', 'password'],
        rows: mails.map((m) => [
          m.id,
          m.address,
          m.company,
          m.password,
        ]).toList(),
      ),
    };

    final zipBytes = ZipBuilder.build(files);

    await downloadZip(zipBytes, 'backup.zip');
  }
}