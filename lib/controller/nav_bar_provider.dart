import 'package:flutter/cupertino.dart';

class NavBarProvider extends ChangeNotifier{
  int currentIndex = 0;
  void changeIndex(index) {
    currentIndex = index;
    notifyListeners();
  }
}