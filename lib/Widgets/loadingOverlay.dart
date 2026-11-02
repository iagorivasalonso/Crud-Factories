import 'package:flutter/material.dart';

Positioned LoadingOverlay() {

  return Positioned.fill(
    child: Container(
      color: Colors.white,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    ),
  );
}