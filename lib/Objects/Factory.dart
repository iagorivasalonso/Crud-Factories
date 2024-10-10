class Factory {

  String id;
  String name;
  String highDate;
  String sector;
  List<String> thelephones;
  String mail;
  String web;

  Map<String, String> address;


  Factory ({
    required this.id,
    required this.name,
    required this.highDate,
    required this.sector,
    required this.thelephones,
    required this.mail,
    required this.web,
    required this.address,
  });

  String allAdress() {

    String address1= address['street'].toString();
    String number= address['number'].toString();
    String apartament = address['apartament']!;

    String addressComplete='';

     if(apartament=="")
     {
       addressComplete=  '$address1,$number';
     }
     else
     {
       addressComplete='$address1,$number-$apartament';
     }

    return addressComplete;

  }

}

