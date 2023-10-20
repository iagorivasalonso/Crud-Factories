import 'package:flutter/material.dart';
import '../Backend/selection_view.dart';
import 'close_app.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {

  //List Menu Item
  List<String> itens = ['Archivo', 'Edicion', 'Listas','Enviar Emails', 'Conectar'];
  List<String> N1itens1 = ['Nuevo','Importar','Salir' ];
  List<String> N2itens1 = ['Empresa', 'Email', 'Envio'];
  List<String> N1itens2 = ['Copiar', 'Cortar', 'Pegar'];
  List<String> N1itens3 = ['Empresas', 'Emails', 'Envios'];

  List<String> N1itens = [];
  List<String> N2itens = [];
  int itenSelection = -1;
  int subIten1Selection = -1;
  int subIten2Selection = -1;
  int itenSelect = 0;
  int subIten1Select = -1;
  int subIten2Select = -1;
  int itenSelectable = -1;
  int subIten1Selectable = -1;


  var psmenu = const EdgeInsets.only(top: 0, left: 0, right: 0);
  Color cBackground = Colors.blue;
  Color cSelect = Colors.green;
  double posMenu = 0;

  @override
  Widget build(BuildContext context) {
    double mWidth = MediaQuery.of(context).size.width;
    double mHeight = MediaQuery.of(context).size.height - 40;
    /*
    print('ancho $mWidth');
    print('alto $mHeight');
     */

    return Scaffold(
      body: Column(
        children: [
          Container(
              child: itenSelection == -1
                  ? SizedBox(
                      width: mWidth,
                      child: buildMenu(mWidth, mHeight),
                    )
                  : SizedBox(
                      width: mWidth,
                      height: 40,
                      child: buildMenu(mWidth, mHeight),
                    )),
          if (itenSelection > -1 && itenSelection < 3)
            Align(
              alignment: Alignment.topLeft,
              child: MouseRegion(
                child: SizedBox(
                  child: Padding(
                    padding: itenSelection == 0
                             ?  psmenu = const EdgeInsets.only(left: 0)
                             :  itenSelection == 1
                             ?  psmenu = const EdgeInsets.only(left: 75)
                             :  psmenu = const EdgeInsets.only(left: 150),
                    child: SizedBox(
                      child: Row(
                        children: [
                          MouseRegion(
                            child: SafeArea(
                             child: Column(
                              children: [
                                for (int index1 = 0; index1 < N1itens.length; index1++)
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: MouseRegion(
                                      onHover: (s) {
                                        setState(() {
                                              subIten1Selection = index1;

                                              if(itenSelection == 0 && subIten1Selection ==0)
                                              {
                                                  N2itens=N2itens1;
                                                  itenSelectable = itenSelection;
                                                  subIten1Selectable = subIten1Selection;
                                              }

                                        });
                                      },
                                      child: GestureDetector(
                                          child: Container(
                                              width: 100,
                                              height: 40,
                                              color: subIten1Selection == index1
                                                  ? cSelect
                                                  : cBackground,
                                              child: Padding(
                                                padding: const EdgeInsets.all(12.0),
                                                child:Row(
                                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                       children: [
                                                        Text(N1itens[index1]),
                                                         index1==0 && itenSelection == 0
                                                         ? const Text(">")
                                                         : const Text(""),

                                                        ],
                                                    ),
                                              )
                                          ),
                                          onTap: (){
                                              setState(() {

                                                  if(itenSelection == 0 && subIten1Selection ==2)
                                                  {
                                                    closeAlert(context);

                                                  } else {
                                                    itenSelect = itenSelection;
                                                    subIten1Select = subIten1Selection;
                                                    itenSelection = -1;
                                                    subIten1Selection = -1;
                                                  }

                                              });
                                          },

                                      ),

                                    ),
                                  ),
                              ],
                            )),
                            onExit: (s){
                              setState(() {

                                if (itenSelectable == 0 && subIten1Selectable == 0)
                                {
                                  itenSelectable = itenSelection;
                                  subIten1Selectable = subIten1Selection;
                                }
                                else{
                                  itenSelection = -1;
                                  subIten1Selection = -1;
                                }

                              });
                            },
                          ),
                          if (itenSelection==itenSelectable && subIten1Selection==subIten1Selectable)
                            SafeArea(
                                child: Column(
                                  children: [
                                    for (int index2 = 0; index2 < N2itens.length; index2++)
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: MouseRegion(
                                          onHover: (s) {
                                            setState(() {
                                              subIten2Selection = index2;
                                              itenSelection = itenSelectable;
                                              subIten1Selection = subIten1Selectable;
                                            });
                                          },
                                          child: GestureDetector(
                                            child: Container(
                                                width: 100,
                                                height: 40,
                                                color: subIten2Selection == index2
                                                    ? cSelect
                                                    : cBackground,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(12.0),
                                                  child: Text(N2itens[index2]),
                                                )
                                            ),
                                            onTap: (){
                                              setState(() {
                                                if(itenSelection == 0 && subIten1Selection ==3)
                                                {
                                                  closeAlert(context);

                                                } else {
                                                  itenSelect = itenSelection;
                                                  subIten1Select = subIten1Selection;
                                                  subIten2Select = subIten2Selection;
                                                  itenSelection = -1;
                                                  subIten1Selection = -1;
                                                }
                                              });
                                            },

                                          ),
                                          onExit: (s){
                                            setState(() {
                                              itenSelection = -1;
                                              subIten1Selection = -1;
                                            });
                                          },
                                        ),
                                      ),
                                  ],
                                )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
  Column buildMenu(double mWidth, double mHeight) {

    return Column(
      children: [
        Container(
          color: cBackground,
          width: mWidth,
          height: 40,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: itens.length,
              itemBuilder: (BuildContext context, index) {
                return MouseRegion(
                    onHover: (s) {
                      setState(() {
                        itenSelection = index;
                               index == 0
                            ?  N1itens = N1itens1
                            :  index == 1
                            ?  N1itens = N1itens2
                            :  N1itens = N1itens3;
                      });
                    },
                    child: GestureDetector(
                        child: Container(
                            width: 75,
                            color: itenSelection == index ? cSelect : cBackground,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Center(child: Text(itens[index])),
                            )
                        ),
                      onTap: (){
                        setState(() {
                          if (itenSelection == 3)
                          itenSelect = itenSelection;
                        });
                      },

                    ),
                    onExit: (s) {
                        setState(() {
                          if (itenSelection == 3)
                                itenSelection = -1;
                        });
                },
                );
              }),
        ),
        StreamBuilder<Object>(
            stream: null,
            builder: (context, snapshot) {
              return Container(
                width: mWidth,
                height: mHeight,
                color: Colors.white,
                child: FuntionSeleted(itenSelect, subIten1Select, subIten2Select,mWidth, mHeight),
              );
            }),
      ],
    );
  }

}

