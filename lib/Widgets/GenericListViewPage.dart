import 'dart:io';
import 'package:flutter/material.dart';
import '../Backend/Global/variables.dart';
import '../generated/l10n.dart';
import 'dropDownButton.dart';

class GenericListViewPage<T> extends StatefulWidget {
  final List<T> itens;
  final List<String> filters;
  final Widget Function(T item, int index) itemBuilder;
  final Future<void> Function(T item, int index)? onTap;
  final Future<void> Function(String filter, String search)? onFilter;
  final Future<void> Function(T item)? onDelete;
  final void Function(int index)? onSelect;
  final String defaultFilter;

  const GenericListViewPage({
    required this.itens,
    required this.itemBuilder,
    this.filters = const [],
    required this.onTap,
    this.onFilter,
    this.onDelete,
    this.onSelect,
    this.defaultFilter = '',
    super.key,
  });

  @override
  State<GenericListViewPage<T>> createState() => _GenericListViewPageState<T>();
}

class _GenericListViewPageState<T> extends State<GenericListViewPage<T>> {
  late List<T> displayItems;
  String? selectedFilter;
  String searchText = '';
  int opSelected = 0;
  @override
  void initState() {
    super.initState();
    displayItems = List.from(widget.itens);
    selectedFilter = widget.defaultFilter.isNotEmpty
        ? widget.defaultFilter
        : (widget.filters.isNotEmpty ? widget.filters[0] : null);
  }


  @override
  void didUpdateWidget(GenericListViewPage<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.itens != widget.itens) {
      setState(() {
        displayItems = List.from(widget.itens);
      });
    }
  }


  void _runFilter(String value) async {
    searchText = value;

    if (widget.onFilter != null) {
      await widget.onFilter!(selectedFilter ?? '', searchText);
    }
  }

  @override
  Widget build(BuildContext context0) {

    BuildContext context = Platform.isWindows ? context1 : context0;

    List<String> opSearch = [S.of(context).allMale, S.of(context).filter];

     double heightButons = 40;
     double heightpanel = 150;
     double heightFilters = heightpanel + heightButons;
print(opSelected);
     return LayoutBuilder(
         builder: (context0,constrains) {
           final height = widget.filters.isNotEmpty
                          ? constrains.maxHeight -heightFilters
                          : constrains.maxHeight;
           final width = constrains.maxWidth;

           return Column(
             children: [
               if(widget.filters.isNotEmpty)
               Row(
                 children: [
                   for(int index = 0; index < opSearch.length; index++)
                   GestureDetector(
                     child: Material(
                       child: Container(
                          height: heightButons,
                          width: width * 0.5,
                          color: index == opSelected
                               ? Colors.lightGreen
                               : Colors.white,
                          child: Center(
                            child: Text(opSearch[index],
                               style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0,
                                  color: index == opSelected
                                         ? Colors.white
                                         : Colors.black,
                             ),
                             maxLines: 1,
                             overflow: TextOverflow.ellipsis),
                          ),
                       ),
                     ),
                     onTap:() {
                       setState(() {
                         opSelected = index;
                       });
                     }
                   ),
                 ],
               ),
               if (opSelected==1)
               Container(
                   height:heightpanel,
                   color: Colors.greenAccent,
                   child: Column(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       Material(
                         color: Colors.transparent,
                         child: Padding(
                           padding: const EdgeInsets.only(left: 15.0,top: 10.0),
                           child: GenericDropdown<String>(
                             items: widget.filters,
                             camp: S.of(context).filter,
                             selectedItem: selectedFilter,
                             hint: S.of(context).name,
                             itemLabel: (item) => item,
                             onChanged: (value) {
                               setState(() {
                                 selectedFilter = value;
                                 _runFilter(searchText);
                               });
                             },
                           ),
                         ),
                       ),
                       Material(
                         color: Colors.transparent,
                         child: SizedBox(
                           width: 150,
                           child: Padding(
                             padding: const EdgeInsets.only(top: 20.0,bottom: 30.0),
                             child: TextField(
                               decoration: InputDecoration(
                                 hintText: S.of(context).search,
                                 border: OutlineInputBorder(),
                                 isDense: true,
                                 contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                               ),
                               onChanged: (value) {
                                 _runFilter(value);
                               },
                             ),
                           ),
                         ),
                       ),
                     ],
                   ),
                 ),

               SizedBox(
                 height: opSelected == 0 && widget.filters.isNotEmpty
                         ? height + heightpanel
                         : height,
                 child: ListView.builder(
                   itemCount: displayItems.length,
                   itemBuilder: (context, index) {
                     final item = displayItems[index];
                     return Dismissible(
                       key: ValueKey(item.hashCode),
                       background: Container(color: Colors.redAccent),
                       onDismissed: (_) async {
                         if (widget.onDelete != null) await widget.onDelete!(item);
                         setState(() => displayItems.removeAt(index));
                       },
                       child: GestureDetector(
                         onTap: () async {
                           if (widget.onTap != null) await widget.onTap!(item, index);
                           if (widget.onSelect != null) widget.onSelect!(index);
                         },
                         child: widget.itemBuilder(item, index),
                       ),
                     );
                   },
                 ),
               ),
             ],
           );
         });
  }
}
