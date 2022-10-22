import 'package:atharna/view/resources/assets_manager.dart';
import 'package:atharna/view/resources/color_manager.dart';
import 'package:atharna/view/resources/style_manager.dart';
import 'package:atharna/view/resources/values_manager.dart';
import 'package:atharna/view/screens/details_discover/details_discover_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../model/sizer.dart';

class ShowCategoriesScreen extends StatelessWidget {
  final String name;

  const ShowCategoriesScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:  Text(
          name,
          style: getBoldStyle(
              color: ColorManager.black,
              fontSize: Sizer.getW(context) / 18),
        ),
        leading: BackButton(
          color: ColorManager.black,
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p16, vertical: AppPadding.p10),
          itemCount: 10,
          itemBuilder: (context,index)=>buildShapeCategories(context,index),
        ),
      ),
    );
  }
  Widget buildShapeCategories(BuildContext context,int index){
    return InkWell(
      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (ctx)=>DetailsDiscoverScreen())),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: AppMargin.m8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s8),
          color: ColorManager.white,
          boxShadow: [
            BoxShadow(color: ColorManager.lightGray.withOpacity(.2),blurRadius: AppSize.s6)
          ]
        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(AppMargin.m4),
                width: Sizer.getW(context) / 3.5,
                height: Sizer.getW(context) / 3.5,
                decoration: BoxDecoration(
                    color: ColorManager.primary,
                  borderRadius: BorderRadius.circular(AppSize.s8)
                ),
                child: Image.asset(ImagesAssets.categoriesIMG2)),
            Expanded(
              child: ListTile(
                title: buildContent(context),
                subtitle: Row(
                  children: [
                    Expanded(child: Row(
                      children: [
                        Icon(Icons.timer_outlined,color: ColorManager.lightGray,size: Sizer.getW(context)*0.045,),
                        Text("1PM - 10PM",style: getRegularStyle(color: ColorManager.lightGray),)
                      ],
                    )),
                    Expanded(child: Row(
                      children: [
                        Text('${DateFormat.yMd().format(DateTime.now())}'
                          ,style: getRegularStyle(color: ColorManager.lightGray),)
                      ],
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Al-Ula Tour',style: getRegularStyle(color: ColorManager.black,fontSize: Sizer.getW(context)/22),),
        const SizedBox(height: AppSize.s4,),
        Row(
          children: [
            Icon(Icons.star,color: Colors.amber,),
            const SizedBox(width: AppSize.s4,),
            Text('4.6',style: getLightStyle(color: ColorManager.lightGray,fontSize: Sizer.getW(context)/26),),
          ],
        ),
        const SizedBox(height: AppSize.s10,),
      ],
    );
  }
}
