import 'package:desktop_app/Widgets/defaultCard.dart';
import 'package:flutter/material.dart';

class listEmails extends StatefulWidget {

  double mHeight;

  listEmails(this.mHeight);

  State<listEmails> createState() => _listEmailsState();
}

class _listEmailsState extends State<listEmails> {

  List<String> opSearch = ['Todos','Filtrar'];
  List<String> filterList = ['uno', 'dos'];

  int opSelected = 0;
  int cardSeleted = 0;

  @override
  Widget build(BuildContext context) {

    double mHeight = widget.mHeight;

    return Column(
      children: [
        Expanded(
          child: SizedBox(
              height:mHeight,
              child: ListView.builder(
                 itemCount: 4,
                 itemBuilder: (context,index){
                    return GestureDetector(
                      child: defaultCard(
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
    );
  }
  }