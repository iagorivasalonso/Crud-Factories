
import 'package:fluent_ui/fluent_ui.dart';

import '../../../Objects/LineSend.dart';

class LineSendController {

  final TextEditingController date;
  final TextEditingController factory;
  final TextEditingController sector;
  final TextEditingController observations;
  LineSendState state; // ✅ ahora es enum


  LineSendController({
    required this.date,
    required this.factory,
    required this.sector,
    required this.observations,
    required this.state
});

  void dispose() {
    factory.dispose();
    sector.dispose();
    observations.dispose();
  }
}