import 'package:flutter/cupertino.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:image_picker/image_picker.dart';

import '../view/resources/values_manager.dart';

class AddRuinProvider extends ChangeNotifier{
   ImagePicker picker = ImagePicker();

  XFile? image;
  Map<String , dynamic> locationHeritage ={
    "latitude": "",
    "longitude":""
  };
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
}