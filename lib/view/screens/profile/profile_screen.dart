import 'dart:io';

import 'package:atharna/controller/profile_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';
import '../../../model/const.dart';
import '../../../model/sizer.dart';
import '../../../widgets/picture/cach_picture_widget.dart';
import '../../../widgets/picture/profile_picture_widget.dart';
import '../../resources/values_manager.dart';
import '../../widgets/custome_button.dart';
import '../../widgets/custome_textfiled.dart';

class ProfileScreen extends StatelessWidget {
   ImagePicker picker = ImagePicker();

  XFile? image;
  Map<String , dynamic> locationHeritage ={
    "latitude": "",
    "longitude":""
  };
  pickFromCamera() async {
    image = await picker.pickImage(source: ImageSource.camera);
  }

  pickFromGallery() async {
    image = await picker.pickImage(source: ImageSource.gallery);
  }
   removeGallery() async {
     image =  XFile("");
   }
   Future uploadImage() async {
     try {
       String path = basename(image!.path);
       print(image!.path);
       File file =File(image!.path);

       Reference storage = FirebaseStorage.instance.ref().child("profileImage/${path}");
       UploadTask storageUploadTask = storage.putFile(file);
       TaskSnapshot taskSnapshot = await storageUploadTask;
       //Const.LOADIG(context);
       String url = await taskSnapshot.ref.getDownloadURL();
       //Navigator.of(context).pop();
       print('url $url');
       return url;
     } catch (ex) {
       //Const.TOAST( context,textToast:FirebaseFun.findTextToast("Please, upload the image"));
     }
   }
  bool nameIgnor = false;
   late ProfileProvider profileProvider;
  @override
  Widget build(BuildContext context) {
    profileProvider = Provider.of<ProfileProvider>(context);
    return   Container(
              padding: EdgeInsets.symmetric(
                  vertical: AppPadding.p10, horizontal: AppPadding.p16),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: Sizer.getW(context) * 0.35,
                            height: Sizer.getW(context) * 0.35,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                    width: AppSize.s4)),
                            child: image == null
                                ? ClipOval(
                                child:
                                CacheNetworkImage(
                                  photoUrl: '${profileProvider.user.photoUrl}',
                                  width: Sizer.getW(context) * 0.14,
                                  height: Sizer.getW(context) * 0.14,
                                  waitWidget: WidgetProfilePicture(
                                    name: profileProvider.user.name,
                                    radius: AppSize.s30,
                                    fontSize: Sizer.getW(context) / 10,
                                  ),
                                  errorWidget: WidgetProfilePicture(
                                    name: profileProvider.user.name,
                                    radius: AppSize.s30,
                                    fontSize: Sizer.getW(context) / 10,
                                  ),
                                ))
                                : ClipOval(
                                    child: Image.file(File(image!.path),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor),
                                  shape: BoxShape.circle),
                              child: IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (_) {
                                        return Center(
                                          child: Container(
                                            height: Sizer.getW(context) * 0.4,
                                            width:
                                                Sizer.getW(context) - AppSize.s30,
                                            color: Theme.of(context).cardColor,
                                            child: Material(
                                              color: Colors.transparent,
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        pickFromCamera();
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        alignment: Alignment.center,
                                                        padding: EdgeInsets.all(
                                                            AppPadding.p8),
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons.camera),
                                                            const SizedBox(
                                                              width: AppSize.s8,
                                                            ),
                                                            Text("Camera"),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 0.0,
                                                  ),
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: ()  {

                                                        pickFromGallery();
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        alignment: Alignment.center,
                                                        padding: EdgeInsets.all(
                                                            AppPadding.p8),
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons.photo),
                                                            const SizedBox(
                                                              width: AppSize.s8,
                                                            ),
                                                            Text("Gallery"),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 0.0,
                                                  ),
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: ()  {

                                                        removeGallery();
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        alignment: Alignment.center,
                                                        padding: EdgeInsets.all(
                                                            AppPadding.p8),
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons.delete),
                                                            const SizedBox(
                                                              width: AppSize.s8,
                                                            ),
                                                            Text("Remove"),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                },
                                icon: Icon(Icons.edit),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: AppSize.s30,
                      ),
                      StatefulBuilder(builder: (_, setState1) {
                        return CustomTextFiled(
                            onSubmit: (val) {
                              nameIgnor = true;
                              setState1(() {});
                            },
                            readOnly: nameIgnor,
                            controller: profileProvider.name, //TextEditingController(),
                            validator: (String? val) {
                              if (val!.isEmpty) {
                                return "reqired filed";
                              } else {
                                return null;
                              }
                            },
                            onChange: (val) {},
                            prefixIcon: Icons.person,
                            maxLength: null,
                            suffixIcon: IconButton(
                              onPressed: () {
                                nameIgnor = false;
                                //profileProvider.user.name="f";
                                setState1(() {});
                              },
                              icon: Icon(Icons.edit),
                            ),
                            hintText: "Name");
                      }),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      StatefulBuilder(builder: (_, setState2) {
                        return CustomTextFiled(
                            onSubmit: (val) {
                              setState2(() {});
                            },
                            readOnly: false,
                            controller: profileProvider.email,//TextEditingController(),
                            validator: (String? val) {
                              // if (val!.isEmpty) {
                              //   return tr(LocaleKeys.field_required);
                              // } else if (!val.isEmail) {
                              //   return tr(LocaleKeys.enter_valid_email);
                              // } else {
                              //   return null;
                              // }
                            },
                            onChange: (val) {},
                            prefixIcon: Icons.email,
                            maxLength: null,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState2(() {});
                              },
                              icon: Icon(Icons.edit),
                            ),
                            hintText: "Email");
                      }),
                       const SizedBox(
                        height: AppSize.s20,
                      ),
                      StatefulBuilder(
                        builder: (_, setState2) {
                          return ButtonApp(
                              text: "Edit",
                              onTap: () async {
                                if(image!=null)
                                  Const.LOADIG(context);
                                  await profileProvider.uploadImage(context, image!);
                                await profileProvider.editUser(context);
                                Navigator.of(context).pop();
                               // emailIgnor = true;
                                nameIgnor = true;
                                setState2(() {});
                              });
                        },
                      ),
                    ],
                  ),
                ),
              ));
  }
}

