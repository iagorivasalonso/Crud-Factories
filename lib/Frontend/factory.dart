import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:flutter/material.dart';

class newFactory extends StatefulWidget {
  double mHeight;
  double mWidth;

  newFactory(this.mHeight, this.mWidth);

  @override
  State<newFactory> createState() => _newFactoryState();
}

class _newFactoryState extends State<newFactory> {
  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();

  double widthBar = 15.0;
  @override
  Widget build(BuildContext context) {
    double mHeight = widget.mHeight;
    double mWidth = widget.mWidth;
    print(mWidth);
    print(mHeight);
    return AdaptiveScrollbar(
      controller: verticalScroll,
      width: widthBar,
      child: AdaptiveScrollbar(
        controller: horizontalScroll,
        width: widthBar,
        position: ScrollbarPosition.bottom,
        underSpacing: EdgeInsets.only(bottom: 8),
        child: SingleChildScrollView(
          controller: verticalScroll,
          scrollDirection: Axis.vertical,
          child: Container(
            width: 2000,
            child: SingleChildScrollView(
              controller: horizontalScroll,
              scrollDirection: Axis.horizontal,
              child: Container(
                height: 900,
                width: 888,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, top: 30.0),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Text(
                              'Empresa: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 20.0, bottom: 30.0),
                          child: Row(
                            children: [
                              Text('Nombre: '),
                              SizedBox(
                                width: 450,
                                height: 40,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 20.0, bottom: 30.0),
                          child: Row(
                            children: [
                              Text('Fecha de alta: '),
                              SizedBox(
                                width: 150,
                                height: 40,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Row(
                          children: [
                            Text(
                              'Contacto: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 20.0, bottom: 30.0, left: 20.0),
                          child: Row(
                            children: [
                              Text('Telefono 1: '),
                              SizedBox(
                                width: 200,
                                height: 40,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 85.0),
                                child: Text('Telefono 2: '),
                              ),
                              SizedBox(
                                width: 200,
                                height: 40,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.only(top: 20.0, bottom: 30.0, left: 20.0),
                          child: Row(
                            children: [
                              Text('Email: '),
                              SizedBox(
                                width: 300,
                                height: 40,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 85.0),
                                child: Text('Pagina web: '),
                              ),
                              SizedBox(
                                width: 300,
                                height: 40,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 20.0, bottom: 30.0, left: 20.0),
                          child: Row(
                            children: [
                              Text('Dirección: '),
                              SizedBox(
                                width: 600,
                                height: 40,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.only(top: 20.0, bottom: 30.0, left: 20.0),
                          child: Row(
                            children: [
                              Text('Ciudad: '),
                              SizedBox(
                                width: 200,
                                height: 40,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 85.0),
                                child: Text('Código postal: '),
                              ),
                              SizedBox(
                                width: 200,
                                height: 40,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Row(
                          children: [
                            Text(
                              'Empleados: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 150.0),
                                child: SizedBox(
                                  width: 250,
                                  height: 40,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 2,
                                      bottom: 120.0,
                                      left: 20.0,
                                      right: 20.0),
                                  child: Column(
                                    children: [
                                      ElevatedButton(
                                        child: Text('>>'),
                                        onPressed: () {},
                                      ),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      ElevatedButton(
                                        child: const Text('<<'),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 250,
                                height: 210,
                                child: TextField(
                                  maxLines: 5,
                                  minLines: 4,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 600.0, right: 30.0),
                              child: ElevatedButton(
                                child: const Text('Nuevo'),
                                onPressed: () {},
                              ),
                            ),
                            ElevatedButton(
                              child: const Text('Cancelar'),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
