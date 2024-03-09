import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grid_maker_bricks/hex_color.dart';
import 'package:grid_maker_bricks/provider_color.dart';
import 'package:grid_maker_bricks/wall_screenshot.dart';
import 'package:grid_maker_bricks/walls.dart';
import 'package:path_provider/path_provider.dart';
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
int noBreakingBricksNumber = 0;
int savedBricksCount = 0;
String? directory = '';
String? fileName;
String? path;

class _ReorderableWallsItemsState extends State<ReorderableWallsItems> {

  getWallData(int? wallNumber) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    wall = jsonDecode(prefs.getString('wall${widget.wallNumber}') ?? '');

    return wall;
  }

  Future<String> imageDirectory()async {
    imageCache.clear();
    var directory = (await getApplicationDocumentsDirectory()).path ?? '';
    // fileName =  '${widget.wallNumber}.png';
    // path = directory;
    return directory;
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

  Future<int> countNoBreakingBricks(List wall) async {

    var countNoBreakingBricks = 0;
    for(var x in wall) {
      for (var y in x){
        if (y > 93 && y < 99) {
          countNoBreakingBricks = countNoBreakingBricks + 1;
        }
      }
    }
    noBreakingBricksNumber = countNoBreakingBricks;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('noBreakingBrickCountOnWall${widget.wallNumber}', countNoBreakingBricks);


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
    int sharedWallNumber = wallNumber!;
    return 'WALL: $sharedWallNumber  ${sharedWall!}';
  }

  @override
  void initState() {
    super.initState();
    imageDirectory().then((value) => setState((){directory = value;}));
  }

  @override
  Widget build(BuildContext context) {

     return FutureBuilder(
      future: getWallData(wallNumber),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

        if (snapshot.hasData) {
          countBricks(snapshot.data!);
          countBreakingBricks(snapshot.data!);
          countNoBreakingBricks(snapshot.data!);

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Column(children: [
                  SizedBox(width: 100,height: 100,child: Image.file(File('$directory/${widget.wallNumber}.png')))
              ],),
                Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: MediaQuery.of(context).size.width *0.70,
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
                              // Column(children: [
                              //   Text('Bricks: $bricksNumber'),
                              // ],),
                              const Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start,children: [
                                // Padding(
                                //   padding: const EdgeInsets.only(left: 5,right: 5),
                                //   child: Text('Breaking: $breakingBricksNumber'),
                                // ),
                                // Padding(
                                //   padding: const EdgeInsets.only(left: 5,right: 5),
                                //   child: Text('NoBreak: $noBreakingBricksNumber'),
                                // ),
                              ],),
                               Column(crossAxisAlignment: CrossAxisAlignment.end,children: [
                                 ElevatedButton(onPressed: () async { Provider.of<BrickColorNumber>(context, listen: false).index = 0; getBricksNumber(widget.wallNumber!).then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditWall(wallNumber: widget.wallNumber, bricksCount: savedBricksCount))));},style: ElevatedButton.styleFrom(backgroundColor: HexColor('#193C40')) ,child: const Text('Edit', style: TextStyle(color: Colors.white70),),),
                               ],),
                              Column(children: [
                                IconButton(onPressed: () async {Share.share(await shareWallData(widget.wallNumber));}, icon: FaIcon(FontAwesomeIcons.share, color: HexColor('#A62B1F'),))
                              ],),
                              Column(children: [
                                IconButton(onPressed: () async {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WallScreenshot(wallNumber: widget.wallNumber)));}, icon: FaIcon(FontAwesomeIcons.image, color: HexColor('#A62B1F'),))
                              ],),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.10,
                                  child: const Icon(Icons.drag_handle)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width *0.70,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Column(children: [
                            Text('Bricks: $bricksNumber'),
                          ],),
                          Column(children: [
                              Text('Breaking: $breakingBricksNumber'),
                          ],),
                          Column(children: [
                              Text('NoBreak: $noBreakingBricksNumber'),
                          ],),
                        ],),
                      ),
                    )
                  ],
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