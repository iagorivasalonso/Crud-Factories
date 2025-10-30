
import '../Frontend/importData.dart';

class Mail extends BaseEntity {

   String id;
   String addrres;
   String company;
   String password;

   Mail({
    required this.id,
    required this.addrres,
    required this.company,
    required this.password
});
}