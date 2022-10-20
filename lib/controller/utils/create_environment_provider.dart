import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';

import '../../model/const.dart';
import '../../model/models.dart' as models;
import '../../model/models.dart';

import '../../view/resources/consts_manager.dart';
import 'firebase.dart';

class CreateEnvironmentProvider with ChangeNotifier{
  models.HeritageTypes heritageTypes=models.HeritageTypes(heritageTypes: []);
  initHeritageTypes(){
    heritageTypes.heritageTypes=[
      "Urban heritage",
      "Handicrafts",
      "Activities"
    ];
  }
   disposeHeritageTypes() async {
    await  FirebaseFun.deleteHeritageTypes();
  }
  createHeritageTypes(context) async {
    await initHeritageTypes();
  //  await disposeHeritageTypes();
    var result;
    for(String heritageType in heritageTypes.heritageTypes ) {
      result =await FirebaseFun.createHeritageType(heritageType: heritageType);
    }

    print(result);
    Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }
  onError(error){
    print(false);
    print(error);
    return {
      'status':false,
      'message':error,
      //'body':""
    };
  }
}
