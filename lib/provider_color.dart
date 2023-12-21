import 'package:flutter/foundation.dart';

class BrickColorNumber extends ChangeNotifier {
  int? index = 0;
  int bricksCount = 0;
  int breakingBricks = 0;
  int? bricksEditedWallCount;

  void setBrickColor(int? value,) {
    index = value;

    //print('PROVIDER FARBA: ${value}');

    notifyListeners();
  }

  void countBricks(int value,) {
    bricksCount = value;

    notifyListeners();
  }

  void countBreakingBricks(int value,) {
    breakingBricks = value;

    notifyListeners();
  }

  void countBricksOnEditedWall(int value,) {
    bricksEditedWallCount = value;

    notifyListeners();
  }

}