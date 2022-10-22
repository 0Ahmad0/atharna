import 'package:flutter/cupertino.dart';

import '../model/models.dart';
import '../view/resources/assets_manager.dart';

class OnBoardingProvider extends ChangeNotifier{
    bool isLastPage = false;
   isLastIndex(int index){
    if(index == 1){
      isLastPage = true;
      notifyListeners();
    }
   else{
     isLastPage =false;
     notifyListeners();
    }
  }

  List<OnBoarding> onBoardingList = [
    OnBoarding(image: ImagesAssets.onBoardingIMG1, text: "Be part of the archaeological documentation journey"),
    OnBoarding(image: ImagesAssets.onBoardingIMG2, text: "Become a part of our cultural preservation movement"),
  ];
}