import 'package:crud_factories/Objects/BaseEntity.dart';

class User extends BaseEntity {

  final String username;
  final String role;
  final bool active;

   User({
      required super.id,
      required this.username,
      required this.role,
      required this.active
   });

   factory User.fromMap (Map<String, dynamic> map) {

       return User(
           id: map['id'].toString(),
           username: map['username'].toString(),
           role: map['role'].toString(),
           active: map['active'] == true || map['active'] == 1,
       );
   }
}