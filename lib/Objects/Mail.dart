
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
/*
   Future<lineSend> sendLine() async {

     late File file;
     List<String> fileContent =[];
     List<lineSend> line = [];

     try {
       file = new File('D:/lineSends.csv');

       fileContent = await file.readAsLines();

       List<String> select;

       for (int i = 0; i < fileContent.length; i++) {

         select = fileContent[i].split(",");

         line.add(lineSend(
             date: select[0],
             factory: select[1],
             observations: select[2],
             state: select[3]));
       }
     } catch (Exeption) {

     }

     return lineSend(date: "date", factory: "factory", observations: "observations", state: "state");
   }*/
}