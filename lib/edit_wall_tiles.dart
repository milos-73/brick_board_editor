import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grid_maker_bricks/provider_color.dart';
import 'package:grid_maker_bricks/walls.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'color_numbers.dart';
import 'hex_color.dart';

class EditWallTile extends StatefulWidget {

  final int? wallNumber;
  final int index;
  final int? colorNumber;

  const EditWallTile({this.wallNumber,super.key, required this.index, this.colorNumber});

  @override
  State<EditWallTile> createState() => _EditWallTileState();
}

class _EditWallTileState extends State<EditWallTile> {

  List indexList = [5,16,27,38,49,60,71,82,93,104,115,126,137,148,159,170,181,192,203,214,99,100,101,102,103,105,106,107,108,109,110,111,112,113,114,116,117,118,119,120];
  ColorNumbers colorNumbers = ColorNumbers();
  bool? _color;
  BrickWalls brickWalls = BrickWalls();

 @override
  void initState() {
    super.initState();
    _color = true;
   }

  @override
  Widget build(BuildContext context) {



    return ListTile(
      shape: const BeveledRectangleBorder(side: BorderSide(color: Colors.black,width: 0.2)),
      tileColor: _color == true && Provider.of<BrickColorNumber>(context, listen: false).index == 0 && !indexList.contains(widget.index) && widget.colorNumber! == 0
          ? HexColor('#d6d6d4')
          : _color == true && Provider.of<BrickColorNumber>(context, listen: false).index == 0 && indexList.contains(widget.index) && widget.colorNumber! == 0
          ? HexColor('#cececc')
          : _color == true 
          ? HexColor(colorNumbers.getColor(widget.colorNumber!)) 
          : HexColor(colorNumbers.getColor(Provider.of<BrickColorNumber>(context, listen: false).index ?? 0)),
      onTap: () {
        setState(() {_color = !_color!;});
        brickWalls.addEditedBrickTypeToList(context, widget.index);
      },
    );
  }
}
