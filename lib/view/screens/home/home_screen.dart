import 'dart:io';

import 'package:atharna/controller/heritage_provider.dart';
import 'package:atharna/controller/home_provider.dart';
import 'package:atharna/model/models.dart';
import 'package:atharna/model/sizer.dart';
import 'package:atharna/view/resources/color_manager.dart';
import 'package:atharna/view/resources/style_manager.dart';
import 'package:atharna/view/resources/values_manager.dart';
import 'package:atharna/view/screens/details_discover/details_discover_screen.dart';
import 'package:atharna/widgets/future.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../controller/profile_provider.dart';
import '../../../model/const.dart';
import '../../../widgets/picture/cach_picture_widget.dart';
import '../../../widgets/picture/profile_picture_widget.dart';
import '../../resources/consts_manager.dart';
import '../show_categories/show_categories_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> word = ["All", "Madinah", "Asser", "Riyhad", "Jazan", "Alshrqe"];
  var getListHeritages;
  HomeProvider homeProvider = HomeProvider();
  HeritageProvider heritageProvider = HeritageProvider();

  @override
  void initState() {
    getListHeritagesFuc();
    super.initState();
  }

  getListHeritagesFuc() {
    getListHeritages = FirebaseFirestore.instance
        .collection(AppConstants.collectionHeritage)
        /// .orderBy("date")
        .snapshots();
    return getListHeritages;
  }

  @override
  Widget build(BuildContext context) {
    heritageProvider = Provider.of<HeritageProvider>(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p16, vertical: AppPadding.p10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildAppBarHome(context),
            const SizedBox(
              height: AppSize.s10,
            ),
            Text("Discover",
                style: getBoldStyle(
                  color: ColorManager.black,
                  fontSize: Sizer.getW(context) / 16,
                )),
            const SizedBox(
              height: AppSize.s10,
            ),
            Expanded(
                flex: 3,
                 child: Column(
                  children: [
                    ChangeNotifierProvider<HomeProvider>.value(
                      value: HomeProvider(),
                      child: Consumer<HomeProvider>(
                          builder: (context, value, child) => SizedBox(
                                height: Sizer.getW(context) * 0.1,
                                child:  buildTabBar(value)
                              )),
                    ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    StreamBuilder<QuerySnapshot>(
                      //prints the messages to the screen0
                        stream: getListHeritages,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return
                             /// Const.SHOWLOADINGINDECATOR();
                              waitDiscover(context);
                          }
                          else if (snapshot.connectionState ==
                              ConnectionState.active) {
                            if (snapshot.hasError) {
                              return const Text('Error');
                            } else if (snapshot.hasData) {
                             /// Const.SHOWLOADINGINDECATOR();
                              waitDiscover(context);
                              heritageProvider.listHeritages=Heritages.fromJson(snapshot.data!.docs);
                              heritageProvider.sortByCategory(homeProvider.selectIndex);
                              print("All Heritage : ${snapshot.data!.docs.length}");
                              print("Heritage By City : ${heritageProvider.listHeritageCity.length}");
                              return buildDiscover(context);
                              /// }));
                            } else {
                              return const Text('Empty data');
                            }
                          }
                          else {
                            return Text('State: ${snapshot.connectionState}');
                          }
                        }),

                  ],
                )

            ),
            const SizedBox(
              height: AppSize.s10,
            ),
            Text("Categories",
                style: getBoldStyle(
                  color: ColorManager.black,
                  fontSize: Sizer.getW(context) / 16,
                )),
            const SizedBox(
              height: AppSize.s10,
            ),
            buildCategories(context),
            const SizedBox(
              height: AppSize.s10,
            ),
            Text("Popular",
                style: getBoldStyle(
                  color: ColorManager.black,
                  fontSize: Sizer.getW(context) / 16,
                )),
            const SizedBox(
              height: AppSize.s10,
            ),
            buildPopular(context),
            const SizedBox(
              height: AppSize.s10,
            ),
          ],
        ),
      ),
    );
  }

  ListView buildTabBar(HomeProvider value) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: heritageProvider.listHeritageCity.length,
      itemBuilder: ((context, index) => InkWell(
            onTap: () {
              value.changeIndex(index);
              print(value.selectIndex);
            },
            child: AnimatedContainer(
              alignment: Alignment.center,
              width: Sizer.getH(context) * 0.1,
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s4),
                color: value.selectIndex == index
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
              ),
              padding: const EdgeInsets.all(AppPadding.p4),
              margin: EdgeInsets.only(left: index == 0 ? 0 : AppMargin.m4),
              child: Text(
                word[index],
                overflow: TextOverflow.ellipsis,
                style: getRegularStyle(color: value.selectIndex == index
                    ? ColorManager.white
                    : ColorManager.black,
                fontSize: Sizer.getW(context) / 26
                )
              ),
            ),
          )),
    );
  }

  Widget buildCategories(BuildContext context) {
    return SizedBox(
      height: Sizer.getW(context) * 0.25,
      child: Row(
        children: [
          for(var i =0 ; i <AppConstants.categoriesList.length;i++)
            Expanded(
              child: InkWell(
                onTap: (){
                  heritageProvider.listHeritagesCategory.heritages.clear();
                  Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ShowCategoriesScreen(
                    name: AppConstants.categoriesList[i].name,
                  )));
                },
                child: Container(
                  padding: const EdgeInsets.all(AppPadding.p4),
                  margin: EdgeInsets.only(left: i==0?0:AppMargin.m8),
                  width: Sizer.getW(context) / 3,

                  child: Column(
                    children: [
                      Expanded(
                        child: Image.asset(AppConstants.categoriesList[i].image),
                      ),
                      SizedBox(height: AppSize.s1_5,),
                      Text(AppConstants.categoriesList[i].name,style:
                      getRegularStyle(color: ColorManager.blackGray,
                      ),)
                    ],
                  ),
                ),
              ),
            )
        ],
          ),
    );
  }

  Widget buildPopular(BuildContext context) {
    return Expanded(
      flex: 2,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) => Container(
                padding: const EdgeInsets.all(AppPadding.p12),
                margin: EdgeInsets.only(left: index == 0 ? 0 : AppMargin.m12),
                width: Sizer.getW(context) / 1.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s14),
                    image: DecorationImage(
                        fit: BoxFit.fill, image: AssetImage("assets/1.png"))),
              )),
    );
  }

  Widget buildDiscover(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: heritageProvider.listHeritagesByCity.heritages.length,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  heritageProvider.heritage=heritageProvider.listHeritagesByCity.heritages[index];
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => DetailsDiscoverScreen()));
                },
                child: Container(
                  margin: EdgeInsets.only(left: index == 0 ? 0 : AppMargin.m12),
                  width: Sizer.getW(context) / 1.8,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(AppSize.s14),
                   boxShadow: [
                     BoxShadow(
                       color: ColorManager.lightGray.withOpacity(.2),
                       blurRadius: AppSize.s8
                     )
                   ]
                 ),
                 child: Stack(
                  //  fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppSize.s14),
                        child: ColorFiltered(
                          colorFilter:
                          ColorFilter.mode(
                              ColorManager.black.withOpacity(.2), BlendMode.darken),

                          child: CacheNetworkImage(photoUrl: heritageProvider.listHeritagesByCity.heritages[index].photoUrl,
                              width: Sizer.getH(context) / 1.8,
                              height: Sizer.getH(context) / 1.8,
                              waitWidget:  Image.asset(
                                "assets/1.png",
                                fit: BoxFit.fill,
                                width: double.infinity,
                                height: Sizer.getH(context) / 1.8,
                              ),
                              errorWidget: Image.asset(
                                "assets/1.png",
                                fit: BoxFit.fill,
                                width: double.infinity,
                                height: Sizer.getH(context) / 1.8,
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(AppPadding.p12),

                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Flexible(
                                child: Text(
                                    '${heritageProvider.listHeritagesByCity.heritages[index].firstName}'
                                        ' ${heritageProvider.listHeritagesByCity.heritages[index].lastName}',
                                    ///"Elephant Mountain",
                                    style: getBoldStyle(
                                      color: ColorManager.white,
                                      fontSize: Sizer.getW(context) / 16,
                                    )),
                              ),
                              const SizedBox(
                                height: AppSize.s4,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_pin,
                                    color: ColorManager.white,
                                    size: Sizer.getW(context) * 0.075,
                                  ),
                                  Flexible(
                                      child: Text(
                                          "Al-Ula",
                                          style: getLightStyle(color: ColorManager.white, fontSize: Sizer.getW(context) / 24)
                                      ))
                                ],
                              )
                            ]),
                      )
                    ],
                  ),
                ),
              )),
    );
  }
  ///wait
  Widget waitDiscover(BuildContext context){
    if(heritageProvider.listHeritageCity.length<=0){
      return Const.SHOWLOADINGINDECATOR();
    }else {
     return buildDiscover(context);
    }
  }

  Row buildAppBarHome(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(Icons.menu)),
        Container(
          width: Sizer.getW(context) * 0.125,
          height: Sizer.getW(context) * 0.125,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(color: ColorManager.lightGray, blurRadius: AppSize.s8)
              ],
              borderRadius: BorderRadius.circular(AppSize.s4),
              color: ColorManager.lightGray),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSize.s4),
            child: CacheNetworkImage(
              photoUrl: '${profileProvider.user.photoUrl}',
              width: Sizer.getW(context) * 0.14,
              height: Sizer.getW(context) * 0.14,
              waitWidget: WidgetProfilePicture(
                name: profileProvider.user.name,
                radius: AppSize.s4,
                fontSize: Sizer.getW(context) / 10,
              ),
              errorWidget: WidgetProfilePicture(
                name: profileProvider.user.name,
                radius: AppSize.s30,
                fontSize: Sizer.getW(context) / 10,
              ),
            ),
          ),
        )
      ],
    );
  }
}
