
class LineSend {

  String id;
  String date;
  String factory;
  String observations;
  String state;

  LineSend({
    required this.id,
    required this.date,
    required this.factory,
    required this.observations,
    required this.state
  });

  String showFormatDate(String date) {
    List <String> listMmonth = [
      ' ',
      'Enero',
      'Febrero',
      'Marzo',
      'Abril',
      'Mayo',
      'Junio',
      'Julio',
      'Agosto',
      'Septiembre',
      'Octubre',
      'Noviembre',
      'Diciembre'
    ];

    List <String> partDate = date.split("-");
    String dateFormat = " ";

    int nMonth = int.parse(partDate[1]);


    String day = partDate[0];
    String month = listMmonth[nMonth];
    String year = partDate[2];

    dateFormat = "$day de $month del $year";

    return dateFormat;
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