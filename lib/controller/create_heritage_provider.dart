

import 'dart:io';

import 'package:atharna/controller/utils/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../model/const.dart';
import '../model/models.dart' as models;
import '../model/utils/local/storage.dart';
class CreateHeritageProvider with ChangeNotifier{
  double  rateComplete=0;
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final heritageType = TextEditingController(text: '');
  final photoUrl = TextEditingController(text: '');
  final latitude = TextEditingController(text: '');
  final longitude = TextEditingController(text: '');

  models.Heritage heritage=models.Heritage(id: "", userId: "", firstName: "firstName", lastName: "lastName", photoUrl: "", heritageType: "heritageType", latitude: 0, longitude: 0, date: DateTime.now());
  createHeritage(context,{required String userId}) async{
    heritage=models.Heritage(id: "",
        userId: userId,
        firstName: firstName.text, lastName: lastName.text,
        photoUrl: photoUrl.text,
        heritageType: heritageType.text,
        latitude: double.parse(latitude.text),  longitude: double.parse(longitude.text),
        date: DateTime.now());

    // return session.toJson();
    var result =await FirebaseFun.createHeritage(heritage: heritage);
    print(result);
    Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }
  @override
  void dispose() {
    // TODO: implement dispose
    rateComplete=0;
     firstName.clear() ;
     lastName.clear()  ;
     heritageType.clear() ;
     photoUrl.clear()  ;
     latitude.clear()  ;
     longitude.clear()  ;
    super.dispose();
  }
}