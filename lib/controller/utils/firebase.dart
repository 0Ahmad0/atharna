
import 'dart:io';

//import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:atharna/model/models.dart' as model;
//import 'package:ehtooa/app/view/resources/consts_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../../view/resources/consts_manager.dart';




class FirebaseFun{
  static var rest;
  static  FirebaseAuth auth=FirebaseAuth.instance;
   static signup( {required String email,required String password})  async {
    final result=await auth.createUserWithEmailAndPassword(
      email: email,///"temp@gmail.com",
      password: password,///"123456"
    ).then((onValueSignup))
        .catchError(onError);
    return result;
  }
   static signupPho( {required String email,required String password})  async {
    final result=await auth.createUserWithEmailAndPassword(
      email: email,///"temp@gmail.com",
      password: password,///"123456"
    ).then((onValueSignup))
        .catchError(onError);
    return result;
  }
   static createUser( {required model.User user}) async {
     final result= await FirebaseFirestore.instance.collection(user.typeUser).add(
       user.toJson()
     ).then((value){
       user.id=value.id;
         //print(true);
        // print(value.id);
         return {
           'status':true,
           'message':'Account successfully created',
           'body': {
             'id':value.id
           }
      };
     }).catchError(onError);
     if(result['status'] == true){
       final result2=await updateUser(user: user);
       if(result2['status'] == true){
         return{
         'status':true,
         'message':'Account successfully created',
         'body': user.toJson()
         };
       }else{
         return{
           'status':false,
           'message':"Account Unsuccessfully created"
         };
       }
     }else{
       return result;
     }

   }
   static updateUser( {required model.User user}) async {
      final result =await FirebaseFirestore.instance.collection(user.typeUser).doc(user.id).update(
         user.toJson()
     ).then(onValueUpdateUser)
         .catchError(onError);
      if(result['status']){
        print(true);
       // print(user.id);
        print("id : ${user.id}");
        return {
          'status':true,
          'message':'User successfully update',
          'body': user.toJson()
        };
      }
      return result;
   }
   static updateUserEmail( {required model.User user}) async {
      final result =await auth.currentUser?.updateEmail(
         user.email
     ).then(onValueUpdateUser)
         .catchError(onError);
      if(result!['status']){
        return {
          'status':true,
          'message':'User Email successfully update',
          'body': user.toJson()
        };
      }
      return result;
   }
  static login( {required String email,required String password})  async {
    final result=await auth.signInWithEmailAndPassword(
      email: email,///"temp@gmail.com",
      password: password,///"123456"
    ).then((onValuelogin))
        .catchError(onError);
    return result;
  }
  static logout()  async {
    final result=await FirebaseAuth.instance.signOut()
        .then((onValuelogout))
        .catchError(onError);
    return result;
  }
  static fetchUser( {required String uid,required String typeUser})  async {
    final result=await FirebaseFirestore.instance.collection(typeUser)
        .where('uid',isEqualTo: uid)
        .get()
        .then((onValueFetchUser))
        .catchError(onError);
    return result;
  }
  static fetchUserId( {required String id,required String typeUser})  async {
    final result=await FirebaseFirestore.instance.collection(typeUser)
        .where('id',isEqualTo: id)
        .get()
        .then((onValueFetchUserId))
        .catchError(onError);
  //  print("${id} ${result}");
    return result;
  }

  static fetchUsers()  async {
    final result=await FirebaseFirestore.instance.collection(AppConstants.collectionUser)
        .get()
        .then((onValueFetchUsers))
        .catchError(onError);
    return result;
  }


  static createHeritage( {required model.Heritage heritage}) async {
    final result= await FirebaseFirestore.instance.collection(AppConstants.collectionHeritage).add(
        heritage.toJson()
    ).then((value){
      heritage.id=value.id;
      return {
        'status':true,
        'message':'Heritage successfully created',
        'body': {
          'id':value.id
        }
      };
    }).catchError(onError);
    return result;
  }
  static updateHeritage( {required model.Heritage heritage}) async {
    final result =await FirebaseFirestore.instance.collection(AppConstants.collectionHeritage)
        .doc(heritage.id).update(
        heritage.toJson()
    ).then(onValueUpdateHeritage)
        .catchError(onError);
    return result;
  }
  static deleteHeritage( {required model.Heritage heritage}) async {
    final result =await FirebaseFirestore.instance.collection(AppConstants.collectionHeritage)
        .doc(heritage.id).delete()
        .then(onValueDeleteHeritage)
        .catchError(onError);
    return result;
  }
  static fetchHeritages()  async {
    final result=await FirebaseFirestore.instance.collection(AppConstants.collectionHeritage)
        .get()
        .then((onValueFetchHeritages))
        .catchError(onError);
    return result;
  }


  static createHeritageType( {required String heritageType}) async {
    final result= await FirebaseFirestore.instance.collection(AppConstants.collectionHeritageTypes).add(
        {
          "name":heritageType
        }).then((value){
      return {
        'status':true,
        'message':'HeritageTypes successfully created',
        'body': {
          'id':value.id
        }
      };
    }).catchError(onError);
    return result;
  }
  static deleteHeritageTypes( ) async {
    FirebaseFirestore.instance.collection(AppConstants.collectionHeritageTypes).snapshots().forEach((querySnapshot) {
      for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
        docSnapshot.reference.delete();
      }
    });
  }
  static fetchHeritageTypes()  async {
    final result=await FirebaseFirestore.instance.collection(AppConstants.collectionHeritageTypes)
        .get()
        .then((onValueFetchHeritageTypes))
        .catchError(onError);
    return result;
  }


   static Future<Map<String,dynamic>>  onError(error) async {
    print(false);
    print(error);
    return {
      'status':false,
      'message':error,
      //'body':""
    };
  }
  static Future<Map<String,dynamic>>  errorUser(String messageError) async {
    print(false);
    print(messageError);
    return {
      'status':false,
      'message':messageError,
      //'body':""
    };
  }

  static Future<Map<String,dynamic>> onValueSignup(value) async{
    print(true);
    print("uid : ${value.user?.uid}");
    return {
      'status':true,
      'message':'Account successfully created',
      'body':{
        'uid':value.user?.uid
      }
    };
  }
  static Future<Map<String,dynamic>> onValueUpdateUser(value) async{
    return {
      'status':true,
      'message':'Account successfully update',
    //  'body': user.toJson()
    };
  }
  static Future<Map<String,dynamic>> onValuelogin(value) async{
    //print(true);
   // print(value.user.uid);

    return {
      'status':true,
      'message':'Account successfully logged',
      'body':{
        'uid':value.user.uid}
    };
  }
  static Future<Map<String,dynamic>> onValuelogout(value) async{
     print(true);
     print("logout");
    return {
      'status':true,
      'message':'Account successfully logout',
      'body':{}
    };
  }
  static Future<Map<String,dynamic>> onValueFetchUser(value) async{
    print(true);
    print(await (value.docs.length>0)?value.docs[0]['uid']:null);
    print("user : ${(value.docs.length>0)?model.User.fromJson(value.docs[0]).toJson():null}");
    return {
      'status':true,
      'message':'Account successfully logged',
      'body':(value.docs.length>0)?model.User.fromJson(value.docs[0]).toJson():null
    };
  }
  static Future<Map<String,dynamic>> onValueFetchUserId(value) async{
    //print(true);
    //print(await (value.docs.length>0)?value.docs[0]['uid']:null);
   // print("user : ${(value.docs.length>0)?model.User.fromJson(value.docs[0]).toJson():null}");
    return {
      'status':true,
      'message':'Account successfully logged',
      'body':(value.docs.length>0)?model.User.fromJson(value.docs[0]).toJson():null
    };
  }
  static Future<Map<String,dynamic>> onValueFetchUsers(value) async{
    print(true);
    print("Users count : ${value.docs.length}");

    return {
      'status':true,
      'message':'Sessions successfully fetch',
      'body':value.docs
    };
  }
  static Future<Map<String,dynamic>> onValueUpdateHeritage(value) async{
    return {
      'status':true,
      'message':'Heritage successfully update',
       // 'body': value.data.toJson()
    };
  }
  static Future<Map<String,dynamic>> onValueDeleteHeritage(value) async{
    return {
      'status':true,
      'message':'Heritage successfully delete',
       // 'body': value.data.toJson()
    };
  }
  static Future<Map<String,dynamic>> onValueFetchHeritages(value) async{
   // print(true);
    print("Heritages count : ${value.docs.length}");

    return {
      'status':true,
      'message':'Heritages successfully fetch',
      'body':value.docs
    };
  }

  static Future<Map<String,dynamic>> onValueDeleteHeritageTypes(value) async{
    return {
      'status':true,
      'message':'HeritageType successfully delete',
      // 'body': value.data.toJson()
    };
  }
  static Future<Map<String,dynamic>> onValueFetchHeritageTypes(value) async{
    // print(true);
    print("HeritageTypes count : ${value.docs.length}");

    return {
      'status':true,
      'message':'HeritageTypes successfully fetch',
      'body':value.docs
    };
  }

  static String findTextToast(String text){
    return text;
     if(text.contains("Password should be at least 6 characters")){
      // return tr(LocaleKeys.toast_short_password);
     }else if(text.contains("The email address is already in use by another account")){
      // return tr(LocaleKeys.toast_email_already_use);
     }
     else if(text.contains("Account Unsuccessfully created")){
      // return tr(LocaleKeys.toast_Unsuccessfully_created);
     }
     else if(text.contains("Account successfully created")){
       // return tr(LocaleKeys.toast_successfully_created);
     }
     else if(text.contains("The password is invalid or the user does not have a password")){
       // return tr(LocaleKeys.toast_password_invalid);
     }
     else if(text.contains("There is no user record corresponding to this identifier")){
       // return tr(LocaleKeys.toast_email_invalid);
     }
     else if(text.contains("Account successfully logged")){
        // return tr(LocaleKeys.toast_successfully_logged);
     }
     else if(text.contains("A network error")){
       // return tr(LocaleKeys.toast_network_error);
     }
     else if(text.contains("An internal error has occurred")){
       //return tr(LocaleKeys.toast_network_error);
     }else if(text.contains("field does not exist within the DocumentSnapshotPlatform")){
       //return tr(LocaleKeys.toast_Bad_data_fetch);
     }else if(text.contains("Account successfully logged")){
       //return tr(LocaleKeys.toast);
     }


     return text;
  }
  static int compareDateWithDateNowToDay({required DateTime dateTime}){
     int year=dateTime.year-DateTime.now().year;
     int month=dateTime.year-DateTime.now().month;
     int day=dateTime.year-DateTime.now().day;
     return (year*365+
            month*30+
            day);
  }

  static Future uploadImage({required XFile image, required String folder}) async {
    try {
      String path = basename(image.path);
      print(image.path);
      File file =File(image.path);

//FirebaseStorage storage = FirebaseStorage.instance.ref().child(path);
      Reference storage = FirebaseStorage.instance.ref().child("${folder}/${path}");
      UploadTask storageUploadTask = storage.putFile(file);
      TaskSnapshot taskSnapshot = await storageUploadTask;
      String url = await taskSnapshot.ref.getDownloadURL();
      return url;
    } catch (ex) {
      //Const.TOAST( context,textToast:FirebaseFun.findTextToast("Please, upload the image"));
    }
  }
}