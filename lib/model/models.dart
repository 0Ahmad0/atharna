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

//user
class Heritage {
  String id;
  String userId;
  String firstName;
  String lastName;
  String photoUrl;
  String heritageType;
  double latitude;
  double longitude;
  String description;
 List<String> listFavoriteUserID;
  Map<String,dynamic> listUserComment;
  Heritage(
      {required this.id,
      required this.userId,
        required this.firstName,
        required this.lastName,
        required this.photoUrl,
        required this.heritageType,
        required this.latitude,
        required this.longitude,
         this.listFavoriteUserID=const[],
         this.listUserComment=const{},
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
    'photoUrl':photoUrl,
    'listUserComment':listUserComment,
    'listFavoriteUserID':listFavoriteUserID,
    'description':description,
  };
}



/*

flutter pub run easy_localization:generate -S "assets/translations/" -O "lib/translations"
flutter pub run easy_localization:generate -S "assets/translations/" -O "lib/translations" -o "locale_keys.g.dart" -f keys
flutter build apk --split-per-abi
temp@gmail.com   123456
 */
