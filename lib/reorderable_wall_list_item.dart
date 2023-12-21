import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grid_maker_bricks/hex_color.dart';
import 'package:grid_maker_bricks/provider_color.dart';
import 'package:grid_maker_bricks/walls.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'color_numbers.dart';
import 'created_wall_builder.dart';
import 'edit_wall.dart';


class ReorderableWallsItems extends StatefulWidget {

  final int? wallNumber;

  const ReorderableWallsItems({super.key, this.wallNumber});

  @override
  State<ReorderableWallsItems> createState() => _ReorderableWallsItemsState();
}

List? wall;
String? sharedWall;
int bricksNumber = 0;
int breakingBricksNumber = 0;
int savedBricksCount = 0;

class _ReorderableWallsItemsState extends State<ReorderableWallsItems> {

  getWallData(int? wallNumber) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    wall = jsonDecode(prefs.getString('wall${widget.wallNumber}') ?? '');

    return wall;
  }

  Future<int> countBricks(List wall) async {

    var count = 0;
    for(var x in wall) {
      for (var y in x){
        if (y != 0) {
          count = count + 1;
        }
      }
    }
    bricksNumber = count;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('brickCountOnWall${widget.wallNumber}', count);


    return bricksNumber;
  }

  Future<int> countBreakingBricks(List wall) async {

    var countBreakingBricks = 0;
    for(var x in wall) {
      for (var y in x){
        if (y == 100) {
          countBreakingBricks = countBreakingBricks + 1;
        }
      }
    }
    breakingBricksNumber = countBreakingBricks;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('breakingBrickCountOnWall${widget.wallNumber}', countBreakingBricks);


    return bricksNumber;
  }

  Future<int> getBricksNumber(int wallNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    savedBricksCount = prefs.getInt('brickCountOnWall${widget.wallNumber}') ?? 0;
    return savedBricksCount;
  }

  shareWallData(int? wallNumber) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    sharedWall = prefs.getString('wall${widget.wallNumber}') ?? "";
    int sharedWallNumber = wallNumber! + 1;
    return 'WALL: $sharedWallNumber  ${sharedWall!}';
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getWallData(wallNumber),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

        if (snapshot.hasData) {
          countBricks(snapshot.data!);
          countBreakingBricks(snapshot.data!);

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width *0.95,
                  child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Padding(
                        //padding: const EdgeInsets.only(left:10),
                        //child: SizedBox(width: MediaQuery.of(context).size.width * 0.47,
                          // child: GridView.builder(
                          //   shrinkWrap: true,
                          //   physics: const NeverScrollableScrollPhysics(),
                          //   itemCount: 220,
                          //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 11, childAspectRatio: 2),
                          //   itemBuilder: (context, index) => CreatedWallBuilder(index, snapshot.data),
                          // ),
                       // ),
                      //),
                      Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${widget.wallNumber!}'),
                        ),
                      ],),
                      Column(children: [
                        Text('Bricks: $bricksNumber'),
                      ],),
                      Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5,right: 5),
                          child: Text('Breaking: $breakingBricksNumber'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5,right: 5),
                          child: Text('NoBreaking: $breakingBricksNumber'),
                        ),
                      ],),
                       Column(children: [
                         ElevatedButton(onPressed: () async { Provider.of<BrickColorNumber>(context, listen: false).index = 0; getBricksNumber(widget.wallNumber!).then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditWall(wallNumber: widget.wallNumber, bricksCount: savedBricksCount))));},style: ElevatedButton.styleFrom(backgroundColor: HexColor('#193C40')) ,child: const Text('Edit', style: TextStyle(color: Colors.white70),),),
                       ],),
                      Column(children: [
                        IconButton(onPressed: () async {Share.share(await shareWallData(widget.wallNumber));}, icon: FaIcon(FontAwesomeIcons.share, color: HexColor('#A62B1F'),))
                      ],),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.10,
                          child: const Icon(Icons.drag_handle)),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },

    );
  }
}