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

    return
      (wall?[(index / 11).floor()][index % 11]) == 94
          ? Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/noBreak1.png'),fit: BoxFit.fill)), child: ListTile(onTap: () {},))
          : (wall?[(index / 11).floor()][index % 11]) == 95
          ? Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/noBreak2.png'),fit: BoxFit.fill)), child: ListTile(onTap: () {},))
          : (wall?[(index / 11).floor()][index % 11]) == 96
          ? Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/noBreak3.png'),fit: BoxFit.fill)), child: ListTile(onTap: () {},))
          : (wall?[(index / 11).floor()][index % 11]) == 97
          ? Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/noBreak4.png'),fit: BoxFit.fill)), child: ListTile(onTap: () {},))
          : (wall?[(index / 11).floor()][index % 11]) == 98
          ? Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/noBreak5.png'),fit: BoxFit.fill)), child: ListTile(onTap: () {},))
          : (wall?[(index / 11).floor()][index % 11]) == 100
          ? Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/crackedBrick.png'),fit: BoxFit.fill)), child: ListTile(onTap: () {},))
          : (wall?[(index / 11).floor()][index % 11]) != 0
          ? ListTile(shape: const BeveledRectangleBorder(side: BorderSide(color: Colors.black,width: 0.2)),tileColor: HexColor(colorNumbers.getColor((wall?[(index / 11).floor()][index % 11])-10)))
          : ListTile(shape: const BeveledRectangleBorder(side: BorderSide(color: Colors.black,width: 0.2)),tileColor: HexColor(colorNumbers.getColor(0))

      );
  }
}