import 'dart:io';
import 'package:flutter/foundation.dart';

bool isNotAndroid() {
  if (kIsWeb) {
    return true;
  }

  return !Platform.isAndroid;
}