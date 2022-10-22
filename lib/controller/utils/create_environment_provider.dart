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
        fromDate: DateTime(2022,9,30,6),
        toDate: DateTime(2022,10,22,9),
      latitude: 26.67905447989585,
      longitude: 37.98678816441776
    ),
    models.Heritage(id: ""
        , photoUrl: "https://firebasestorage.googleapis.com/v0/b/atharna-8f15b.appspot.com/o/HeritageCategory%2Faaa.jpg?alt=media&token=4f2d5c9b-5312-4c38-bdc0-3407d0b96aa2"
        , date: DateTime.now(),
        title: 'ALMANSHIYAH PLAZA',
        description: 'Opening 23 October, AlUla\'s newest gathering place, AlManshiyah Plaza, is a lively community with restaurants and cafes, playgrounds and communal areas, and live music on Fridays. After the careful restoration of the ancient Hijaz Railway, AlManshiyah Plaza is a breath of new life in this historic AlUla neighbourhood.'
        ,location: 'https://goo.gl/maps/yXJapqK5MdWJgfav8',
        phone: '+966 56 137 3919',
        category: 'ACTIVITIES',
        fromDate: DateTime(2022,10,6,19),
        toDate: DateTime(2022,10,22,23),
        latitude: 26.67905447989585,
        longitude: 37.98678816441776),
    models.Heritage(id: ""
        , photoUrl: "https://firebasestorage.googleapis.com/v0/b/atharna-8f15b.appspot.com/o/HeritageCategory%2Fa.jpg?alt=media&token=ea3915e6-99fa-4164-a690-d63877995982"
        , date: DateTime.now(),
        title: 'AlUla Dates Festival',
        description: 'The AlUla Dates Festival celebrates the rich cultural traditions of the local community and the goodness generated from the fresh water and fertile soils of the oasis farms. Working together with the Royal Commission for AlUla our farmers are creating a prosperous future for the upcoming generations as custodians of the oasis farming landscape.'
        ,location: 'https://goo.gl/maps/iv4foBwvquNgZogu8',
        phone: '+966 56 137 3919',
        category: 'ACTIVITIES',
        fromDate: DateTime(2022,10,23,19),
        toDate: DateTime(2022,10,30,23),
        latitude: 26.60321076998669,
        longitude: 37.94016479325326,
    ),
    ///HANDICRAFTS
    models.Heritage(id: ""
        , photoUrl: "https://firebasestorage.googleapis.com/v0/b/atharna-8f15b.appspot.com/o/HeritageCategory%2Fs.jpg?alt=media&token=8b5a2a80-b050-43ab-a374-9e82814382c6"
        , date: DateTime.now(),
        title: 'WADI ALFANN',
        description: 'Wadi AlFann, meaning ‘Valley of the Arts’, is an awe-inspiring new global cultural destination for contemporary art. Era-defining works by some of the most compelling artists from around the world will be permanently placed in the monumental landscape of AlUla. Opening in 2024.'
        ,location: 'https://goo.gl/maps/uXnuTkeGkB6fZ3Qb7',
        category: 'HANDICRAFTS',
        latitude: 26.666278433625667,
        longitude: 37.99104353558226,),
    models.Heritage(id: ""
      , photoUrl: "https://firebasestorage.googleapis.com/v0/b/atharna-8f15b.appspot.com/o/HeritageCategory%2Fss.jpg?alt=media&token=7620b888-6be6-4c2e-909d-8436b9e5819f"
      , date: DateTime.now(),
      title: 'DESERT X',
      description: 'In 2020, Desert X brought together local, Saudi and international audiences to create larger-than-life installations that shed new light on the ancient rock formations that surrounded them.'
      ,location: 'https://goo.gl/maps/FaM8unkEiSY6qScc9',
      category: 'HANDICRAFTS',
      latitude: 26.66780800699763,
      longitude: 37.995117841494064,),
    ///URBAN HERITAGE
    models.Heritage(id: ""
      , photoUrl: "https://firebasestorage.googleapis.com/v0/b/atharna-8f15b.appspot.com/o/HeritageCategory%2Fd.jpg?alt=media&token=658c9a41-801f-43e6-87bf-d370adde2a8e"
      , date: DateTime.now(),
      title: 'Hegra',
      description: 'One of AlUla’s most famous settlements is Saudi Arabia’s first UNESCO World Heritage Site, carved tombs are from around 2nd century BCE until 106 CE.'
      ,location: 'https://goo.gl/maps/HtupMULhUtj8pni1A',
      category: 'URBAN HERITAGE',
      latitude: 26.62516456250627,
      longitude: 37.91539216441775,),


    models.Heritage(id: ""
      , photoUrl: "https://firebasestorage.googleapis.com/v0/b/atharna-8f15b.appspot.com/o/HeritageCategory%2Fdd.jpg?alt=media&token=b3391df6-73b6-441f-9714-6b9866a04681"
      , date: DateTime.now(),
      title: 'Old Town of AlUla',
      description: 'Once a place of nearly 900 homes, 400 shops and 5 town squares, much of the Old Town of AlUla’s mudbrick and stone architecture still survives today. A citadel perched on a prominent outcrop along the eastern edge is still accessible via a restored staircase. Those interested in history will be delighted to discover that this site was occupied within recent memory, offering unique opportunities to gather and share oral histories encapsulating a disappearing way of life.'
      ,location: 'https://goo.gl/maps/MneJBM6xZYQe7vJx5',
      category: 'URBAN HERITAGE',
      latitude: 26.625212518112175,
      longitude: 37.915424350924276,),

    models.Heritage(id: ""
      , photoUrl: "https://firebasestorage.googleapis.com/v0/b/atharna-8f15b.appspot.com/o/HeritageCategory%2Fddd.jpg?alt=media&token=fda744a6-e7ca-49b1-8103-00954a1e9bb1"
      , date: DateTime.now(),
      title: 'Maraya',
      description: 'The world’s largest mirrored building, registered in January 2020 by the Guinness Book of World Records, a place where mirrors have been effectively used as a key design feature. The word ‘Maraya’ in Arabic translates to ‘mirror’. Enjoy this remarkable multipurpose conference and functions venue.'
      ,location: 'https://goo.gl/maps/jwUVXLvXU7ycPbFw6',
      category: 'URBAN HERITAGE',
      latitude: 26.743303427323063,
      longitude: 37.864816781974504,),

    models.Heritage(id: ""
      , photoUrl: "https://firebasestorage.googleapis.com/v0/b/atharna-8f15b.appspot.com/o/HeritageCategory%2Fdddd.jpg?alt=media&token=fc635a00-46d0-460e-a271-70d5ba9ddefc"
      , date: DateTime.now(),
      title: 'Al Diwan',
      description: 'Religious or ritual practices at Hegra were concentrated around Jabal Ithlib, a natural mountain outcrop to the east of the city. A special feature is a rock-cut chamber known as the Diwan, where ritual or elite banqueting and political discussions took place.'
      ,location: 'https://goo.gl/maps/94HDwseJXwKthapk7',
      category: 'URBAN HERITAGE',
      latitude: 27.63592507114161,
      longitude: 38.16484577315996,),

    models.Heritage(id: ""
      , photoUrl: "https://firebasestorage.googleapis.com/v0/b/atharna-8f15b.appspot.com/o/HeritageCategory%2Fddddd.jpg?alt=media&token=3c5a95a3-a2b6-4c86-bda8-7adb6f817e76"
      , date: DateTime.now(),
      title: 'Jabal Ikmah',
      description: 'An open air library across AlUla\'s Valley, lie thousands of inscriptions in Aramaic, Dadanitic, Thamudic, Minaic and Nabataean, features one of the oldest inscriptions of the Islamic era dating back to 24AH (644 CE).'
      ,location: 'https://goo.gl/maps/LUM2Kazg2YLGxtib8',
      category: 'URBAN HERITAGE',
      latitude: 26.685635118642892, 
      longitude: 37.90734447795053,),
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
