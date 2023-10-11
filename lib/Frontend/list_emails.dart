import 'package:desktop_app/Widgets/cardDefault.dart';
import 'package:flutter/material.dart';

import '../Widgets/factoryCard.dart';

class listEmails extends StatefulWidget {



  State<listEmails> createState() => _listEmailsState();
}

class _listEmailsState extends State<listEmails> {

  List<String> opSearch = ['Todos','Filtrar'];
  List<String> filterList = ['uno', 'dos'];

  int opSelected = 0;
  int cardSeleted = 0;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Row(
          children: [
            for(int index = 0; index < 2; index++)
              Expanded(
                child: GestureDetector(
                  child: Container(
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
                ),
              ),
          ],
        ),
        if(opSelected==1)
        Container(
          color: Colors.greenAccent,
          child: Row(
            children: [
            SizedBox(
                height: 170,
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
                      padding: EdgeInsets.only(top: 40.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 40.00),
                            child: SizedBox(
                              height: 40,
                              width: 150,
                              child: TextField(
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
            )
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                  height:600,
                  child: ListView.builder(
                     itemCount: 4,
                     itemBuilder: (context,index){
                        return GestureDetector(
                          child: cardDefault(
                              title: 'Gmail',
                              description: 'Prueba@gmail.com',
                              color: index == cardSeleted
                                     ? Colors.white
                                     : Colors.grey
                          ),
                          onTap: (){
                            setState(() {
                              cardSeleted = index;
                            });
                          },
                        );
                      },
                 ),
              ),
            ),
          ],
        ),
      ],
    );
  }
  }