
class lineSend {

  String id;
  String date;
  String factory;
  String observations;
  String state;

  lineSend({
    required this.id,
    required this.date,
    required this.factory,
    required this.observations,
    required this.state
});

  @override
  String toString() {
    return 'lineSend{id: $id date: $date, factory: $factory, observations: $observations, state: $state}';
  }


  String showFormatDate (String date) {

    List <String> listMmonth =[' ','Enero','Febrero','Marzo','Abril','Mayo','Junio', 'Julio', 'Agosto','Septiembre','Octubre','Noviembre','Diciembre'];
    String dateFormat= " ";
    List <String> partDate= date.split("-");


    String cifra = "";

    int nMonth= int.parse(partDate[1]);


     String day = partDate[0];
     String month = listMmonth[nMonth];
     String year = partDate[2];

      dateFormat = "$day de $month del $year";
    return dateFormat;
  }


}
