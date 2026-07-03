import 'package:crud_factories/Backend/Global/controllers/LineSend.dart' show LineSendController;
import 'package:crud_factories/Objects/BaseEntity.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/src/widgets/framework.dart';



enum LineSendState {prepared, pending, sent, in_progress, returned,has_responded}

class LineSend extends BaseEntity {

  String id;
  String date;
  String factory;
  String? sector; //  Atributo opcional
  String observations;
  String state;


  LineSend({
    required this.id,
    required this.date,
    required this.factory,
    this.sector,
    required this.observations,
    required this.state
  });

  static String showFormatDate(String date, BuildContext context) {
    try {
      if (date.isEmpty) return "";

      final parts = date.split("-");

      if (parts.length < 3) return date;

      final day = parts[0];
      final monthIndex = int.tryParse(parts[1]) ?? 0;
      final year = parts[2];

      final listMmonth = [
        ' ',
        S.of(context).january,
        S.of(context).february,
        S.of(context).march,
        S.of(context).april,
        S.of(context).may,
        S.of(context).june,
        S.of(context).july,
        S.of(context).august,
        S.of(context).september,
        S.of(context).october,
        S.of(context).november,
        S.of(context).december,
      ];

      final safeMonth =
      (monthIndex >= 1 && monthIndex < listMmonth.length)
          ? listMmonth[monthIndex]
          : "";

      return "$day ${S.of(context).de.toLowerCase()} $safeMonth ${S.of(context).ofThe.toLowerCase()} $year";
    } catch (e) {
      return date;
    }
  }


  LineSend copyWith({
    String? id,
    String? date,
    String? factory,
    String? observations,
    String? state,
    String? sector,
  }) {
    return LineSend(
      id: id ?? this.id,
      date: date ?? this.date,
      factory: factory ?? this.factory,
      observations: observations ?? this.observations,
      state: state ?? this.state,
      sector: sector ?? this.sector,
    );
  }


  @override
  String toString() {
    return 'LineSend{id: $id, date: $date, factory: $factory, sector: $sector, observations: $observations, state: $state}';
  }
}

class cardSend {

  String title;
  String description;

  cardSend({
    required this.title,
    required this.description
});

}

class SendRow {
  final LineSendController controller;
  bool selected;

  SendRow({
    required this.controller,
    this.selected = false,
  });
}