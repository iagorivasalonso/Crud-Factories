import 'dart:convert';
import 'dart:ui' as html;

import 'package:flutter/foundation.dart' as foundation;

void saveToWebStorage(
    String prefix,
    String id,
    Map<String, dynamic> data,
    ) {
  if (!foundation.kIsWeb) return;

  try {
    final key = '$prefix-$id';
    final value = jsonEncode(data);
   // html.window.localStorage[key] = value;
  } catch (e) {
    // Por si localStorage falla (modo incógnito, límite de espacio, etc.)
    foundation.debugPrint('Error guardando en Web Storage: $e');
  }
}