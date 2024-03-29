class Factory {
  String id;
  String name;
  String highDate;
  List<String> thelephones;
  String mail;
  String web;
  Map<String, String> address;
  List<String> contacts;

  Factory ({
    required this.id,
    required this.name,
    required this.highDate,
    required this.thelephones,
    required this.mail,
    required this.web,
    required this.address,
    required this.contacts,

  });

  @override
  String toString() {
    return '\n Factory{\n id: $id,\n name: $name,\n highDate: $highDate,\n thelephones: $thelephones,\n mail: $mail,\n web: $web,\n address: $address,\n employees: $contacts}';
  }

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