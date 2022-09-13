import 'package:flutter/cupertino.dart';

class TeamController with ChangeNotifier {
  List _players = [];
  List _tatics = [];

  TeamController() {
    (setTatic(0));
  }

  String getPosition(int index) {
    return _tatics.elementAt(index);
  }

  void setTatic(int tatic) {
    _tatics.clear();
    switch (tatic) {
      case 0:
        _tatics.add("Ala");
        _tatics.add("Ala");
        _tatics.add("Ala");
        _tatics.add("Armador");
        _tatics.add("Pivô");
        break;
      case 1:
        _tatics.add("Ala");
        _tatics.add("Ala");
        _tatics.add("Armador");
        _tatics.add("Armador");
        _tatics.add("Pivô");
        break;
      case 2:
        _tatics.add("Ala");
        _tatics.add("Ala");
        _tatics.add("Armador");
        _tatics.add("Pivô");
        _tatics.add("Pivô");
        break;
      case 3:
        _tatics.add("Ala");
        _tatics.add("Armador");
        _tatics.add("Armador");
        _tatics.add("Armador");
        _tatics.add("Pivô");
        break;
      case 4:
        _tatics.add("Ala");
        _tatics.add("Armador");
        _tatics.add("Armador");
        _tatics.add("Pivô");
        _tatics.add("Pivô");
        break;
      case 5:
        _tatics.add("Ala");
        _tatics.add("Armador");
        _tatics.add("Pivô");
        _tatics.add("Pivô");
        _tatics.add("Pivô");
        break;
    }
    notifyListeners();
  }

  int taticSize() {
    return _tatics.length;
  }
}
