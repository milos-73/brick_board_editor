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
  bool? _inicialization;
  BrickWalls brickWalls = BrickWalls();

  @override
  void initState() {
    super.initState();
    _color = true;
    _inicialization = true;
   // print('widget.colorNumber ${widget.index}: ${widget.colorNumber}');
  }

  @override
  Widget build(BuildContext context) {



    return
      _color == true && _inicialization == true && widget.colorNumber == 84
          ? Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/noBreak1.png'),fit: BoxFit.fill)), child: ListTile(onTap: () {_inicialization = false; setState(() {_color = !_color!;});brickWalls.addEditedBrickTypeToList(context, widget.index);brickWalls.countNumberOfBricksOnEditedWall(context);}),)
          :  _color == true && _inicialization == true && widget.colorNumber == 85
          ? Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/noBreak2.png'),fit: BoxFit.fill)), child: ListTile(onTap: () {_inicialization = false; setState(() {_color = !_color!;});brickWalls.addEditedBrickTypeToList(context, widget.index);brickWalls.countNumberOfBricksOnEditedWall(context);}),)
          :  _color == true && _inicialization == true && widget.colorNumber == 86
          ? Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/noBreak3.png'),fit: BoxFit.fill)), child: ListTile(onTap: () {_inicialization = false; setState(() {_color = !_color!;});brickWalls.addEditedBrickTypeToList(context, widget.index);brickWalls.countNumberOfBricksOnEditedWall(context);}),)
          :  _color == true && _inicialization == true && widget.colorNumber == 87
          ? Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/noBreak4.png'),fit: BoxFit.fill)), child: ListTile(onTap: () {_inicialization = false; setState(() {_color = !_color!;});brickWalls.addEditedBrickTypeToList(context, widget.index);brickWalls.countNumberOfBricksOnEditedWall(context);}),)
          :  _color == true && _inicialization == true && widget.colorNumber == 88
          ? Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/noBreak5.png'),fit: BoxFit.fill)), child: ListTile(onTap: () {_inicialization = false; setState(() {_color = !_color!;});brickWalls.addEditedBrickTypeToList(context, widget.index);brickWalls.countNumberOfBricksOnEditedWall(context);}),)
          :  _color == true && _inicialization == true && widget.colorNumber == 90
          ? Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/crackedBrick.png'),fit: BoxFit.fill)), child: ListTile(onTap: () {_inicialization = false; setState(() {_color = !_color!;});brickWalls.addEditedBrickTypeToList(context, widget.index);brickWalls.countNumberOfBricksOnEditedWall(context);}),)

          : _color == true && _inicialization == true
          ? ListTile(shape: const BeveledRectangleBorder(side: BorderSide(color: Colors.black,width: 0.2)),tileColor: HexColor(colorNumbers.getColor(widget.colorNumber!)), onTap: () {_inicialization = false; setState(() {_color = !_color!;});brickWalls.addEditedBrickTypeToList(context, widget.index);brickWalls.countNumberOfBricksOnEditedWall(context);}, )


          :   _color == true && Provider.of<BrickColorNumber>(context, listen: false).index == 0 && !indexList.contains(widget.index)
          ? ListTile(shape: const BeveledRectangleBorder(side: BorderSide(color: Colors.black26,width: 0)),tileColor: HexColor('#d6d6d4'), onTap: () {setState(() {_color = !_color!;});brickWalls.addEditedBrickTypeToList(context, widget.index);brickWalls.countNumberOfBricks(context);},)
          : _color == true && Provider.of<BrickColorNumber>(context, listen: false).index == 0 && indexList.contains(widget.index)
          ? ListTile(shape: const BeveledRectangleBorder(side: BorderSide(color: Colors.black26,width: 0)),tileColor: HexColor('#cececc'), onTap: () {setState(() {_color = !_color!;});brickWalls.addEditedBrickTypeToList(context, widget.index);brickWalls.countNumberOfBricks(context);},)
          : Provider.of<BrickColorNumber>(context, listen: false).index == 84
          ? Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/noBreak1.png'),fit: BoxFit.fill)), child: ListTile(onTap: () {setState(() {_color = !_color!;});brickWalls.addEditedBrickTypeToList(context, widget.index);brickWalls.countNumberOfBricks(context);},))
          : Provider.of<BrickColorNumber>(context, listen: false).index == 85
          ? Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/noBreak2.png'),fit: BoxFit.fill)), child: ListTile(onTap: () {setState(() {_color = !_color!;});brickWalls.addEditedBrickTypeToList(context, widget.index);brickWalls.countNumberOfBricks(context);},))
          : Provider.of<BrickColorNumber>(context, listen: false).index == 86
          ? Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/noBreak3.png'),fit: BoxFit.fill)), child: ListTile(onTap: () {setState(() {_color = !_color!;});brickWalls.addEditedBrickTypeToList(context, widget.index);brickWalls.countNumberOfBricks(context);},))
          : Provider.of<BrickColorNumber>(context, listen: false).index == 87
          ? Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/noBreak4.png'),fit: BoxFit.fill)), child: ListTile(onTap: () {setState(() {_color = !_color!;});brickWalls.addEditedBrickTypeToList(context, widget.index);brickWalls.countNumberOfBricks(context);},))
          : Provider.of<BrickColorNumber>(context, listen: false).index == 88
          ? Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/noBreak5.png'),fit: BoxFit.fill)), child: ListTile(onTap: () {setState(() {_color = !_color!;});brickWalls.addEditedBrickTypeToList(context, widget.index);brickWalls.countNumberOfBricks(context);},))
          : Provider.of<BrickColorNumber>(context, listen: false).index == 90
          ? Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/crackedBrick.png'),fit: BoxFit.fill)), child: ListTile(onTap: () {setState(() {_color = !_color!;});brickWalls.addEditedBrickTypeToList(context, widget.index);brickWalls.countNumberOfBricks(context);},))
          : ListTile(shape: const BeveledRectangleBorder(side: BorderSide(color: Colors.black26,width: 0)),tileColor: HexColor(colorNumbers.getColor(Provider.of<BrickColorNumber>(context, listen: false).index ?? 0)),onTap: () {setState(() {_color = !_color!;});brickWalls.addEditedBrickTypeToList(context, widget.index);brickWalls.countNumberOfBricks(context);},);

  }

}