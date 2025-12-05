import '../Frontend/importData.dart';

class Factory extends BaseEntity {

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
       addressComplete=  '$address1, $number';
     }
     else
     {
       addressComplete='$address1, $number - $apartament';
     }

    return addressComplete;

  }
  Factory copyWith({
    String? id,
    String? name,
    String? highDate,
    String? sector,
    List<String>? thelephones,
    String? mail,
    String? web,
    Map<String, String>? address,
  }) {
    return Factory(
      id: id ?? this.id,
      name: name ?? this.name,
      highDate: highDate ?? this.highDate,
      sector: sector ?? this.sector,
      thelephones: thelephones != null ? List.from(thelephones) : List.from(this.thelephones),
      mail: mail ?? this.mail,
      web: web ?? this.web,
      address: address != null ? Map.from(address) : Map.from(this.address),
    );
  }

  factory Factory.empty() {
    return Factory(
      name: '',
      sector: '',
      address: {},
      thelephones: [], id: '', highDate: '', mail: '', web: '',
    );
  }
}



