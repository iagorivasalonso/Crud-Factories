
import 'package:crud_factories/Objects/BaseEntity.dart';


class Factory extends BaseEntity {

  final String id;
  final String name;
  final String highDate;
  final String sector;
  final List<String> thelephones;
  final String mail;
  final String web;
  final Address address;


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

}

class Address {
  final String street;
  final String number;
  final String? apartment;
  final String city;
  final String province;
  final String postcode;

  Address({
    required this.street,
    required this.number,
    this.apartment,
    required this.city,
    required this.province,
    required this.postcode,
  });

  String get fullAddress {
    if (apartment == null || apartment!.isEmpty) {
      return '$street, $number';
    }
    return '$street, $number - $apartment';
  }
}


