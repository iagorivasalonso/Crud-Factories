import 'package:desktop_app/Frontend/list_emails.dart';
import 'package:desktop_app/Frontend/new_send.dart';
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

    double mWidthList = mWidth *0.2;

    if (mWidth > 240)
    {
      if (mWidthList < 200)
      {
        mWidthList = 200;
      }
      else
      {
        mWidthList = mWidth *0.2;
      }

    }
    else
    {
      mWidthList = mWidth *0.8;
    }

    double mWidthPanel = mWidth-mWidthList;
/*
    mWidthList < 200
        ? 200
        : mWidthList,
    */
    print(mWidth);
    return Scaffold(
      body: Align(
        alignment: Alignment.topLeft,
        child: Row(
          children: [
             SizedBox(
                 width: mWidthList,
                 height: mHeight,
                 child: view == 'factory'
                        ? listFactories(mHeight,mWidth)
                        : view == 'email'
                        ? listEmails(mHeight)
                        : listSends(mHeight)
             ),

             SizedBox(
                 width: mWidthPanel,
                 height: mHeight,
                 child: view == 'factory'
                        ?  newFactory()
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