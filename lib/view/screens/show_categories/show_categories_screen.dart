import 'package:atharna/view/resources/assets_manager.dart';
import 'package:atharna/view/resources/color_manager.dart';
import 'package:atharna/view/resources/style_manager.dart';
import 'package:atharna/view/resources/values_manager.dart';
import 'package:atharna/view/screens/details_discover/details_discover_screen.dart';
import 'package:atharna/widgets/picture/cach_picture_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../controller/heritage_provider.dart';
import '../../../model/const.dart';
import '../../../model/models.dart';
import '../../../model/sizer.dart';
import '../../resources/consts_manager.dart';

class ShowCategoriesScreen extends StatefulWidget {
  final String name;

  const ShowCategoriesScreen({super.key, required this.name});

  @override
  State<ShowCategoriesScreen> createState() => _ShowCategoriesScreenState();
}

class _ShowCategoriesScreenState extends State<ShowCategoriesScreen> {
  var getListHeritagesCategory;
  HeritageProvider heritageProvider = HeritageProvider();
  @override
  void initState() {
    getListHeritagesCategoryFuc();
    super.initState();
  }

  getListHeritagesCategoryFuc() {
    print(widget.name);
     getListHeritagesCategory = FirebaseFirestore.instance
        .collection(AppConstants.collectionHeritage)
    .where('category',isEqualTo: widget.name)
    /// .orderBy("date")
        .snapshots();
    return getListHeritagesCategory;
  }
  @override
  Widget build(BuildContext context) {
    heritageProvider = Provider.of<HeritageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:  Text(
          widget.name,
          style: getBoldStyle(
              color: ColorManager.black,
              fontSize: Sizer.getW(context) / 18),
        ),
        leading: BackButton(
          color: ColorManager.black,
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          //prints the messages to the screen0
            stream: getListHeritagesCategory,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return
                  /// Const.SHOWLOADINGINDECATOR();
                  waitListCategory(context);
              }
              else if (snapshot.connectionState ==
                  ConnectionState.active) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  /// Const.SHOWLOADINGINDECATOR();
                  waitListCategory(context);
                  heritageProvider.listHeritagesCategory=Heritages.fromJson(snapshot.data!.docs);
                  print("Heritage Category ${widget.name} : ${snapshot.data!.docs.length}");
                  return buildListCategory(context);
                  /// }));
                } else {
                  return const Text('Empty data');
                }
              }
              else {
                return Text('State: ${snapshot.connectionState}');
              }
            }),
      ),
    );
  }

  Widget buildShapeCategories(BuildContext context,int index){
    return InkWell(
      onTap: (){
        heritageProvider.heritage=heritageProvider.listHeritagesCategory.heritages[index];
       // print("${heritageProvider.listHeritagesCategory.heritages[index].city}");
        Navigator.push(context, MaterialPageRoute(builder: (ctx)=>DetailsDiscoverScreen()));},

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
                child:CacheNetworkImage(
                  photoUrl: '${heritageProvider.listHeritagesCategory.heritages[index].photoUrl}'
                  , width: Sizer.getW(context) / 3.5,
                  height: Sizer.getW(context) / 3.5,
                  waitWidget: Image.asset(ImagesAssets.onBoardingIMG2),
                  errorWidget: Image.asset(ImagesAssets.onBoardingIMG2),

                )
                ///Image.asset(ImagesAssets.categoriesIMG2)
            ),

            Expanded(
              child: ListTile(
                title: buildContent(context,index),
                subtitle:
                (widget.name.contains("ACTIVITIES"))?
                  Row(
                  children: [
                    Expanded(child: Row(
                      children: [
                        Icon(Icons.timer_outlined,color: ColorManager.lightGray,size: Sizer.getW(context)*0.045,),
                        Text(' ${DateFormat('hha').format(heritageProvider.listHeritagesCategory.heritages[index].toDate!)}-${DateFormat('hha').format(heritageProvider.listHeritagesCategory.heritages[index].fromDate!)}'
                          ,style: getRegularStyle(color: ColorManager.lightGray),)
                      ],
                    )),
                    Expanded(child: Row(
                      children: [
                        Text('${DateFormat.yMd().format(heritageProvider.listHeritagesCategory.heritages[index].fromDate!)}'
                          ,style: getRegularStyle(color: ColorManager.lightGray),)
                      ],
                    )),
                  ],
                )
                    :SizedBox(),
              ),
            )
            ,
          ],
        ),
      ),
    );
  }

  Column buildContent(BuildContext context,int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('${heritageProvider.listHeritagesCategory.heritages[index].title}'/*'Al-Ula Tour'*/,style: getRegularStyle(color: ColorManager.black,fontSize: Sizer.getW(context)/22),),
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
   buildListCategory(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p16, vertical: AppPadding.p10),
      itemCount: heritageProvider.listHeritagesCategory.heritages.length,
      itemBuilder: (context,index)=>buildShapeCategories(context,index),
    );
  }
  ///wait
  Widget waitListCategory(BuildContext context){
   // if(heritageProvider.listHeritagesCategory.heritages.length<=0){
      return Const.SHOWLOADINGINDECATOR();
   // }else {
      return buildListCategory(context);
   // }
  }
}
