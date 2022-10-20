import 'package:atharna/controller/utils/firebase.dart';
import 'package:atharna/view/resources/consts_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:image_picker/image_picker.dart';

import '../model/const.dart';
import '../model/models.dart';
import '../view/resources/values_manager.dart';

class AddRuinProvider extends ChangeNotifier{
   ImagePicker picker = ImagePicker();

  XFile? image;
  Map<String , dynamic> locationHeritage ={
    "latitude": "",
    "longitude":""
  };
   double  rateComplete=0;
   Map<String,dynamic>  mapComplete={};
   final firstName = TextEditingController();
   final lastName = TextEditingController();
   final heritageType = TextEditingController(text: '');

   Heritage heritage=Heritage(id: "", userId: "", firstName: "firstName", lastName: "lastName", photoUrl: "", heritageType: "heritageType", latitude: 0, longitude: 0, date: DateTime.now());

   
   createHeritage(context,{required String userId}) async{
     var result;
     String url=await FirebaseFun.uploadImage(image: image!, folder: AppConstants.collectionHeritage);
     if(url==null){
       return FirebaseFun.errorUser("the image is empty or failed");}
     else {
       heritage=Heritage(id: "",
           userId: userId,
           firstName: firstName.text, lastName: lastName.text,
           photoUrl: "",
           heritageType: heritageType.text,
           latitude: locationHeritage['latitude'],
           longitude: locationHeritage['longitude'],
           date: DateTime.now());
       // return session.toJson();
       result =await FirebaseFun.createHeritage(heritage: heritage);
     }
       print(result);
       Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
       return result;
     }
  changeRateComplete(String key,bool state){
    mapComplete[key]=state;
     calculationRateComplete();
     notifyListeners();
  }
   calculationRateComplete(){
     int countComplete=0;
     print(mapComplete.values.length);
     mapComplete.values.forEach((element) {
     //  print(element);
      if(element) countComplete++;
     });
     rateComplete=(countComplete/5);

   }

  pickFromCamera() async {
    image = await picker.pickImage(source: ImageSource.camera);
    notifyListeners();
  }

  pickFromGallery() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    notifyListeners();
  }

  pickLocation(BuildContext context) async {
    await showSimplePickerLocation(
      isDismissible: true,
                        context: context,
                        titleWidget: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(
                            bottom: AppPadding.p20
                          ),
                          child: Text( "Select Location Heritage",),
                        ),
                        radius: AppSize.s14,
                        textConfirmPicker: "Ok",
                        initCurrentUserPosition: true,
                        initZoom: 14
                      ).then((value) {
                        // print(value!.latitude);
                        // print(value.longitude);
                        locationHeritage["latitude"] = value?.latitude==null?"":value?.latitude;
                        locationHeritage["longitude"] = value?.longitude==null?"":value?.longitude;
                        print("***********************************");
                        print(locationHeritage);
                        print("***********************************");
                                              });
  }

   @override
   void dispose() {
     // TODO: implement dispose
     rateComplete=0;
     mapComplete.clear();
     firstName.clear() ;
     lastName.clear()  ;
     heritageType.clear() ;
     locationHeritage ={
       "latitude": "",
       "longitude":""
     };
     image=null;
     super.dispose();
   }
}