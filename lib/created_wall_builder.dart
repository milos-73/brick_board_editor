import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grid_maker_bricks/hex_color.dart';

import 'color_numbers.dart';

ColorNumbers colorNumbers = ColorNumbers();

class CreatedWallBuilder extends StatelessWidget {

  final List? wall;
  final int index;

  const CreatedWallBuilder(this.index, this.wall, {super.key});

  @override
  Widget build(BuildContext context) {

      return ListTile(
      shape: const BeveledRectangleBorder(side: BorderSide(color: Colors.black,width: 0.2)),
      tileColor: (wall?[(index / 11).floor()][index % 11]) != 0
      ? HexColor(colorNumbers.getColor((wall?[(index / 11).floor()][index % 11])-10))
      : HexColor(colorNumbers.getColor(0)),
      //leading: Text('$index'),
      onTap: () {
      },
    );
  }
}
