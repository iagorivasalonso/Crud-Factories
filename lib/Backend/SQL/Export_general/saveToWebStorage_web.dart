import 'dart:convert';
import 'package:crud_factories/Backend/Feature/Sector/apiSectorDataSource%20.dart' show ApiConfig;
import 'package:crud_factories/Backend/connectors_API/connectApi.dart' show connectApi;
import 'package:crud_factories/Objects/ApiConfig.dart';
import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart' as html;

Future<void> saveToWebStorage(
    String prefix,
    String id,
    Map<String, dynamic> data,
    ApiConfig config, {
      bool isUpdate = false,
    }) async {

  final uri = await connectApi(prefix, config);

  final response = isUpdate
      ? await http.put(
    uri.replace(path: '${uri.path}/$id'), // ✅ SAFE (sin Uri.parse)
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(data),
  )
      : await http.post(
    uri,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(data),
  );

  if (response.statusCode != 200 && response.statusCode != 201) {
    throw Exception('HTTP ${response.statusCode}: ${response.body}');
  }

  final key = '${prefix}_$id';
  html.window.localStorage[key] = jsonEncode(data);
}