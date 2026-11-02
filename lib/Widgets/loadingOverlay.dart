import 'package:flutter/material.dart';

Positioned LoadingOverlay() {
  return Positioned.fill(
    child: IgnorePointer(
      child: Container(
        color: Colors.white.withOpacity(0.7),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    ),
  );
}