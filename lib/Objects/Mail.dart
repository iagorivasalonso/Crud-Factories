
class Mail {

   String company;
   String addrres;
   String password;

   Mail({
    required this.company,
    required this.addrres,
    required this.password
});

   @override
  String toString() {
    return 'Mail{company: $company, addrres: $addrres, password: $password}';
  }
}