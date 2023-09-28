import 'package:flutter/material.dart';
import 'package:grid_maker_bricks/hex_color.dart';
import 'package:grid_maker_bricks/provider_color.dart';
import 'package:grid_maker_bricks/walls.dart';
import 'package:grid_maker_bricks/wals_items.dart';
import 'package:provider/provider.dart';

import 'color_list.dart';
import 'grid_items.dart';
import 'list_of_walls.dart';

void main() {

  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider<BrickColorNumber>(create: (context) => BrickColorNumber())
      ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Bricks breaker walls editor',
      home: MyHomePage(title: 'Bricks breaker walls editor'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

BrickWalls brickWalls = BrickWalls();

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: HexColor('#ffe7d9'),
      appBar: AppBar(actions: [
        ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const ListWalls()));}, style: ElevatedButton.styleFrom(backgroundColor: HexColor(('#2E5902'))),child: const Text('List',style: TextStyle(color: Colors.white70,)))
      ],
        title: Text(widget.title, style: const TextStyle(color: Colors.white70,)),
        backgroundColor:HexColor('#214001'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
          child: Column(
            children: [
              SizedBox (height: MediaQuery.of(context).size.height * 0.45,
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: 220,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 11, childAspectRatio: 2),
                  itemBuilder: (context, index) => ItemTile(index),
                ),
              ),
              //const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(top:30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox (height: MediaQuery.of(context).size.height * 0.25,
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: 73,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 11, childAspectRatio: 1.5),
                        itemBuilder: (context, index) => ColorList(index),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20, bottom: 15, top: 20),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(children: [
                      SizedBox(width: 100, height: 40,
                        child: ElevatedButton(onPressed: (){
                          Provider.of<BrickColorNumber>(context,listen: false).setBrickColor(0);
                          setState(() {});
                          brickWalls.resetWall();
                          },style: ElevatedButton.styleFrom(
                          backgroundColor: HexColor('#193C40'),
                        ), child: const Text('Reset',style: TextStyle(color: Colors.white70,)),),
                      )],),
                    Column(children: [
                      SizedBox(width: 100, height: 40,
                        child: ElevatedButton(onPressed: (){
                          brickWalls.saveWall();},style: ElevatedButton.styleFrom(
                          backgroundColor: HexColor('#193C40'),
                        ), child: const Text('Save',style: TextStyle(color: Colors.white70,)),),
                      )
                    ],)
                  ],),
              )
            ],
          ),
        ),
      ),
    );
  }
}