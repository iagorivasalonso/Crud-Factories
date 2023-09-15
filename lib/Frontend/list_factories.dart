import 'package:flutter/material.dart';

import '../Widgets/factoryCard.dart';

class listFactories extends StatefulWidget {
  const listFactories({super.key});

  @override
  State<listFactories> createState() => _listFactoriesState();
}

class _listFactoriesState extends State<listFactories> {

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: const BoxDecoration(
          border: Border(
              right: BorderSide(width: 5, color: Colors.grey)
          )
      ),
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context,index){
          return factoryCard(
              name: 'nombre',
              address: 'dirreccion',
              telephone: 'telefono',
              city: 'ciudad'
          );
        },

      ),
    );

  }

}