import 'package:crud_factories/Objects/BaseEntity.dart' show BaseEntity;

Future<List<T>> processImport<T extends BaseEntity>({
  required List<T> newList,
  required List<T> existingList,
  required String Function(T) getKey,
  required void Function(T, String) setId,
}) async {

  final inserted = <T>[];

  int maxId = existingList.isNotEmpty
      ? existingList
      .map((e) => int.parse(e.id))
      .reduce((a, b) => a > b ? a : b)
      : 0;

  for(final item in newList) {

    final index =
            existingList.indexWhere((x) => getKey(x) == getKey(item));

    if (index == -1)
    {
      maxId++;
      setId(item, maxId.toString());

      existingList.add(item);
      inserted.add(item);
    }
    else
    {
      final existing = existingList[index];

      setId(item, existing.id);

      existingList[index] = item;
    }
  }

  return inserted;
}

