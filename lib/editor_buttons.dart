import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grid_maker_bricks/hex_color.dart';
import 'package:grid_maker_bricks/provider_color.dart';
import 'package:grid_maker_bricks/reorderable_list_of_walls.dart';
import 'package:grid_maker_bricks/reorderable_wall_list_item.dart';
import 'package:grid_maker_bricks/reset_editor.dart';
import 'package:grid_maker_bricks/walls.dart';
import 'package:provider/provider.dart';

import 'edit_wall.dart';
import 'list_of_walls.dart';

class EditButtons extends StatelessWidget {
  final int? wallNumber;

  const EditButtons({
    super.key,
    this.wallNumber,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 10, bottom: 15, top: 10),
      child: SizedBox(width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 130, height: 40,
                  child: ElevatedButton(onPressed: (){
                    brickWalls.saveEditedWallAsNew();
                    var snackWallSaved = SnackBar(content: const Text('Your wall is now saved as NEW wall.'),backgroundColor: HexColor('#2E5902'), elevation: 10,behavior: SnackBarBehavior.floating,margin: const EdgeInsets.all(5), );
                    ScaffoldMessenger.of(context).showSnackBar(snackWallSaved);},style: ElevatedButton.styleFrom(
                    backgroundColor: HexColor('#193C40'),
                  ), child: const Text('Save as new',style: TextStyle(color: Colors.white70),),),
                ),

                SizedBox(width: 130, height: 40,
                  child: ElevatedButton(onPressed: (){
                    brickWalls.saveEditedWall(wallNumber!);
                    var snackWallSaved = SnackBar(content: const Text('Your wall is saved now.'),backgroundColor: HexColor('#2E5902'), elevation: 10,behavior: SnackBarBehavior.floating,margin: const EdgeInsets.all(5), );
                    ScaffoldMessenger.of(context).showSnackBar(snackWallSaved);
                  },style: ElevatedButton.styleFrom(
                    backgroundColor: HexColor('#193C40'),
                  ), child: const Text('Save',style: TextStyle(color: Colors.white70),),),
                )
              ],
            ),
            const SizedBox(height: 10,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 130, height: 40,
                  child: ElevatedButton(onPressed: (){

                    BrickWalls().resetEditedWall();
                    Provider.of<BrickColorNumber>(context,listen: false).bricksEditedWallCount = 0;
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ResetEditor(wallNumber: wallNumber)));
                  },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor('#A62B1F'),
                    ), child: const Text('Reset',style: TextStyle(color: Colors.white70),),),
                ),
                SizedBox(width: 130, height: 40,
                  child: ElevatedButton(onPressed: (){

                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ReorderableListWalls()));
                  },style: ElevatedButton.styleFrom(
                    backgroundColor: HexColor('#D96941'),
                  ), child: const Text('Cancel',style: TextStyle(color: Colors.white70),),),
                ),
              ],
            ),
          ],

        ),
      ),
    );
  }
}