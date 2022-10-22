import 'package:atharna/controller/add_ruin_provider.dart';
import 'package:atharna/controller/create_heritage_provider.dart';
import 'package:atharna/model/const.dart';
import 'package:atharna/model/sizer.dart';
import 'package:atharna/view/resources/color_manager.dart';
import 'package:atharna/view/resources/style_manager.dart';
import 'package:atharna/view/resources/values_manager.dart';
import 'package:atharna/view/widgets/custome_textfiled.dart';
import 'package:circle_progress_bar/circle_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:provider/provider.dart';

import '../../../controller/profile_provider.dart';
import '../../../controller/utils/firebase.dart';

class AddRuinScreen extends StatelessWidget {
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final heritageType = TextEditingController(text: '');
  final formKey = GlobalKey<FormState>();
  late ProfileProvider profileProvider;
  checkPrograse(BuildContext context,AddRuinProvider value) async {
  if (value.mapComplete.values.length >= 5) {
  Const.LOADIG(context);
  await value.createHeritage(context,
  userId: profileProvider.user.id);
  Navigator.pop(context);
  } else {
  Const.TOAST(context,
  textToast: FirebaseFun.findTextToast(
  "There are empty fields after"));
  }
  }
  @override
  Widget build(BuildContext context) {
    profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      floatingActionButton:  SizedBox(
        height: Sizer.getW(context)*0.2,
        child: CircleProgressBar(
          foregroundColor: Theme.of(context).primaryColor,
          backgroundColor: Colors.black12,
          value: Provider.of<AddRuinProvider>(context).rateComplete * 100,
          child: FloatingActionButton(
            backgroundColor: ColorManager.white,
            onPressed: ()async{
              checkPrograse(context,Provider.of<AddRuinProvider>(context));
            },
            child: Text(
              "+",
              style: getRegularStyle(color: ColorManager.black,fontSize: Sizer.getW(context)/24),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p16, vertical: AppPadding.p10),
        child: ChangeNotifierProvider(
          create: (_) => AddRuinProvider(),
          child: Consumer<AddRuinProvider>(
              builder: ((context, value, child) =>
                  buildFormInfoHeritage(context, value))),
        ),
      ),
    );
  }

  Row buildDataHeritage() {
    return Row(
      children: [
        Expanded(child: SizedBox()),
        Expanded(
            child: ElevatedButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [Text("Submit"), Icon(Icons.arrow_forward)],
                ))),
      ],
    );
  }

  Widget buildFormInfoHeritage(BuildContext context, AddRuinProvider value) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            // Row(
            //   children: [
            //     Container(
            //       decoration: BoxDecoration(
            //         border: Border.all(color: ColorManager.black,width: 2),
            //         shape: BoxShape.circle
            //       ),
            //       child: IconButton(onPressed: ()=>Navigator.pop(context), icon: Icon(Icons.arrow_back,color: ColorManager.black,))),
            //   ],
            // ),
            const SizedBox(
              height: AppSize.s20,
            ),
            Text(
              "Information form",
              style: getBoldStyle(color: ColorManager.black,fontSize: Sizer.getW(context)/18)
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
            CustomTextFiled(
                controller: value.firstName,
                validator: (String? val) {
                  if (val!.trim().isEmpty) {
                    return "This filed reqiured";
                  }
                  return null;
                },
                onChange: (String? val) {
                  if (val!.trim().isEmpty) {
                    value.changeRateComplete("firstName", false);
                  } else {
                    value.changeRateComplete("firstName", true);
                  }
                },
                prefixIcon: Icons.person,
                maxLength: null,
                hintText: "First name"),
            const SizedBox(
              height: AppSize.s20,
            ),
            CustomTextFiled(
                controller: value.lastName,
                validator: (String? val) {
                  if (val!.trim().isEmpty) {
                    return "This filed reqiured";
                  }

                  return null;
                },
                onChange: (String? val) {
                  if (val!.trim().isEmpty) {
                    value.changeRateComplete("lastName", false);
                  } else {
                    value.changeRateComplete("lastName", true);
                  }
                },
                prefixIcon: Icons.person,
                maxLength: null,
                hintText: "Last name"),
            const SizedBox(
              height: AppSize.s20,
            ),
            DropdownButtonFormField(
              hint: Text(value.heritageType.text.isEmpty
                  ? "Heritage Type"
                  : value.heritageType.text,style: getRegularStyle(color: ColorManager.black,fontSize: Sizer.getW(context)/28),),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    vertical: AppPadding.p10, horizontal: AppPadding.p10),
              ),
              items: [
                for (int i = 0; i < 10; i++)
                  DropdownMenuItem(
                    value: i.toString(),
                    child: Text("Item ${i + 1}",style: getRegularStyle(color: ColorManager.black,fontSize: Sizer.getW(context)/28),),
                  )
              ],
              onChanged: (val) {
                value.heritageType.text = val.toString();
                if (val!.trim().isEmpty) {
                  value.changeRateComplete("heritageType", false);
                } else {
                  value.changeRateComplete("heritageType", true);
                }
              },
              validator: (val) {
                if (val == null) {
                  return "This filed required";
                }
              },
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Heritage image",style: getRegularStyle(color: ColorManager.black,fontSize: Sizer.getW(context)/28),),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      InkWell(
                          onTap: () async {
                            await selectPhotoDialog(context, value);
                            if (value.image == null) {
                              value.changeRateComplete("image", false);
                            } else {
                              value.changeRateComplete("image", true);
                            }
                          },
                          child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: Radius.circular(20),
                              dashPattern: [10, 10],
                              color: ColorManager.lightGray,
                              strokeWidth: 2,
                              child: Container(
                                height: Sizer.getW(context) / 2.2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.cloud_upload,
                                      size: Sizer.getW(context) * 0.1,
                                    ),
                                    const SizedBox(
                                      height: AppSize.s20,
                                    ),
                                    Text(
                                      "Browser to uplade",
                                      textAlign: TextAlign.center,
                                        style: getRegularStyle(color: ColorManager.black,fontSize: Sizer.getW(context)/28)
                                    )
                                  ],
                                ),
                              )))
                    ],
                  ),
                ),
                const SizedBox(
                  width: AppSize.s10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Select heritage location",style: getRegularStyle(color: ColorManager.black,fontSize: Sizer.getW(context)/28)),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      InkWell(
                          onTap: () async {
                            await value.pickLocation(context);
                            if (value.locationHeritage.values.first
                                .toString()
                                .trim()
                                .isEmpty) {
                              value.changeRateComplete("location", false);
                            } else {
                              value.changeRateComplete("location", true);
                            }
                          },
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(20),
                            dashPattern: [10, 10],
                            color: ColorManager.lightGray,
                            strokeWidth: 2,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(AppSize.s14),
                              child: Container(
                                height: Sizer.getW(context) / 2.2,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage('assets/map.png'))),
                              ),
                            ),
                          ))
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
            const SizedBox(height: AppSize.s10,),
            LinearPercentIndicator(
              lineHeight: Sizer.getW(context) * 0.06,
              barRadius: Radius.circular(AppSize.s50),
              percent: value.rateComplete,
              center: new Text(
                "${(value.rateComplete * 100).floor()}% is Completed",
                style:  getRegularStyle(color: ColorManager.white,fontSize: Sizer.getW(context)/28),
              ),
              progressColor: Theme.of(context).primaryColor,
            )
          ]),
        ),
      ),
    );
  }

  Future<dynamic> selectPhotoDialog(
      BuildContext context, AddRuinProvider value) {
    return showDialog(
        context: context,
        builder: (_) {
          return Center(
            child: Container(
              height: Sizer.getW(context) * 0.4,
              width: Sizer.getW(context) - AppSize.s30,
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(AppSize.s14)),
              child: Material(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          await value.pickFromCamera();
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(AppPadding.p8),
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
                        onTap: () async {
                          await value.pickFromGallery();
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(AppPadding.p8),
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
                  ],
                ),
              ),
            ),
          );
        });
  }
}
