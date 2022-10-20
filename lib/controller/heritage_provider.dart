

import 'dart:io';
import 'dart:math';

import 'package:atharna/controller/utils/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../model/const.dart';
import '../model/models.dart' as models;
import '../model/utils/local/storage.dart';

class HeritageProvider with ChangeNotifier{
  models.Heritage heritage=models.Heritage(id: "", userId: "", firstName: "firstName", lastName: "lastName", photoUrl: "", heritageType: "heritageType", latitude: 0, longitude: 0, date: DateTime.now());
  models.Heritages listHeritages=models.Heritages(heritages: []);
  models.Heritages listHeritagesByCategory=models.Heritages(heritages: []);
  //models.Heritages listHeritages=models.Heritages(heritages: []);
  models.HeritageTypes listHeritageTypes=models.HeritageTypes(heritageTypes: []);
  List<String> listHeritageCategories=["All"];

  fetchHeritages () async {
    var result= await FirebaseFun.fetchHeritages();
    if(result['status']){
      listHeritages=models.Heritages.fromJson(result['body']);
     /// print("listHeritages: ${listHeritages.heritages.length}");
    }
    sortByCategory(String category){

    }

    return result;
  }
  fetchHeritageTypes () async {
    var result= await FirebaseFun.fetchHeritageTypes();
    if(result['status']){
      listHeritageTypes=models.HeritageTypes.fromJson(result['body']);
    ///  print("listHeritageTypes: ${listHeritageTypes.heritageTypes.length}");
    }

    return result;
  }
  sortByCategory(int indexCategory){
    listHeritagesByCategory=models.Heritages(heritages: []);
    if(indexCategory==0){
      listHeritagesByCategory=listHeritages;
    }else{
      listHeritages.heritages.forEach((element) {
        ///if(element.heritageType.contains(l))
        listHeritagesByCategory.heritages.add(element);
      });
    }
  }
}