import 'dart:convert' show utf8, latin1, LineSplitter;
import 'dart:io' show File;
import 'package:crud_factories/Objects/Mail.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';

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
    // 🟢 3. DESKTOP → usar route como archivo real
    final file = File(assetPath!);

    if (await file.exists()) {
      csvContent = await file.readAsString(encoding: utf8);
    } else {
      throw Exception("route not found: $assetPath");
    }
  }
  return readMailsFromCsvContent(csvContent);
}


List<Mail> readMailsFromCsvContent(String content) {
  final lines = const LineSplitter()
      .convert(content)
      .where((line) => line.trim().isNotEmpty)
      .toList();

  final mail = <Mail>[];
  print(lines);
  for (final line in lines.skip(1)) {

    final parts = line.split(";");
    if (parts.length < 6) continue;

    mail.add(Mail(
      id: parts[0].trim(),
      mail: parts[1].trim(),
      host: parts[2].trim(),
      port: parts[3].trim(),
      secure: parts[4].trim().toLowerCase() == 'true',
      password: parts[5].trim(),
    ));
  }

  return mail;
}