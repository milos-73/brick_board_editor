import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grid_maker_bricks/provider_color.dart';
import 'package:provider/provider.dart';

import 'color_buttons.dart';
import 'edit_wall_tiles.dart';
import 'editor_buttons.dart';
import 'hex_color.dart';
import 'list_of_walls.dart';

class ResetEditor extends StatefulWidget {

  final int? wallNumber;

  const ResetEditor({super.key, this.wallNumber});

  @override
  State<ResetEditor> createState() => _ResetEditorState();
}

class _ResetEditorState extends State<ResetEditor> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: HexColor('#ffe7d9'),
      appBar: AppBar(backgroundColor: HexColor('#214001'),
        title: const Text('Edit Wall',style: TextStyle(color: Colors.white70),),
        actions: [
          Consumer<BrickColorNumber>(builder: (context, value, child){
            return Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Bricks: ${value.bricksEditedWallCount}', style: const TextStyle(color: Colors.white70),),
                ],
              ),
            );}),
        ],
        leading: IconButton(onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ListWalls()));} , icon: const FaIcon(FontAwesomeIcons.arrowLeft, color: Colors.white70,size: 15,)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
          child: Column(
            children: [
              SizedBox (height: MediaQuery.of(context).size.height * 0.46,
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: 220,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 11, childAspectRatio: 2),
                    itemBuilder: (context, index) => EditWallTile(wallNumber: widget.wallNumber, index: index, colorNumber: 0,
                    ),
                  )
              ),

              const ColorsGrid(),
              EditButtons(wallNumber: widget.wallNumber)
            ],
          ),
        ),
      ),
    );
  }
}