import 'dart:convert';

import 'package:flutter/material.dart';

import 'models.dart';

class Advance {
  static bool theme = false;
  static bool language = false;
  static bool isRegisterKEY = false;
  static bool isLogined = false;
  static String token = "";
  static String uid = "";
  static String avatarImage = "";
}
//user
class User {
  String id;
  String uid;
  String name;
  String photoUrl;
  String email;
  String phoneNumber;
  String password;
  String typeUser;
  String description;
  User(
      {required this.id,
      required this.uid,
      required this.name,
      required this.email,
      required this.phoneNumber,
      required this.password,
        required this.typeUser,
        required this.photoUrl,
        this.description="",});
  factory User.fromJson( json){

    return User(id: json['id'],
                uid: json["uid"],
                name: json["name"],
                email: json["email"],
                phoneNumber: json["phoneNumber"],
                password: json["password"],
                typeUser: json["typeUser"],
              photoUrl: json["photoUrl"],
               description: (json["description"]!=null)?json["description"]:"");
  }
  Map<String,dynamic> toJson()=>{
    'id':id,
    'uid':uid,
    'name':name,
    'email':email,
    'phoneNumber':phoneNumber,
    'password':password,
    'typeUser':typeUser,
    'photoUrl':photoUrl,
    'description':description,
  };
}
//Users
class Users {
  List<User> users;
  //DateTime date;

  Users({
    required this.users
  });
  factory Users.fromJson( json){
    List<User> tempUsers = [];
    for(int i=0;i<json.length;i++){
      User tempUser=User.fromJson(json[i]);
      tempUser.id=json[i].id;
      tempUsers.add(tempUser);
    }
    return Users(
        users: tempUsers
    );
  }
  Map<String,dynamic> toJson(){
    List<Map<String,dynamic>> tempUsers = [];
    for(User user in users){
      tempUsers.add(user.toJson());
    }
    return {
      'users':tempUsers,
    };
  }
}

//Heritage
class Heritage {
  String id;
  int index;
  String userId;
  String firstName;
  String lastName;
  String photoUrl;
  String heritageType;
  double? latitude;
  double? longitude;
  String description;
  DateTime date;
 List<String> listFavoriteUserID;
  Map<String,dynamic> listUserComment;
  Heritage(
      {required this.id,
       this.index=0,
      required this.userId,
        required this.firstName,
        required this.lastName,
        required this.photoUrl,
        required this.heritageType,
        required this.latitude,
        required this.longitude,
         this.listFavoriteUserID=const[],
         this.listUserComment=const{},
        required this.date,
        this.description="",});
  factory Heritage.fromJson( json){
    var data=json.data();
    List<String> tempListFavoriteUserID = [];
    for(String user in data["listFavoriteUserID"]){
      tempListFavoriteUserID.add(user);
    }
    return Heritage(id: data['id'],
        userId: data["userId"],
        firstName: data["firstName"],
        lastName: data["lastName"],
        photoUrl: data["photoUrl"],
        heritageType: data["heritageType"],
        latitude: data["latitude"],
        longitude: data["longitude"],
        date: data["date"].toDate(),
        listUserComment: data["listUserComment"],
        listFavoriteUserID: tempListFavoriteUserID,
        description: (data["description"]!=null)?data["description"]:"");
  }
  Map<String,dynamic> toJson()=>{
    'id':id,
    'userId':userId,
    'firstName':firstName,
    'lastName':lastName,
    'photoUrl':photoUrl,
    'heritageType':heritageType,
    'latitude':latitude,
    'longitude':longitude,
    'photoUrl':photoUrl,
    'listUserComment':listUserComment,
    'listFavoriteUserID':listFavoriteUserID,
    'description':description,
    'date':date,
  };
}
//Heritages
class Heritages {
  List<Heritage> heritages;

  Heritages({
    required this.heritages
  });
  factory Heritages.fromJson( json){
    List<Heritage> tempHeritages = [];
    for(int i=0;i<json.length;i++){
      Heritage tempHeritage=Heritage.fromJson(json[i]);
      tempHeritage.id=json[i].id;
      tempHeritage.index=i;
      tempHeritages.add(tempHeritage);
    }
    return Heritages(
        heritages: tempHeritages
    );
  }
  Map<String,dynamic> toJson(){
    List<Map<String,dynamic>> tempHeritages = [];
    for(Heritage heritage in heritages){
      tempHeritages.add(heritage.toJson());
    }
    return {
      'heritages':tempHeritages,
    };
  }
}

//Heritages
class HeritageTypes {
  List<String> heritageTypes;

  HeritageTypes({
    required this.heritageTypes
  });
  factory HeritageTypes.fromJson(json){
    List<String> tempHeritageTypes = [];
    for(int i=0;i<json.length;i++){
      tempHeritageTypes.add(json[i]['name']);
    }
    return HeritageTypes(
        heritageTypes: tempHeritageTypes
    );
  }
  Map<String,dynamic> toJson(){
    return {
      'heritageTypes':heritageTypes,
    };
  }
}

class OnBoarding {
  String image;
  String text;

  OnBoarding({required this.image,required this.text});

}

class Categories{
  String name;
  String image;
  Categories({required this.image,required this.name});
}

/*

flutter pub run easy_localization:generate -S "assets/translations/" -O "lib/translations"
flutter pub run easy_localization:generate -S "assets/translations/" -O "lib/translations" -o "locale_keys.g.dart" -f keys
flutter build apk --split-per-abi
temp@gmail.com   123456
 */
