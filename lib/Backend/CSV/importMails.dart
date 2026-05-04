import 'dart:convert';
import 'dart:typed_data';
import 'dart:io' show File;
import 'package:crud_factories/Objects/Mail.dart' show Mail;
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

Future<List<Mail>> csvImportMails({
  File? file,
  Uint8List? bytes,
  String? content,
  String? assetPath,
}) async {
  String csvContent;

  // 🟢 1. Bytes (file picker / web)
  if (bytes != null) {
    try {
      csvContent = utf8.decode(bytes);
    } catch (_) {
      csvContent = latin1.decode(bytes);
    }
  } else if (kIsWeb) {
    csvContent = await rootBundle.loadString(assetPath!);
  } else{
    // 🟢 3. DESKTOP → usar routeFirst como archivo real
    final file = File(assetPath!);

    if (await file.exists()) {
      csvContent = await file.readAsString(encoding: utf8);
    } else {
      throw Exception("route not found: $assetPath");
    }
  }

  return readMailsFromCsvContent(csvContent);
}

Future<List<Mail>> readMailsFromCsv(File file) async {
  final content = await file.readAsString(encoding: utf8);
  return readMailsFromCsvContent(content);
}

List<Mail> readMailsFromCsvContent(String content) {
  final lines = const LineSplitter()
      .convert(content)
      .where((line) => line.trim().isNotEmpty)
      .toList();

  final mails = <Mail>[];

  for (final line in lines.skip(1)) {
    final parts = line.split(";");

    if (parts.length < 4) continue;

    final id = parts[0].trim();
    final address = parts[1].trim();
    final company = parts[2].trim();
    final password = parts[3].trim();

    // Validación básica de email
    if (!address.contains("@")) continue;

    mails.add(Mail(
      id: id,
      address: address,
      company: company,
      password: password,
    ));
  }

  return mails;
}