
import 'package:crud_factories/Objects/BaseEntity.dart';

class AppSession extends BaseEntity {

     final String userId;
     final DateTime createdAt;
     final DateTime expiresAt;

     AppSession({
       required super.id,
       required this.userId,
       required this.createdAt,
       required this.expiresAt,
     });

     bool get isExpired => DateTime.now().isAfter(expiresAt);

     factory AppSession.fromMap(Map<String,dynamic>map) {
        return AppSession(
             id: map['id'].toString(),
             userId: map['user_id'].toString(),
             createdAt: DateTime.parse(map['created_at'].toString()),
             expiresAt: DateTime.parse(map['expires_at'].toString()),
        );
     }
}