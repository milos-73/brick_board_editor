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


class WallsItems extends StatefulWidget {

  final int? wallNumber;

  const WallsItems({super.key, this.wallNumber});

  @override
  State<WallsItems> createState() => _WallsItemsState();
}

List? wall;
String? sharedWall;
int bricksNumber = 0;
int savedBricksCount = 0;

class _WallsItemsState extends State<WallsItems> {

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
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getWallData(wallNumber),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

        if (snapshot.hasData) {
          countBricks(snapshot.data!);

          return Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: MediaQuery.of(context).size.width,
                child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:10),
                      child: SizedBox(width: MediaQuery.of(context).size.width * 0.47,
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 220,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 11, childAspectRatio: 2),
                          itemBuilder: (context, index) => CreatedWallBuilder(index, snapshot.data),
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.40,
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Board: ${widget.wallNumber!}'),
                          Text('Bricks: $bricksNumber'),
                          const SizedBox(height: 10,),
                          ElevatedButton(onPressed: () async { Provider.of<BrickColorNumber>(context, listen: false).index = 0; getBricksNumber(widget.wallNumber!).then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditWall(wallNumber: widget.wallNumber, bricksCount: savedBricksCount))));},style: ElevatedButton.styleFrom(backgroundColor: HexColor('#193C40')) ,child: const Text('Edit', style: TextStyle(color: Colors.white70),),),
                          IconButton(onPressed: () async {Share.share(await shareWallData(widget.wallNumber));}, icon: FaIcon(FontAwesomeIcons.share, color: HexColor('#A62B1F'),))
                          //ElevatedButton(onPressed: () {  },style: ElevatedButton.styleFrom(backgroundColor: Colors.amber) ,child: const Text('Delete'),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },

    );
  }
}