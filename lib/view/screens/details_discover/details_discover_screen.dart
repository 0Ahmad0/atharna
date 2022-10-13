import 'package:atharna/model/sizer.dart';
import 'package:atharna/view/widgets/custome_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';

class DetailsDiscoverScreen extends StatelessWidget {
bool isFav = false;
String cap = "Jabal AlFil (Elephant Rock), is an amazing geomorphological wonder located 11km northeast of AlUla. A spectacular example of natural erosive forces of water and wind over a period of millions of years, this natural wonder rises 171ft into the air with mountains looming in the background.";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
            Column(
            children: [
              
              Container(
                height: Sizer.getH(context) / 1.8,
                decoration: BoxDecoration(
                  image: DecorationImage(
                  fit:BoxFit.fill,
                  
                    image: AssetImage("assets/1.png"))
                ),
                child: Container(
                  padding: EdgeInsets.all(AppPadding.p12),
                  color: ColorManager.black.withOpacity(.5),
                  child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Text("ElphantMounten",style: TextStyle(
                              color: ColorManager.white,
                              fontSize: Sizer.getW(context) / 18,
                              fontWeight: FontWeight.bold
                            ),),
                          ),
                             const SizedBox(height: AppSize.s4,),
                          Row(
                            children: [
                              Icon(Icons.location_pin,color: ColorManager.white,size: Sizer.getW(context)*0.075 ,),
                              Flexible(child: Text("Al-Ula",style: TextStyle(color: ColorManager.white,fontSize: Sizer.getW(context) / 24),))
                            ],
                          )
                    ,SizedBox(height: Sizer.getW(context) * 0.1,)
                        ]),
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
          height: Sizer.getH(context) / 2,
          decoration: BoxDecoration(color: ColorManager.white,borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.s50),),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
                Text("Description",style: TextStyle(
            color: ColorManager.black,
            fontSize: Sizer.getW(context) / 16,
            fontWeight: FontWeight.bold
           ),),
           const SizedBox(height: AppSize.s20,),
           Text(cap,style: TextStyle(color: ColorManager.lightGray,
           fontSize: Sizer.getW(context) / 24,
           height: 1.3
           ),),
           const SizedBox(height: AppSize.s40,),
           Expanded(child: Row(
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
                  Text("4.5",style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: Sizer.getW(context) * 0.08,
                    fontWeight: FontWeight.bold
                  ),),
                  Text("/5",style: TextStyle(
                    color: ColorManager.lightGray,
                    fontSize: Sizer.getW(context) * 0.04,                    
                  ),)
                ],
              )                 
              )
              ,buildDetailsRow(context,
              lable: "REVIEWS",
              child:Row(
                children: [
                  Text("320",style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: Sizer.getW(context) * 0.08,
                    fontWeight: FontWeight.bold
                  ),),
                  Text(" comments",style: TextStyle(
                    color: ColorManager.lightGray,
                    fontSize: Sizer.getW(context) * 0.025,                    
                  ),)
                ],
              )                 
              )
           
            ],
           )),
           ButtonApp(text: "Get Map", onTap: (){})
            ],
          ),
        ),
        Positioned(
          top: Sizer.getH(context) / 2.2,
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
            child:StatefulBuilder(builder: ((context, setState2) => IconButton(onPressed: (){
              isFav = !isFav;
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
                style: TextStyle(
                  color: ColorManager.lightGray,
                  fontWeight: FontWeight.bold,fontSize: Sizer.getW(context) / 26),),
                  child!
              ],
            );
  }
}