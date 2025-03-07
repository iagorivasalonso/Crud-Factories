import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/src/widgets/framework.dart';

class LineSend {

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

  String showFormatDate(String date, BuildContext context) {

    List <String> listMmonth = [
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

    List <String> partDate = date.split("-");
    String dateFormat = " ";

    int nMonth = int.parse(partDate[1]);

    String day = partDate[0];
    String month = listMmonth[nMonth];
    String year = partDate[2];

    dateFormat = "$day ${S.of(context).de.toLowerCase()} $month ${S.of(context).ofThe.toLowerCase()} $year";

    return dateFormat;
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