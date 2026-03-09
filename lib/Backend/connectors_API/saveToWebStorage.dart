import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart' as html;
import 'connectApi.dart';

Future<void> saveToWebStorage(String prefix, String id, Map<String, dynamic> data) async {

  final key = '${prefix}_$id';

  final String nameTable = prefix;
  final uri = await connectApi(nameTable);

  await http.post(
         uri,
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(data),
  );

  if (kIsWeb) {
    html.window.localStorage[key] = jsonEncode(data);
  }
}