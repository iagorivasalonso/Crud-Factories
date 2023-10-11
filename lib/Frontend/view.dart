import 'package:desktop_app/Frontend/list_emails.dart';
import 'package:desktop_app/Frontend/send.dart';
import 'package:flutter/material.dart';

import 'email.dart';
import 'factory.dart';
import 'list_factories.dart';
import 'list_sends.dart';


class view extends StatefulWidget {

  double mWidth;
  double mHeight;
  String tView;

  view(this.mWidth, this.mHeight, this.tView);

  @override
  State<view> createState() => _viewState();
}

class _viewState extends State<view> {

  @override
  Widget build(BuildContext context) {

    double mWidth = widget.mWidth;
    double mHeight = widget.mHeight;

    String view = widget.tView;

    return Scaffold(
      body: Align(
        alignment: Alignment.topLeft,
        child: Row(
          children: [
             SizedBox(
                 width: mWidth*0.2,
                 height: mHeight,
                 child: view == 'factory'
                        ? listFactories()
                        : view == 'email'
                        ? listEmails()
                        : listSends()
             ),
             SizedBox(
                 width: mWidth*0.8,
                 height: mHeight,
                 child: view == 'factory'
                        ? const newFactory()
                        : view == 'email'
                        ? const newEmail()
                        : const newSend()


             ),
          ],
        )
      ),
    );
  }
}