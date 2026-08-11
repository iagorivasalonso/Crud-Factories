import 'package:crud_factories/Objects/LineSend.dart' show LineSendState, LineSend;
import 'package:fluent_ui/fluent_ui.dart';


class LineSendController {

  final String id;
  final String date;
  final String factory;
  final String sector;

  final TextEditingController observations;
  LineSendState state; // ✅ ahora es enum


  LineSendController({

    required this.id,
    required this.date,
    required this.factory,
    required this.sector,
    required this.observations,
    required this.state,
});

  factory LineSendController.fromLine(
      LineSend line, {
        required String factoryName,
        required String sectorName,
      }) {
    return LineSendController(
      id: line.id,
      factory: factoryName,
      sector: sectorName,
      observations: TextEditingController(text: line.observations),
      state: LineSendState.prepared, date: '',
    );
  }

  void dispose() {

    observations.dispose();
  }
}