import 'package:animate_do/animate_do.dart';
import 'package:atharna/view/resources/assets_manager.dart';
import 'package:atharna/view/resources/color_manager.dart';
import 'package:atharna/view/screens/details_discover/details_discover_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../model/sizer.dart';
import '../../../resources/style_manager.dart';
import '../../../resources/values_manager.dart';
import '../details_discoverd_site/details_discoverd_site_screen.dart';

class DiscoverSite {
  String? name;
  String? type;
  String? image;

  DiscoverSite({this.name, this.type, this.image});
}

class DiscoverSiteScreen extends StatelessWidget {
  List<DiscoverSite> _list = [
    DiscoverSite(
        name: "Ahmad Mriwed",
        type: "Intergent",
        image: ImagesAssets.categoriesIMG3),
    DiscoverSite(
        name: "Ahmad Hariri", type: "MSG#", image: ImagesAssets.categoriesIMG2),
    DiscoverSite(
        name: "Arwa", type: "Type2", image: ImagesAssets.categoriesIMG1),
    DiscoverSite(
        name: "Ahmad Hariri", type: "MSG#", image: ImagesAssets.categoriesIMG2),
    DiscoverSite(
        name: "Ahmad Mriwed",
        type: "Intergent",
        image: ImagesAssets.categoriesIMG3),
    DiscoverSite(
        name: "Ahmad Mriwed",
        type: "Intergent",
        image: ImagesAssets.categoriesIMG3),
    DiscoverSite(
        name: "Ahmad Hariri", type: "MSG#", image: ImagesAssets.categoriesIMG2),
    DiscoverSite(
        name: "Arwa", type: "Type2", image: ImagesAssets.categoriesIMG1),
    DiscoverSite(
        name: "Ahmad Hariri", type: "MSG#", image: ImagesAssets.categoriesIMG2),
    DiscoverSite(
        name: "Ahmad Mriwed",
        type: "Intergent",
        image: ImagesAssets.categoriesIMG3),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p14),
          child: Column(
            children: [
              FadeInDown(
                delay: Duration(milliseconds: 200),
                child: Row(
                  children: [
                    BackButton(),
                    Text(
                      "Discover Site",
                      style: getBoldStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: Sizer.getW(context) / 14),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: _list.length,
                      itemBuilder: (ctx, index) => buildDiscoverSite(context, index)))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDiscoverSite(BuildContext context, int index) {
    return InkWell(
      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (ctx)=>DetailsDiscoverCheck())),
      child: FadeInDown(
                              child: Container(
                                padding: const EdgeInsets.all(AppPadding.p10),
                            margin: const EdgeInsets.symmetric(
                                vertical: AppMargin.m8),
                            width: double.infinity,
                            height: Sizer.getW(context) * 0.35,
                            decoration: BoxDecoration(
                              color: ColorManager.primary,
                                borderRadius:
                                    BorderRadius.circular(AppSize.s14),
                                boxShadow: [
                                  BoxShadow(
                                      color: ColorManager.lightGray,
                                      blurRadius: AppSize.s8)
                                ]),
                            child:                                 Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child:                                 Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "${_list[index].name}",
                                      style: getBoldStyle(
                                          color: ColorManager.white,
                                          fontSize: Sizer.getW(context) / 18
                                      ),
                                    ),
                                    const SizedBox(height: AppSize.s10,),
                                    Text(
                                      "${_list[index].type}",
                                      style: getRegularStyle(
                                          color: ColorManager.white,
                                          fontSize: Sizer.getW(context) / 18
                                      ),
                                    ), const SizedBox(height: AppSize.s10,),
                                    Text(
                                      "${DateFormat.yMd().format(DateTime.now())}",
                                      style: getRegularStyle(
                                          color: ColorManager.white,
                                          fontSize: Sizer.getW(context) / 18
                                      ),
                                    ),
                                  ],
                                ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      color: ColorManager.white,
                                      borderRadius: BorderRadius.circular(AppSize.s14)
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(AppSize.s14),
                                      child: Image.asset(
                                        ImagesAssets.categoriesIMG3,
                                       fit: BoxFit.fill,
                                        height: double.infinity,
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            )

                              )),
    );
  }
}
