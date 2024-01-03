import 'dart:convert';
import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grid_maker_bricks/reorderable_wall_list_item.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'hex_color.dart';
import 'list_of_walls.dart';

class ReorderableListWalls extends StatefulWidget {

  const ReorderableListWalls({super.key});

  @override
  State<ReorderableListWalls> createState() => _ReorderableListWallsState();
}

class _ReorderableListWallsState extends State<ReorderableListWalls> {
  SharedPreferences? prefs;
  int? wallsCount;
  List wallNumbersIndexList = [];
  bool wallIndexExists = false;

  Future<void> loadPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> wallsCountNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int count = prefs.getInt('wallNumber') ?? 0;
    setState(() {
      wallsCount = count;
    });
  }

  Future<void> wallIndexList() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('wallNumbersIndexList')){
      wallNumbersIndexList = await jsonDecode(prefs.getString('wallNumbersIndexList') ?? '');
      //print('Existing wallNumbersIndexList: $wallNumbersIndexList}');
    }else{
      //print('wallsCount: ${wallsCount}');

      for (var i = 1; i < wallsCount!+1; i++){
        wallNumbersIndexList.add(i);
        //print('i:${i}');
      }

      prefs.setString('wallNumbersIndexList', jsonEncode(wallNumbersIndexList));
      //print('New wallNumbersIndexList: $wallNumbersIndexList');
    }
  }

  Future<void> setIndexInNewOrder()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('wallNumbersIndexList', jsonEncode(wallNumbersIndexList));
  }
  
  Future<void> printWallList() async {

    List wallListIndex;
    String levelsList = '';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    wallListIndex = await jsonDecode(prefs.getString('wallNumbersIndexList') ?? '');
    for (var wall in wallListIndex){
      String? level = prefs.getString('wall$wall');
      levelsList = '$levelsList,\n ${level!}';
    }
    //final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    Share.share(levelsList);
    print(levelsList);
  }

  @override
  void initState() {
    super.initState();
    wallsCountNumber().then((value) => wallIndexList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10,bottom: 5),
          child: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Consumer<BrickColorNumber>(builder: (context, value, child){
              //   return Text('Bricks: ${value.bricksCount}', style: const TextStyle(color: Colors.white70),);}),
              ElevatedButton(onPressed: () async {await printWallList();},
                  style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),backgroundColor: HexColor(('#2E5902'))),child: const Text('Order', style: TextStyle(color: Colors.white70),)),

              // const SizedBox(width: 15,),
              // ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const ListWalls()));},
              //     style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),backgroundColor: HexColor(('#2E5902'))),child: const Text('List', style: TextStyle(color: Colors.white70),)),
            ],
          ),
        )
      ],


      leading: IconButton(onPressed: (){Navigator.pop(context);} , icon: const FaIcon(FontAwesomeIcons.arrowLeft,color: Colors.white70,)),
      title: const Text('List of boards',style: TextStyle(color: Colors.white70,)), backgroundColor:HexColor('#214001'),),backgroundColor: HexColor('#ffe7d9'),
        body:
        wallsCount != null || wallsCount != 0  ?
        ReorderableListView.builder(
          itemCount: wallNumbersIndexList.length,
          itemBuilder:(context,index){
            //final String productName = wallNumbersIndexList[index].toString();
            return SizedBox(key: ValueKey(wallNumbersIndexList[index].toString()),
              child: ReorderableWallsItems(wallNumber: wallNumbersIndexList[index]),);
          },
          onReorder: (int oldIndex, int newIndex) async {

            setState(()  {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final element = wallNumbersIndexList.removeAt(oldIndex);
              wallNumbersIndexList.insert(newIndex, element);

            });
            await setIndexInNewOrder();
          },

        )
            : const Center(child: Text('No walls created yet'))
    );

  }
}
