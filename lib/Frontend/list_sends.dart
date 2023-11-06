import 'package:desktop_app/Widgets/defaultCard.dart';
import 'package:flutter/material.dart';



class listSends extends StatefulWidget {

  double mHeight;

  listSends(this.mHeight);

  State<listSends> createState() => _listSendsState();
}

class _listSendsState extends State<listSends> {

  List<String> opSearch = ['Todos','Filtrar'];
  List<String> filterList = ['uno', 'dos'];

  int opSelected = 0;
  int cardSeleted = 0;

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


    return Column(
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
                ),
              ),
          ],
        ),
        if(opSelected==1)
        Container(
          height: mHeightfilter,
          color: Colors.greenAccent,
          child: Row(
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
                            child: Text(value),
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
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Buscar...'
                      ),
                    ),
                  )

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
                  height:mHeightList,
                  child: ListView.builder(
                     itemCount: 4,
                     itemBuilder: (context,index){
                        return GestureDetector(
                          child: defaultCard(
                              title: 'Envio 1',
                              description: 'Envio octubre 2023',
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