
import '../Frontend/importData.dart';

class Mail extends BaseEntity {

   String id;
   String address;
   String company;
   String password;

   Mail({
    required this.id,
    required this.address,
    required this.company,
    required this.password
});
}