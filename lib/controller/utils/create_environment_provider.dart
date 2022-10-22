import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';

import '../../model/const.dart';
import '../../model/models.dart' as models;
import '../../model/models.dart';

import '../../view/resources/consts_manager.dart';
import 'firebase.dart';

class CreateEnvironmentProvider with ChangeNotifier{
  models.HeritageTypes heritageTypes=models.HeritageTypes(heritageTypes: [
  ]);
  models.Heritages listHeritagesCategory=models.Heritages(heritages: [
    models.Heritage(id: ""
        , photoUrl: "https://firebasestorage.googleapis.com/v0/b/atharna-8f15b.appspot.com/o/HeritageCategory%2Fa.jpg?alt=media&token=ea3915e6-99fa-4164-a690-d63877995982"
        , date: DateTime.now(),
      title: 'AlUla Dates Festival',
    description: 'The AlUla Dates Festival celebrates the rich cultural traditions of the local community and the goodness generated from the fresh water and fertile soils of the oasis farms. Working together with the Royal Commission for AlUla our farmers are creating a prosperous future for the upcoming generations as custodians of the oasis farming landscape.'
    ,location: 'https://goo.gl/maps/iv4foBwvquNgZogu8',
    phone: '+966 56 137 3919',
    category: 'ACTIVITIES',
    fromDate: DateTime.now(),
    toDate: DateTime.now()),
    models.Heritage(id: ""
        , photoUrl: "https://firebasestorage.googleapis.com/v0/b/atharna-8f15b.appspot.com/o/HeritageCategory%2Faa.jpg?alt=media&token=0c6f134a-c042-4ca6-9b40-f4e2ae21ddd7"
        , date: DateTime.now(),
        title: 'Alaula On Wheels',
        description: 'This immersive roller-skating event brings the free-flowing nature of roller skating to AlUla, a cultural movement that has recently had a resurgence in popularity across the world.\n'
       ' Grab some skates and show us your moves! Open 7:00 pm – Midnight, AlUla on Wheels is suitable for everyone - from beginners to pro skate fans to families, groups of friends and partygoers.\n'
        'Not a skater? Not a problem! It’s free to come hang out and catch the vibes with friends and family. Food kiosks will feature a selection of popular and delectable retro eats.'

        ,location: 'https://goo.gl/maps/iv4foBwvquNgZogu8',
        phone: '+966 56 137 3919',
        category: 'ACTIVITIES',
    fromDate: DateTime.now(),
    toDate: DateTime.now())
  ]);
  List<models.User> listAdmin=[
    models.User(id: "",
        uid: "",
        name: "Admin",
        email: "admin@gmail.com",
        phoneNumber: "+999999999999",
        password: "123456",
        typeUser: AppConstants.collectionAdmin,
        photoUrl: ""),
  ];
  createAdmin(context,{int indexListAdmin=0}) async {
    if(listAdmin.length<1){
      return FirebaseFun.errorUser("a user is emty");
    }
    models.User user=listAdmin[indexListAdmin];
    var result =await FirebaseFun.signup(email: user.email, password: user.password);
    if(result['status']){
        user.uid= result['body']['uid'];
        result = await FirebaseFun.createUser(user: user);
    }
    print(result);
    Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }
  createAdmins(context) async {
    var result;
    if(listAdmin.length<1){
      return FirebaseFun.errorUser("a list admin is empty");
    }
    for(int i=0;i<listAdmin.length;i++){
      result =await createAdmin(context,indexListAdmin: i);
    }
    
    return result;
  }
  createCategory(context) async {
    var result;
    if(listHeritagesCategory.heritages.length<1){
      return FirebaseFun.errorUser("a list category is empty");
    }
    for(int i=0;i<listHeritagesCategory.heritages.length;i++){
      result =await FirebaseFun.createHeritageCategory(heritage: listHeritagesCategory.heritages[i]);
    }

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
