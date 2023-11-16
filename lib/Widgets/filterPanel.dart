import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class filterPanel extends StatefulWidget {

  double hFilter;
  List<String> filterList = [];


  filterPanel(this.hFilter, this.filterList);

  State<filterPanel> createState() => _filterPanelState();
}

class _filterPanelState extends State<filterPanel> {

  get selectedValue => null;



  @override
  Widget build(BuildContext context) {

    double mHeightfilter = widget.hFilter;
    List<String> filterList = widget.filterList;
    return Container(
      color: Colors.greenAccent,
      height: mHeightfilter,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0,top: 10.0),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Text("Filtrar por:",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,),
                ),
                Expanded(
                  child:DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: const Expanded(
                        child: Text('Select Item',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      items: filterList
                          .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child:Text(item,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                          .toList(),
                      value: selectedValue,
                      onChanged:
                          (String?  value) {
                        setState(()
                        {});
                      },
                      buttonStyleData: const  ButtonStyleData(
                        height: 50,
                        width: 160,
                        padding: EdgeInsets.only(left:14, right: 14),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 15.0,left: 40.0,right: 40.0),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Buscar...'
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
