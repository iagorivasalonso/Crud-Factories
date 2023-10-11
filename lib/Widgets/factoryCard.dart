import 'package:flutter/material.dart';




Card factoryCard({
  required String name,
  required String address,
  required String telephone,
  required String city}) {

  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    margin: const EdgeInsets.all(15),
    elevation: 10,
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
          height: 70,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: Text(name,
                   style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,),
                  )

                ],
              ),
              Row(
                children: [
                  Expanded(child: Text(address,
                   maxLines: 1,
                   overflow: TextOverflow.ellipsis,),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: SizedBox(
                                child: Text(telephone,
                                 maxLines: 1,
                                 overflow: TextOverflow.ellipsis,),),
                          ),
                        ],
                      ),),
                    Expanded(child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: SizedBox(
                            child: Text(city,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,),),
                        ),
                      ],
                    ),),

                  ],
                ),
              ),
            ],
          )),
    ),
  );
}