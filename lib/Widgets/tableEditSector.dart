import 'package:flutter/material.dart';
import '../Objects/Sector.dart';


class tableEditSector extends StatelessWidget {

  final List<Sector> sectors;
  final Function(int) onEdit;
  final Function(int) onDelete;

  const tableEditSector({
    required this.sectors,
    required this.onEdit,
    required this.onDelete,
    super.key});

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
        itemCount: sectors.length,
        itemBuilder: (context, index){

          final screenWith = MediaQuery.of(context).size.width;

            return ListTile(
                title: Text(sectors[index].name),
                trailing: screenWith > 330.0
                 ? Wrap(
                    spacing: 4,
                    children: [
                       IconButton(
                           icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => onEdit(index),
                           ),
                       IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => onDelete(index),
                       )
                    ],
                )
                : null,
            );
        });
  }
}
