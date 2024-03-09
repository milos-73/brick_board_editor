import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grid_maker_bricks/hex_color.dart';
import 'package:grid_maker_bricks/provider_color.dart';
import 'package:grid_maker_bricks/reorderable_list_of_walls.dart';
import 'package:grid_maker_bricks/walls.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'color_numbers.dart';
import 'created_wall_builder.dart';
import 'edit_wall.dart';


class WallScreenshot extends StatefulWidget {

  final int? wallNumber;

  const WallScreenshot({super.key, this.wallNumber});

  @override
  State<WallScreenshot> createState() => _WallScreenshotState();
}

List? wall;
String? sharedWall;

late Uint8List _imageFile;
ScreenshotController screenshotController = ScreenshotController();

class _WallScreenshotState extends State<WallScreenshot> {

  getWallData(int? wallNumber) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    wall = jsonDecode(prefs.getString('wall${widget.wallNumber}') ?? '');

    return wall;
  }

  Future<dynamic> showCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text("Captured widget screenshot"),
        ),
        body: Center(child: Image.memory(capturedImage)),
      ),
    );}



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Screenshot(
              controller: screenshotController,
              child: FutureBuilder(
                  future: getWallData(widget.wallNumber),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      
                    if (snapshot.hasData) {
      
                      return SizedBox(width: 500, height: 358,
                        child: Material(
                          child: GridView.builder(padding: EdgeInsets.zero,
                            //physics: const NeverScrollableScrollPhysics(),
                            //shrinkWrap: true,
                            itemCount: 220,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 11, childAspectRatio: 2),
                            itemBuilder: (context, index) => CreatedWallBuilder(index, snapshot.data),
                          ),
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                       ),
            ),
          ),
      
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 15,right: 15),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 170, height: 40,
                  child: ElevatedButton(onPressed: () async {
      
                                       screenshotController.capture(delay: const Duration(milliseconds: 20));
                    final directory = (await getApplicationDocumentsDirectory()).path;
                    var fileName =  '${widget.wallNumber}.png';
                    var path = directory;
                    await screenshotController.captureAndSave(directory,fileName: fileName,pixelRatio: 1.5).then((value) => ((Uint8List image) {
                      setState(() {
                        _imageFile = image;
                      });
                    }));

                    var snackWallSaved = SnackBar(content: const Text('Your screenshot is saved now.'),backgroundColor: HexColor('#2E5902'), elevation: 10,behavior: SnackBarBehavior.floating,margin: const EdgeInsets.all(5), );
                    if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(snackWallSaved);

                    if (context.mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ReorderableListWalls()));
                  },
                      style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),backgroundColor: HexColor(('#193C40'))),child: const Text('Make screenshot', style: TextStyle(color: Colors.white70),)),
                ),
      
      SizedBox(width: 100, height: 40,
      child: ElevatedButton(onPressed: () async {Navigator.pop(context);}, style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),backgroundColor: HexColor(('#193C40'))),
               child: const Text('Cancel', style: TextStyle(color: Colors.white70),)),)],
            ),
          ),
      
        ],
      ),
    );
  }
}