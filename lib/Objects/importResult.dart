
class ImportResult {

  final String entity;
  int inserted;
  List<String> errors;

  ImportResult({
    required this.entity,
    this.inserted = 0,
    List<String>? errors,
  }) : errors = errors ?? [];


  @override
  String toString() {
    return 'ImportResult(entity: $entity, inserted: $inserted, errors: $errors)';
  }
}