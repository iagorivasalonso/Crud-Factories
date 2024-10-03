class Empleoye {

  String id;
  String name;
  String idFActory;

  Empleoye ({
    required this.id,
    required this.name,
    required this.idFActory
  });

  @override
  String toString() {
    return 'Empleoye{id: $id, name: $name, idFActory: $idFActory}';
  }
}