import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grid_maker_bricks/hex_color.dart';
import 'package:grid_maker_bricks/provider_color.dart';
import 'package:grid_maker_bricks/reorderable_list_of_walls.dart';
import 'package:grid_maker_bricks/walls.dart';
import 'package:provider/provider.dart';

import 'color_list.dart';
import 'grid_items.dart';
import 'list_of_walls.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

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
      home: MyHomePage(title: 'Bricks walls editor'),
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
        Padding(
          padding: const EdgeInsets.only(right: 10,bottom: 5),
          child: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Consumer<BrickColorNumber>(builder: (context, value, child){
              //   return Text('Bricks: ${value.bricksCount}', style: const TextStyle(color: Colors.white70),);}),
              ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const ReorderableListWalls()));},
                  style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),backgroundColor: HexColor(('#2E5902'))),child: const Text('Order', style: TextStyle(color: Colors.white70),)),

              const SizedBox(width: 15,),
              ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const ListWalls()));},
                  style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),backgroundColor: HexColor(('#2E5902'))),child: const Text('List', style: TextStyle(color: Colors.white70),)),
            ],
          ),
        )
      ],
        title: Text(widget.title,style: const TextStyle(color: Colors.white70),),
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
                    SizedBox (height: MediaQuery.of(context).size.height * 0.28,
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: 84,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 11, childAspectRatio: 1.3, mainAxisSpacing: 0.6, crossAxisSpacing: 0.6),
                        itemBuilder: (context, index) => ColorList(index),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20, bottom: 15, top: 30),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(children: [
                      SizedBox(width: 100, height: 40,
                        child: ElevatedButton(onPressed: (){
                          Provider.of<BrickColorNumber>(context,listen: false).bricksCount = 0;
                          Provider.of<BrickColorNumber>(context,listen: false).setBrickColor(0);
                          setState(() {});
                          brickWalls.resetWall();
                        },
                            style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),backgroundColor: HexColor(('#193C40'))),child: const Text('Reset', style: TextStyle(color: Colors.white70),)),
                      )],),
                    Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center ,children: [
                      Consumer<BrickColorNumber>(builder: (context, value, child){
                        return Text('Bricks: ${value.bricksCount}', style: const TextStyle(color: Colors.black54),);}),
                    ],),
                    Column(children: [
                      SizedBox(width: 100, height: 40,
                        child: ElevatedButton(onPressed: (){
                          brickWalls.saveWall();
                          var snackWallSaved = SnackBar(content: const Text('Your wall is saved now.'),backgroundColor: HexColor('#2E5902'), elevation: 10,behavior: SnackBarBehavior.floating,margin: const EdgeInsets.all(5), );
                          ScaffoldMessenger.of(context).showSnackBar(snackWallSaved);
                        },
                            style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),backgroundColor: HexColor(('#193C40'))),child: const Text('Save', style: TextStyle(color: Colors.white70),)),
                      ),
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