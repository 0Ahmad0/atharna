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
  String? userId;
  String? firstName;
  String? lastName;
  String photoUrl;
  String? heritageType;
  String? phone;
  String? statusHeritage;
  String? city;
  double? latitude;
  double? rating;
  double? longitude;
  String description;
  DateTime date;
  DateTime? toDate=DateTime.now();
  DateTime? fromDate=DateTime.now();
 List<String> listFavoriteUserID;
  Map<String,dynamic>? listUserComment;
  Map<String,dynamic>? listUserRating;
  String? title;
  String? location;
  String category;

  Heritage(
      {required this.id,
       this.index=0,
       this.userId,
       this.title,
       this.location,
       this.category="",
         this.firstName,
         this.lastName,
        required this.photoUrl,
         this.heritageType,
         this.city,
         this.latitude,
         this.longitude,
         this.rating=0,
         this.listFavoriteUserID=const[],
         this.listUserComment=const{},
         this.listUserRating=const{},
        required this.date,
         this.fromDate,
         this.phone,
         this.toDate,
        this.description="",
        this.statusHeritage,});
  factory Heritage.fromJson( json){
    var data=json.data();
    List<String> tempListFavoriteUserID = [];
    for(String user in json["listFavoriteUserID"]){
      tempListFavoriteUserID.add(user);
    }
    return Heritage(id: data['id'],
        userId: data["userId"],
        firstName: data["firstName"],
        lastName: data["lastName"],
        photoUrl: data["photoUrl"],
      phone: data["phone"],
        heritageType: data["heritageType"],
        latitude: data["latitude"],
        longitude: data["longitude"],
      city: data["city"],
        date: data["date"].toDate(),
     // rating: data["rating"],
        listUserComment: data["listUserComment"],
      listUserRating: data["listUserRating"],
        statusHeritage: data["statusHeritage"],
        listFavoriteUserID: tempListFavoriteUserID,
        description: (data["description"]!=null)?data["description"]:"",
        title: (data["title"]!=null)?data["title"]:"",
    category: (data["category"]!=null)?data["category"]:"",
      location: (data["location"]!=null)?data["location"]:"",
      toDate: (data["toDate"]!=null)?data["toDate"].toDate():null,
      fromDate: (data["fromDate"]!=null)?data["fromDate"].toDate():null,

    );
  }
  factory Heritage.fromMap( json){
    //var data=json.data();
    List<String> tempListFavoriteUserID = [];
    for(String user in json["listFavoriteUserID"]){
      tempListFavoriteUserID.add(user);
    }
    return Heritage(id: json['id'],
      userId: json["userId"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      photoUrl: json["photoUrl"],
      phone: json["phone"],
      heritageType: json["heritageType"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      date: json["date"],
      city: json["city"],
      rating: json["rating"],
      listUserComment: json["listUserComment"],
      listUserRating: json["listUserRating"],
      statusHeritage: json["statusHeritage"],
      listFavoriteUserID: tempListFavoriteUserID,
      description: (json["description"]!=null)?json["description"]:"",
      title: (json["title"]!=null)?json["title"]:"",
      category: (json["category"]!=null)?json["category"]:"",
      location: (json["location"]!=null)?json["location"]:"",
      toDate: json["toDate"],
      fromDate: json["fromDate"],

    );
  }
  Map<String,dynamic> toJson()=>{
    'id':id,
    'userId':userId,
    'firstName':firstName,
    'lastName':lastName,
    'photoUrl':photoUrl,
    'phone':phone,
    'heritageType':heritageType,
    'latitude':latitude,
    'longitude':longitude,
    'photoUrl':photoUrl,
    'city':city,
    'rating':rating,
    'listUserComment':listUserComment,
    'listUserRating':listUserRating,
    'listFavoriteUserID':listFavoriteUserID,
    'description':description,
    'statusHeritage':statusHeritage,
    'date':date,
    'title':title,
    'rating':rating,
    'location':location,
    'category':category,
    'toDate':toDate,
    'fromDate':fromDate,
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

///StatusHeritage
enum StatusHeritage{
  spoon,///معلقة
  accept,///مقبولة
  rejected,///مرفوضة
}
/*

flutter pub run easy_localization:generate -S "assets/translations/" -O "lib/translations"
flutter pub run easy_localization:generate -S "assets/translations/" -O "lib/translations" -o "locale_keys.g.dart" -f keys
flutter build apk --split-per-abi
temp@gmail.com   123456
a@gmail.com   123456
 */
