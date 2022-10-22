import 'package:atharna/controller/profile_provider.dart';
import 'package:atharna/model/sizer.dart';
import 'package:atharna/view/resources/consts_manager.dart';
import 'package:atharna/view/screens/map_location.dart/map_location_screen.dart';
import 'package:atharna/view/widgets/custome_button.dart';
import 'package:atharna/widgets/picture/cach_picture_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../controller/heritage_provider.dart';
import '../../resources/color_manager.dart';
import '../../resources/style_manager.dart';
import '../../resources/values_manager.dart';

class DetailsDiscoverScreen extends StatelessWidget {
  late HeritageProvider heritageProvider;
  late ProfileProvider profileProvider;
bool isFav = false;
String cap = "Jabal AlFil (Elephant Rock), is an amazing geomorphological wonder located 11km northeast of AlUla. A spectacular example of natural erosive forces of water and wind over a period of millions of years, this natural wonder rises 171ft into the air with mountains looming in the background.";
  @override
  Widget build(BuildContext context) {
    heritageProvider = Provider.of<HeritageProvider>(context);
    profileProvider = Provider.of<ProfileProvider>(context);
    isFav=heritageProvider.checkUserFavorite(profileProvider.user.id);
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
            Column(
            children: [
              
              Container(
                height: Sizer.getH(context) / 1.8,
               
                child: Stack(
                  children: [
                   CacheNetworkImage(photoUrl: heritageProvider.heritage.photoUrl,
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
                    Container(
                      padding: EdgeInsets.all(AppPadding.p12),
                      color: ColorManager.black.withOpacity(.5),
                      child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Flexible(
                                child: Text(
                      (heritageProvider.heritage.firstName!=null)?'${heritageProvider.heritage.firstName} ${heritageProvider.heritage.lastName}'
                      :'${heritageProvider.heritage.title}'
                                    ''/*"ElphantMounten"*/,style:getBoldStyle(color: ColorManager.white,fontSize: Sizer.getW(context) / 14)),
                              ),
                                 const SizedBox(height: AppSize.s4,),
                              Row(
                                children: [
                                  Icon(Icons.location_pin,color: ColorManager.white,size: Sizer.getW(context)*0.075 ,),
                                  Flexible(child: Text("Al-Ula",style: getLightStyle(color: ColorManager.white,fontSize: Sizer.getW(context) / 24),))
                                ],
                              )
                        ,SizedBox(height: Sizer.getW(context) * 0.2,)
                            ]),
                    ),
                  ],
                ),
               
              ),
            ],
          ),
            Container(
              padding: EdgeInsets.only(
                left: AppPadding.p30,
                right: AppPadding.p30,
                top: AppPadding.p24,
                bottom: AppPadding.p14
              ),
          height: Sizer.getH(context) / 1.9,
          decoration: BoxDecoration(color: ColorManager.white,borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.s50),),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                  Text("Description",style: getBoldStyle(color: ColorManager.black,fontSize: Sizer.getW(context) / 14)),
             const SizedBox(height: AppSize.s10,),
             Text('${heritageProvider.heritage.description}'/*cap*/,style: getRegularStyle(color: ColorManager.lightGray,fontSize: Sizer.getW(context) / 26)),
             //TODO Show This Line if ACTIVITIES

             if((heritageProvider.heritage.phone!=null))
               Column(
                 children: [
                   const SizedBox(height: AppSize.s20,),
                   Row(
                     children: [
                       Text('${heritageProvider.heritage.phone}'
                         ,style: getRegularStyle(color: ColorManager.lightGray,fontSize: Sizer.getW(context)/26),)
                     ],
                   ),
                   const SizedBox(height: AppSize.s20,),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Row(
                         children: [
                           Icon(Icons.timer_outlined,color: ColorManager.lightGray,size: Sizer.getW(context)*0.045,),
                           Text("1PM - 10PM",style: getRegularStyle(color: ColorManager.lightGray,fontSize: Sizer.getW(context)/26),)
                         ],
                       ),
                       const SizedBox(width: AppSize.s8,),
                       Row(
                         children: [
                           Text('${DateFormat.yMd().format(heritageProvider.heritage.fromDate!)}'
                             ,style: getRegularStyle(color: ColorManager.lightGray,fontSize: Sizer.getW(context)/26),)
                         ],
                       ),

                     ],
                   ),


                 ],
               ),
             const SizedBox(height: AppSize.s20,),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildDetailsRow(context,
                lable: "COMMENTS",
                child:                 IconButton(onPressed: (){}, icon: Icon(Icons.comment,size: Sizer.getW(context) * 0.08,)),
          
                ),
                 buildDetailsRow(context,
                lable: "RATING",
                child:Row(
                  children: [
                    Text("4.5",style:getBoldStyle(color: Theme.of(context).primaryColor,fontSize: Sizer.getW(context) *0.08)),
                    Text("/5",style:getBoldStyle(color: ColorManager.lightGray,fontSize: Sizer.getW(context) *0.04))
                  ],
                )                 
                )
                ,buildDetailsRow(context,
                lable: "REVIEWS",
                child:Row(
                  children: [
                    Text('${heritageProvider.heritage.listUserComment.values.length}'/*"320"*/,style: getBoldStyle(color: Theme.of(context).primaryColor,fontSize: Sizer.getW(context) *0.08)),
                    Text(" comments",style:getBoldStyle(color: ColorManager.lightGray,fontSize: Sizer.getW(context) *0.02))
                  ],
                )                 
                )
             
              ],
             ),
             const SizedBox(height: AppSize.s20,),
      
             ButtonApp(text: "Get Map",onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (ctx)=>MapLocation(
              latitude: heritageProvider.heritage.latitude!,//33.3565978751,
              longitude: heritageProvider.heritage.longitude!,//36.235787455,
             ))), )
              ],
            ),
          ),
        ),
        Positioned(
          top: Sizer.getH(context) / 2.3,
          right: AppSize.s30,
          child: Container(
            width: Sizer.getW(context) * 0.2,
            height: Sizer.getW(context) * 0.2,
            decoration: BoxDecoration(
              color: ColorManager.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: ColorManager.black.withOpacity(.2),blurRadius: 10)
              ]
            ),
            child:StatefulBuilder(builder: ((context, setState2) => IconButton(onPressed: () async {
              isFav = !isFav;
              String collection=AppConstants.collectionHeritage;
              if(heritageProvider.heritage.phone!=null){
                collection=AppConstants.collectionHeritageCategory;
              }
              await heritageProvider.changeUserFavorite(context,isFav, profileProvider.user.id,collection: collection);
              setState2((){});

            }, icon: Icon(isFav?Icons.favorite:Icons.favorite_outline,
            size: isFav?Sizer.getW(context) * 0.125
            :Sizer.getW(context) * 0.08,
            color: isFav ? ColorManager.error: ColorManager.lightGray,
            )
            )) ),
          
          ),
        )
        
      
        ],
      ),
    );
  }

  Widget buildDetailsRow(BuildContext context,{String? lable,Widget? child}) {
    return Column(
              children: [
                Text(lable!,
                textAlign: TextAlign.center,
                style: getRegularStyle(color: ColorManager.lightGray,fontSize: Sizer.getW(context) / 26)),
                  Container(
                      height: Sizer.getW(context) * 0.15,
                      child: child!)
              ],
            );
  }
}

