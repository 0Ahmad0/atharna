import 'package:atharna/model/sizer.dart';
import 'package:atharna/view/resources/color_manager.dart';
import 'package:atharna/view/resources/font_manager.dart';
import 'package:atharna/view/resources/style_manager.dart';
import 'package:atharna/view/resources/values_manager.dart';
import 'package:atharna/view/screens/details_discover/details_discover_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../controller/heritage_provider.dart';
import '../../../controller/profile_provider.dart';
import '../../../model/const.dart';
import '../../../model/models.dart';
import '../../../widgets/picture/cach_picture_widget.dart';
import '../../resources/consts_manager.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  var getListHeritagesFavorite;
  late HeritageProvider heritageProvider ;
  late ProfileProvider profileProvider;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_)  {
       profileProvider = Provider.of<ProfileProvider>(context, listen: false);
      getListHeritagesFavoriteFuc();
    });

    super.initState();
  }

  getListHeritagesFavoriteFuc() {
    getListHeritagesFavorite = FirebaseFirestore.instance
        .collection(AppConstants.collectionHeritage)
        .where('listFavoriteUserID',arrayContains: profileProvider.user.id)
    /// .orderBy("date")
        .snapshots();
    return getListHeritagesFavorite;
  }
  @override
  Widget build(BuildContext context) {
    profileProvider = Provider.of<ProfileProvider>(context);
    heritageProvider = Provider.of<HeritageProvider>(context);

    return SafeArea(
      child: StreamBuilder<QuerySnapshot>(
        //prints the messages to the screen0
          stream: getListHeritagesFavoriteFuc(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return
                /// Const.SHOWLOADINGINDECATOR();
                waitListFavorite(context);
            }
            else if (snapshot.connectionState ==
                ConnectionState.active) {
              if (snapshot.hasError) {
                return const Text('Error');
              } else if (snapshot.hasData) {
                /// Const.SHOWLOADINGINDECATOR();
                waitListFavorite(context);
                heritageProvider.listHeritagesFavorite=Heritages.fromJson(snapshot.data!.docs);
                print("Heritage Favorite: ${snapshot.data!.docs.length}");
                return buildListFavorite(context);
                /// }));
              } else {
                return const Text('Empty data');
              }
            }
            else {
              return Text('State: ${snapshot.connectionState}');
            }
          }),
    );
  }

  Widget buildFavoriteItem(BuildContext context,int index){
    return InkWell(
      onTap: (){
        heritageProvider.heritage=heritageProvider.listHeritagesFavorite.heritages[index];
        Navigator.push(context, MaterialPageRoute(builder: (ctx)=>DetailsDiscoverScreen()));
      },
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: AppMargin.m12),
            height: Sizer.getW(context) * 0.5,
           // padding: const EdgeInsets.all(AppPadding.p14),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s14),
                boxShadow: [
                  BoxShadow(color: ColorManager.lightGray,blurRadius: AppSize.s8,offset: Offset(0,4))
                ],

            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.s14),
              child: ColorFiltered(
                  colorFilter:
                   ColorFilter.mode(
                      ColorManager.black.withOpacity(.2), BlendMode.darken),
                child: CacheNetworkImage(

                    photoUrl: heritageProvider.listHeritagesFavorite.heritages[index].photoUrl,
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
                    ),
                ),
              ),
            ),

          ),
          Positioned(
            bottom: Sizer.getH(context) * 0.025,
            right: AppSize.s10,
            child: Container(
              padding: const EdgeInsets.all(AppPadding.p12),
              decoration: BoxDecoration(color: ColorManager.white,shape: BoxShape.circle),
              child: Icon(Icons.favorite,
                size: Sizer.getW(context) * 0.08,
                color: ColorManager.error,
              ),
            ),
          ),

          Positioned(
            top: AppSize.s10,
            left: AppSize.s10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Sizer.getW(context) / 2,
                  child: Text(
                      '${heritageProvider.listHeritagesFavorite.heritages[index].firstName} ${heritageProvider.listHeritagesFavorite.heritages[index].lastName}'
                      /*"Ryadh"*/,style: getBoldStyle(color: ColorManager.white,fontSize: Sizer.getW(context)/16).copyWith(
                      overflow: TextOverflow.ellipsis
                  )),
                ),
                const SizedBox(height: AppSize.s10,),
                Row(
                  children: [
                    Icon(Icons.location_pin,size: Sizer.getW(context) / 14,color: ColorManager.white,),
                    const SizedBox(width: AppSize.s4,),
                    Container(
                      width: Sizer.getW(context) / 2,
                      child: Text("Al_Oula",style: getLightStyle(color: ColorManager.white,fontSize: Sizer.getW(context)/20).copyWith(
                          overflow: TextOverflow.ellipsis
                      )),
                    ),
                  ],
                ),
              ],
            ),
          )


        ],
      ),
    );
  }
  buildListFavorite(context){
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p16,
          vertical: AppPadding.p10
      ),
      itemCount: heritageProvider.listHeritagesFavorite.heritages.length,
      itemBuilder: ((_, index) => buildFavoriteItem(context, index)),
    );
  }
  Widget waitListFavorite(BuildContext context){
    if(heritageProvider.listHeritagesFavorite.heritages.length<=0){
      return Const.SHOWLOADINGINDECATOR();
    }else {
      return buildListFavorite(context);
    }
  }
}