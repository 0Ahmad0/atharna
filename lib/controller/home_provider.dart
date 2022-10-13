import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier{
  int selectIndex = 0;
  void changeIndex(index) {
    selectIndex = index;
    notifyListeners();
  }
}