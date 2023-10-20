import 'package:flutter/material.dart';

import '../Widgets/factoryCard.dart';

class listFactories extends StatefulWidget {

  double mHeight;

  listFactories(this.mHeight);

  State<listFactories> createState() => _listFactoriesState();
}

class _listFactoriesState extends State<listFactories> {

  List<String> opSearch = ['Todos','Filtrar'];
  List<String> filterList = ['uno', 'dos'];

  int opSelected = 0;

  @override
  Widget build(BuildContext context) {

    double mHeight = widget.mHeight;

    return Container(
      decoration: const BoxDecoration(
          border: Border(
              right: BorderSide(width: 5, color: Colors.grey)
          )
      ),
      child: Column(
        children: [
          Row(
            children: [
              for(int index = 0; index < 2; index++)
                Expanded(
                  child: GestureDetector(
                    child: Container(
                      height: 40,
                      color: index==opSelected
                            ? Colors.lightGreen
                            : Colors.white,
                    child: Center(
                       child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(opSearch[index],
                               style: TextStyle(fontWeight: FontWeight.bold,
                                       color: index==opSelected
                                              ? Colors.white
                                              : Colors.black,),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      ),
                    ),
                ),
                    onTap: (){
                      setState(() {
                        opSelected=index;
                      });
                    },
                  ),),
            ],
          ),
          if(opSelected==1)
          Container(
            color: Colors.black12,
            child: Row(
              children: [
              SizedBox(
                  height: mHeight * 0.30,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0,top:20.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Row(
                            children: [
                               const Text("Filtrar por:"),
                               Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: DropdownButton<String>(
                                    items: filterList.map<DropdownMenuItem<String>>((String value){
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: SizedBox(
                                            width: 80,
                                            height: 30,
                                            child: Text(value)
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue){
                                      setState(() {

                                      });
                                    }
                                ),
                              ),
                            ],
                          ),
                        ),

                       const Padding(
                          padding: EdgeInsets.only(top: 30.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 40.00),
                                child: SizedBox(
                                  height: 80,
                                  width: 150,
                                  child:  TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Buscar...'
                                    ),
                                  ),
                                ),
                              )

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:15.0),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                      height:mHeight-55.0,
                      child: ListView.builder(
                         itemCount: 50,
                         itemBuilder: (context,index){
                            return factoryCard(
                                name: 'nombre',
                                address: 'dirreccion',
                                telephone: 'telefono',
                                city: 'ciudad'
                            );
                          },
                     ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  }