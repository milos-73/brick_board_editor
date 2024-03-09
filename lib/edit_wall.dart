import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grid_maker_bricks/provider_color.dart';
import 'package:grid_maker_bricks/reorderable_list_of_walls.dart';
import 'package:grid_maker_bricks/walls.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'color_buttons.dart';
import 'edit_wall_tiles.dart';
import 'editor_buttons.dart';
import 'hex_color.dart';
import 'list_of_walls.dart';

class EditWall extends StatefulWidget {

  final int? wallNumber;
  final int? bricksCount;

  const EditWall({super.key, this.wallNumber, this.bricksCount});

  @override
  State<EditWall> createState() => _EditWallState();
}

BrickWalls brickWalls = BrickWalls();

List? colorsNumbers;

class _EditWallState extends State<EditWall> {

  Future<List?> getWallColors(int? wallNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    colorsNumbers = jsonDecode(prefs.getString('wall$wallNumber') ?? '');
    return colorsNumbers;
  }

  @override
  void initState() {
    super.initState();
    Provider.of<BrickColorNumber>(context, listen: false).bricksEditedWallCount = widget.bricksCount ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: HexColor('#ffe7d9'),
      appBar: AppBar(backgroundColor: HexColor('#214001'), actions: [

        Consumer<BrickColorNumber>(builder: (context, value, child){
          return Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Wall: ${widget.wallNumber}', style: const TextStyle(color: Colors.white70),),
                Text('Bricks: ${value.bricksEditedWallCount}', style: const TextStyle(color: Colors.white70),),

              ],
            ),
          );}),

      ],
        title: const Text('Edit Wall', style: TextStyle(color: Colors.white70),),
        leading: IconButton(onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ReorderableListWalls()));} , icon: const FaIcon(FontAwesomeIcons.arrowLeft, color: Colors.white70,size: 15,)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
          child: Column(
            children: [
              FutureBuilder(
                future:  getWallColors(widget.wallNumber),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

                  if (snapshot.hasData) {
                    brickWalls.updateEditedList(colorsNumbers);
                    return SizedBox (height: MediaQuery.of(context).size.height * 0.46,
                        child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: 220,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 11, childAspectRatio: 2),
                          itemBuilder: (context, index) => EditWallTile(wallNumber: widget.wallNumber, index: index, colorNumber:
                          (colorsNumbers?[(index / 11).floor()][index % 11]) !=0
                              ? ((colorsNumbers?[(index / 11).floor()][index % 11]) -10)
                              : 0,
                          ),
                        )
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),

              //const SizedBox(height: 5),
              const ColorsGrid(),
              EditButtons(wallNumber: widget.wallNumber)
            ],
          ),
        ),
      ),
    );
  }
}