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
  List<String> itens = ['Archivo', 'Edicion', 'Ver', 'Conectar'];
  List<String> Sitens1 = ['Nueva Empresa','Nuevo Envio','Importar datos','Salir' ];
  List<String> Sitens2 = ['Copiar', 'Cortar', 'Pegar'];
  List<String> Sitens3 = ['Lista Empresas', 'Cuentas de email'];

  List<String> Sitens = [];
  int itenSelection = -1;
  int subItenSelection = -1;
  int itenSelect = -1;
  int subItenSelect = -1;


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
                  width: itenSelection == 0
                         ? 140
                         : itenSelection == 1
                         ? 180
                         : 300,
                  child: Padding(
                    padding: itenSelection == 0
                             ?  psmenu = const EdgeInsets.only(left: 0)
                             :  itenSelection == 1
                             ?  psmenu = const EdgeInsets.only(left: 75)
                             :  psmenu = const EdgeInsets.only(left: 150),
                    child: SizedBox(
                      child: SafeArea(
                       child: Column(
                        children: [
                          for (int index1 = 0; index1 < Sitens.length; index1++)
                            Align(
                              alignment: Alignment.topLeft,
                              child: MouseRegion(
                                onHover: (s) {
                                  setState(() {
                                   subItenSelection = index1;
                                  });
                                },
                                child: GestureDetector(
                                    child: Container(
                                        width: 200,
                                        height: 40,
                                        color: subItenSelection == index1
                                            ? cSelect
                                            : cBackground,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(Sitens[index1]),
                                        )
                                    ),
                                    onTap: (){
                                        setState(() {
                                              if(itenSelection == 0 && subItenSelection ==3)
                                                    closeAlert(context);
                                              itenSelect = itenSelection;
                                              subItenSelect = subItenSelection;
                                              itenSelection = -1;
                                              subItenSelection = -1;
                                        });
                                    },

                                ),

                              ),
                            ),
                        ],
                      )),
                    ),
                  ),
                ),
                onExit: (s) {
                  setState(() {
                    itenSelection = -1;
                    subItenSelection = -1;

                  });
                },
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
                            ?  Sitens = Sitens1
                            :  index == 1
                            ?  Sitens = Sitens2
                            :  Sitens = Sitens3;
                      });
                    },
                    child: Container(
                        width: 75,
                        color: itenSelection == index ? cSelect : cBackground,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Center(child: Text(itens[index])),
                        )
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
                child: FuntionSeleted(itenSelect, subItenSelect),
              );
            }),
      ],
    );
  }

}

