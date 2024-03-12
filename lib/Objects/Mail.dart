
class Mail {

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

   @override
  String toString() {
    return 'Mail{company: $company, addrres: $addrres, password: $password}';
  }

}