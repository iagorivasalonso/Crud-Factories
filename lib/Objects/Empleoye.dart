class Empleoye {

  String id;
  String name;
  String idFactory;

  Empleoye ({
    required this.id,
    required this.name,
    required this.idFactory
  });

  @override
  String toString() {
    return 'Empleoye{id: $id, name: $name, idFActory: $idFactory}';
  }
}