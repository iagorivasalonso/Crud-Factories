import 'package:flutter/material.dart';

Card factoryCard() {

  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    margin: const EdgeInsets.all(10),
    elevation: 10,
    child: const Padding(
      padding: EdgeInsets.all(7.0),
      child: SizedBox(
          height: 70,
          child: Column(
            children: [
              Row(
                children: [
                  Text("nombre",
                   style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 150,
                    child: Text("direccion"),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                            width: 170,
                            child: Text("telefono"))
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("ciudad")
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
    ),
  );
}