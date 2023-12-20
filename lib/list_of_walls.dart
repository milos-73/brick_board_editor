import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grid_maker_bricks/wals_items.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'hex_color.dart';

class ListWalls extends StatefulWidget {

  const ListWalls({super.key});

  @override
  State<ListWalls> createState() => _ListWallsState();
}

class _ListWallsState extends State<ListWalls> {
  SharedPreferences? prefs;
  late int wallsCount;
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
      print('Existing wallNumbersIndexList: ${jsonDecode(prefs.getString('wallNumbersIndexList') ?? '')}');
    }else{
      for (var i=0; i == wallsCount; i++){
        wallNumbersIndexList.add(i+1);
        }
      prefs.setString('wallNumbersIndexList', jsonEncode(wallNumbersIndexList));
      print('New wallNumbersIndexList: $wallNumbersIndexList');
    }
  }

  Future<void> setIndexInNewOrder()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('wallNumbersIndexList', jsonEncode(wallNumbersIndexList));
  }

  @override
  void initState() {
    super.initState();
    wallsCountNumber().then((value) => wallIndexList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      leading: IconButton(onPressed: (){Navigator.pop(context);} , icon: const FaIcon(FontAwesomeIcons.arrowLeft,color: Colors.white70,)),
      title: const Text('List of boards',style: TextStyle(color: Colors.white70,)), backgroundColor:HexColor('#214001'),),backgroundColor: HexColor('#ffe7d9'),
      body: ReorderableListView.builder(
          itemCount: wallNumbersIndexList.length,
          itemBuilder:(context,index){
            //final String productName = wallNumbersIndexList[index].toString();
            return SizedBox(height:MediaQuery.of(context).size.height * 0.25,key: ValueKey(wallNumbersIndexList[index].toString()),
                child: WallsItems(wallNumber: wallNumbersIndexList[index]-1),);
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
      );

  }
}
