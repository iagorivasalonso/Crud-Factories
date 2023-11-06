
import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:flutter/material.dart';

class newEmail extends StatefulWidget {
  const newEmail({super.key});

  @override
  State<newEmail> createState() => _newEmailState();
}

class _newEmailState extends State<newEmail> {

  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();

  double widthBar = 10.0;

  @override
  Widget build(BuildContext context) {

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
                height: 416,
                width: 854,
                child:  Align(
                  alignment: Alignment.topRight,
                  child:  Padding(
                    padding: const EdgeInsets.only(left: 30.0,top: 30.0),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Text('Email: ',
                              style: TextStyle(fontWeight: FontWeight.bold),),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top:20.0,bottom: 30.0),
                          child: Row(
                            children: [
                              Text('Nuevo email: '),
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
                          padding: EdgeInsets.only(top:20.0, bottom: 30.0),
                          child: Row(
                            children: [
                              Text('Contraseña: '),
                              SizedBox(
                                width: 400,
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
                          padding: EdgeInsets.only(top:20.0, bottom: 20.0),
                          child: Row(
                            children: [
                              Text('Verificar contraseña: '),
                              SizedBox(
                                width: 400,
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
                          padding: EdgeInsets.only(bottom: 30.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 130.0),
                                child: Text('Las contraseñas no coinciden ',
                                  style: TextStyle(color: Colors.red),),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 600),
                          child: Container(
                            width: 200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  child: const Text('Nuevo'),
                                  onPressed: () {},
                                ),
                                ElevatedButton(
                                  child: const Text('Cancelar'),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
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
