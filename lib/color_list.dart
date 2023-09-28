import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grid_maker_bricks/provider_color.dart';
import 'package:provider/provider.dart';

import 'color_numbers.dart';
import 'hex_color.dart';

class ColorList extends StatefulWidget {
  final int indexNo;

  const ColorList(
      this.indexNo, {super.key});

  @override
  State<ColorList> createState() => _ColorListState();
}

class _ColorListState extends State<ColorList> {

  int? activeColor = 0;
  ColorNumbers colorNumbers = ColorNumbers();

  void setColor(int index){
    setState(() {
      activeColor = index;
    });

    Provider.of<BrickColorNumber>(context,listen: false).setBrickColor(index);

  }

  @override
  Widget build(BuildContext context) {

    return ListTile(
      tileColor: HexColor(colorNumbers.getColor(widget.indexNo)),
      onTap: () {setColor(widget.indexNo);},
    );
  }
}