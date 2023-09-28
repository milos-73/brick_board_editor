import 'package:flutter/foundation.dart';

class BrickColorNumber extends ChangeNotifier {
  int? index = 0;

  void setBrickColor(int? value,) {
    index = value;

    notifyListeners();
  }
}