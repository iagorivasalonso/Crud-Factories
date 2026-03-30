import 'package:crud_factories/Objects/LineSend.dart' show LineSendState;
import 'package:fluent_ui/fluent_ui.dart';


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