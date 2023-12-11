
class Mail {

   String addrres;
   String company;
   String password;

   Mail({
    required this.addrres,
    required this.company,
    required this.password
});

   @override
  String toString() {
    return 'Mail{company: $company, addrres: $addrres, password: $password}';
  }


}