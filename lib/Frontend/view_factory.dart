import 'package:flutter/material.dart';

import 'factory.dart';
import 'list_factories.dart';


class viewFactory extends StatefulWidget {
  double mWidth;
  double mHeight;

  viewFactory(this.mWidth, this.mHeight);

  @override
  State<viewFactory> createState() => _viewFactoryState();
}

class _viewFactoryState extends State<viewFactory> {

  @override
  Widget build(BuildContext context) {

    double mWidth=widget.mWidth;
    double mHeight=widget.mHeight;

    return Scaffold(
      body: Align(
        alignment: Alignment.topLeft,
        child: Row(
          children: [
             SizedBox(
                 width: mWidth*0.2,
                 height: mHeight,
                 child: const listFactories(),
             ),
             SizedBox(
                 width: mWidth*0.8,
                 height: mHeight,
                 child: const newFactory()
             ),
          ],
        )
      ),
    );
  }
}