



import 'package:crud_factories/Backend/Global/variables.dart' show BaseDateSelected;
import 'package:crud_factories/Objects/BaseEntity.dart' show BaseEntity;

Future<int> processImport<T extends BaseEntity>({
  required List<T> newList,
  required List<T> existingList,
  required String Function(T) getKey,
  required void Function(T, String) setId,
  required Future<void> Function(List<T>) csvExport,
  Future<void> Function(List<T>)? sqlExport,
  dynamic conn,
}) async {

  int count = 0;
  int maxId = existingList.isNotEmpty
      ? existingList.map((e) => int.parse(e.id)).reduce((a, b) => a > b ? a : b)
      : 0;

  List<T> toInsert = [];
  List<T> toUpdate = [];


  for(final iten in newList) {
    final index = existingList.indexWhere((x) => getKey(x) == getKey(iten));

    if (index == -1)
    {
      maxId++;
      setId(iten, maxId.toString());

      existingList.add(iten);
      toInsert.add(iten);
      count++;
    }
    else
    {
      final existing = existingList[index];

      setId(iten, existing.id);

      existingList[index] = iten;
      toUpdate.add(iten);
      count++;
    }
  }

  if (count > 0) {

    if (BaseDateSelected.isNotEmpty && sqlExport != null) {
      await sqlExport([...toInsert, ...toUpdate]);
    } else {
      await csvExport(existingList);
    }
  }

  return count;
}
