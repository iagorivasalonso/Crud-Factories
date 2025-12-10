import 'dart:io';
import 'package:flutter/foundation.dart';

bool isNotAndroid() {
  return !kIsWeb && Platform.isAndroid;
}