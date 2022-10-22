

import 'dart:io';
import 'dart:math';

import 'package:atharna/controller/utils/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

import '../model/const.dart';
import '../model/models.dart' as models;
import '../model/utils/local/storage.dart';
import '../view/resources/consts_manager.dart';

class HeritageProvider with ChangeNotifier{
  Map<String,dynamic> cacheUser=Map<String,dynamic>();
  models.Heritage heritage=models.Heritage(id: "", userId: "", firstName: "firstName", lastName: "lastName", photoUrl: "", heritageType: "heritageType", latitude: 0, longitude: 0, date: DateTime.now());
  models.Heritages listHeritages=models.Heritages(heritages: []);
  models.Heritages listHeritagesFavorite=models.Heritages(heritages: []);
  models.Heritages listHeritagesByCity=models.Heritages(heritages: []);
  ///models.HeritageTypes listHeritageTypes=models.HeritageTypes(heritageTypes: []);
  List<String> listHeritageCity=["All"];
  ///Category
  models.Heritages listHeritagesCategory=models.Heritages(heritages: []);
  ///Search
  models.Heritages listHeritagesSearch=models.Heritages(heritages: []);

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
  fetchHeritagesCategory () async {
    var result= await FirebaseFun.fetchHeritagesCategory();
    if(result['status']){
      listHeritages=models.Heritages.fromJson(result['body']);
      /// print("listHeritages: ${listHeritages.heritages.length}");
    }

    return result;
  }
  sortByCategory(int indexCity){
    listHeritagesByCity=models.Heritages(heritages: []);
    if(indexCity==0){
      listHeritagesByCity=listHeritages;
    }else{
      listHeritages.heritages.forEach((element) {
        ///if(element.heritageType.contains(l))
        listHeritagesByCity.heritages.add(element);
      });
    }
  }
  fetchNameUser(context,{required String idUser}) async{
    if(cacheUser.containsKey(idUser)) return cacheUser[idUser];
    var result =await FirebaseFun.fetchUserId(id: idUser,typeUser: AppConstants.collectionUser);
    if(result['status']&&result['body']==null){
      result =await FirebaseFun.fetchUserId(id: idUser,typeUser: AppConstants.collectionCompany);
      if(result['status']&&result['body']==null){
        result =await FirebaseFun.fetchUserId(id: idUser,typeUser: AppConstants.collectionAdmin);
      }
    }
    cacheUser[idUser]=(result['status'])?models.User.fromJson(result['body']).name:"user";
    return cacheUser[idUser];
  }
  addComment(context,String userId,String comment) async {
    models.Heritage tempHeritage=models.Heritage.fromMap(heritage.toJson());
    tempHeritage.listUserComment[userId]=comment;
    var result=await FirebaseFun.addCommentHeritage(heritage: tempHeritage);
    Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    if(result['status']){
      heritage.listUserComment[userId]=comment;
      notifyListeners();
    }
    return result;
  }
  searchHeritagesByCity(String  search,List listSearch){
    List<models.Heritage> tempListSearch=[];
    for(models.Heritage heritageElement in listSearch){
      if('Alaula'.toLowerCase().contains(search.toLowerCase())){
        tempListSearch.add(heritageElement);
      }
    }
    return tempListSearch;
  }
  changeUserFavorite(context,bool isFav,String userId,{required String collection}) async {

    var result;
    if(isFav){
      result=await addUserFavorite(context, userId,collection: collection);
    }else{
      result=await deleteUserFavorite(context, userId,collection: collection);
    }
    return result;
  }
  addUserFavorite(context,String userId,{required String collection}) async {
    models.Heritage tempHeritage=models.Heritage.fromMap(heritage.toJson());
    if(!tempHeritage.listFavoriteUserID.contains(userId))
    tempHeritage.listFavoriteUserID.add(userId);
    var result=await FirebaseFun.addUserFavoriteHeritage(heritage: tempHeritage,collection:collection);
    Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    if(result['status']){
      if(!heritage.listFavoriteUserID.contains(userId)){
    heritage.listFavoriteUserID.add(userId);
      }
      notifyListeners();
    }
    return result;
  }
  deleteUserFavorite(context,String userId,{required String collection}) async {
    models.Heritage tempHeritage=models.Heritage.fromMap(heritage.toJson());
    tempHeritage.listFavoriteUserID.remove(userId);
    var result=await FirebaseFun.deleteUserFavoriteHeritage(heritage: tempHeritage,collection:collection);
    Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    if(result['status']){
      heritage.listFavoriteUserID.remove(userId);
      notifyListeners();
    }
    return result;
  }

  bool checkUserFavorite(String userId)  {
    bool check=false;
    if(heritage.listFavoriteUserID.contains(userId))
      check =true;
    return check;
  }
}