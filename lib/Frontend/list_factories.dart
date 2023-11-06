import 'package:flutter/material.dart';

import '../Widgets/factoryCard.dart';

class listFactories extends StatefulWidget {

  double mHeight;
  double mWidth;

  listFactories(this.mHeight, this.mWidth);

  State<listFactories> createState() => _listFactoriesState();
}

class _listFactoriesState extends State<listFactories> {

  List<String> opSearch = ['Todos','Filtrar'];
  List<String> filterList = ['uno', 'dos'];

  int opSelected = 0;

  @override
  Widget build(BuildContext context) {

    double mHeight = widget.mHeight;
    double mHeightfilter = 0;
    double mHeightList = 0;


    double mHeightbutton;


    if(mHeight>190)
    {
      mHeightbutton = 40;
      mHeightList = mHeight-mHeightbutton;
    }
    else
    {
      mHeightbutton =0;
      mHeightList = mHeight;
    }

    if(mHeight>190 && opSelected==1)
    {
      mHeightfilter = 150;
      mHeightList=mHeightList-mHeightfilter;
    }


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
                      height:mHeightbutton,
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
            height: mHeightfilter,
            color: Colors.greenAccent,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0,top: 10.0),
                  child: Row(
                    children: [
                     const Padding(
                       padding: EdgeInsets.only(left: 20.0,right: 20.0),
                       child: Text("Filtrar por:",
                         maxLines: 1,
                         overflow: TextOverflow.ellipsis,),
                     ),
                      Expanded(
                        child: DropdownButton<String>(
                          isExpanded: true,
                            items: filterList.map<DropdownMenuItem<String>>((String value){
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue){
                              setState(() {

                              });
                            }
                        ),
                      )
                    ],
                  ),
                ),
                const Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 15.0,left: 40.0,right: 40.0),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Buscar...'
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Container(
            color: Colors.cyan,
            height: mHeightList,
            child: Row (
              children: [
                Expanded(
                  child: ListView.builder(
                     itemCount: 50,
                     itemBuilder: (context,index){
                        return Padding(
                          padding: const EdgeInsets.only(left: 3.0,right: 9.0, top: 3.0),
                          child: factoryCard(
                              name: 'nombre',
                              address: 'dirreccion',
                              telephone: 'telefono',
                              city: 'ciudad'
                          ),
                        );
                      },
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