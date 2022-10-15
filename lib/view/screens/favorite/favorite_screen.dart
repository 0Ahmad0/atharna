import 'package:atharna/model/sizer.dart';
import 'package:atharna/view/resources/color_manager.dart';
import 'package:atharna/view/resources/font_manager.dart';
import 'package:atharna/view/resources/values_manager.dart';
import 'package:atharna/view/screens/details_discover/details_discover_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p16,
          vertical: AppPadding.p10
        ),
        itemCount: 10,
        itemBuilder: ((_, index) => buildFavoriteItem(context, index)),
      ),
    );
  }
  Widget buildFavoriteItem(BuildContext context,int index){
    return InkWell(
      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (ctx)=>DetailsDiscoverScreen())),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: AppMargin.m12),
            height: Sizer.getW(context) * 0.5,
            padding: const EdgeInsets.all(AppPadding.p14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s14),
              boxShadow: [
                BoxShadow(color: ColorManager.lightGray,blurRadius: AppSize.s8,offset: Offset(0,4))
              ],
              image: DecorationImage(
                fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(ColorManager.black.withOpacity(.35), BlendMode.darken),
                image: AssetImage("assets/1.png")
              )
            ),
            
            ),
          Positioned(
            bottom: Sizer.getH(context) * 0.025,
            right: AppSize.s10,
            child: Container(
              padding: const EdgeInsets.all(AppPadding.p12),
              decoration: BoxDecoration(color: ColorManager.white,shape: BoxShape.circle),
              child: Icon(Icons.favorite,color: ColorManager.error,size: Sizer.getW(context) * 0.08,)),
          ),
    
          Positioned(
            top: AppSize.s10,
            left: AppSize.s10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Sizer.getW(context) / 2,
                  child: Text("Ryadh",style: TextStyle(
                    color: ColorManager.white,
                    fontSize: Sizer.getW(context) / 16,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),),
                ),
                const SizedBox(height: AppSize.s10,),
                  Row(
                    children: [
                      Icon(Icons.location_pin,size: Sizer.getW(context) / 14,color: ColorManager.white,),
                const SizedBox(width: AppSize.s4,),
                      Container(
                      width: Sizer.getW(context) / 2,
                      child: Text("Al_Oula",style: TextStyle(
                        color: ColorManager.white,
                        fontSize: Sizer.getW(context) / 18,
                        fontWeight: FontWeight.w200,
                        overflow: TextOverflow.ellipsis,
                      ),),
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
}