import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'color_buttons.dart';
import 'edit_wall_tiles.dart';
import 'editor_buttons.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Wall'),
        leading: IconButton(onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ListWalls()));} , icon: const FaIcon(FontAwesomeIcons.arrowLeft)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
          child: Column(
            children: [
                SizedBox (height: MediaQuery.of(context).size.height * 0.5,
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



