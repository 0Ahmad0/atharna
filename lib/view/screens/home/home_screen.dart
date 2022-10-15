import 'package:atharna/controller/home_provider.dart';
import 'package:atharna/model/sizer.dart';
import 'package:atharna/view/resources/color_manager.dart';
import 'package:atharna/view/resources/values_manager.dart';
import 'package:atharna/view/screens/details_discover/details_discover_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  List<String> word = [
    "All",
    "Madinah",
    "Asser",
    "Riyhad",
    "Jazan",
    "Alshrqe"
  ];
  HomeProvider homeProvider = HomeProvider();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p16,
          vertical: AppPadding.p10
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildAppBarHome(context),

           const SizedBox(height: AppSize.s10,),
           
           Text("Discover",style: TextStyle(
            color: ColorManager.black,
            fontSize: Sizer.getW(context) / 16,
            fontWeight: FontWeight.bold
           ),),
           const SizedBox(height: AppSize.s10,),

           ChangeNotifierProvider<HomeProvider>.value(
            value: HomeProvider(),
            child: Consumer<HomeProvider>(
              builder: (context, value, child) => SizedBox(
                height: Sizer.getW(context)*0.1,
                child: ListView.builder(
              scrollDirection: Axis.horizontal,
                          itemCount: word.length,
                          itemBuilder: ((context, index) =>  InkWell(
                        onTap: (){
                        value.changeIndex(index);
                        print(value.selectIndex);
                        },
                        child: AnimatedContainer(
                          alignment: Alignment.center,
                          width: Sizer.getH(context)*0.1,
                                      duration: const Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.s4),
                            color: value.selectIndex==index?
                            Theme.of(context).primaryColor:Colors.transparent,
                          ),
                          padding: const EdgeInsets.all(AppPadding.p4),
                          margin:  EdgeInsets.only(left:index==0?0:AppMargin.m4),
                          child: Text(word[index],
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: value.selectIndex==index 
                          ?ColorManager.white:ColorManager.black),),
                        ),
                      )
                 ),
                        ),)),
            ),
           
            const SizedBox(height: AppSize.s10,),
            buildDiscover(context),
           const SizedBox(height: AppSize.s10,),
           Text("Categories",style: TextStyle(
            color: ColorManager.black,
            fontSize: Sizer.getW(context) / 16,
            fontWeight: FontWeight.bold
           ),),
           const SizedBox(height: AppSize.s10,),

           buildCategories(context),
           const SizedBox(height: AppSize.s10,),
             Text("Learn More",style: TextStyle(
            color: ColorManager.black,
            fontSize: Sizer.getW(context) / 16,
            fontWeight: FontWeight.bold
           ),),
           const SizedBox(height: AppSize.s10,),

            buildLearnMore(context),
           const SizedBox(height: AppSize.s10,),
           
    
           ],
        ),
      ),
    );
  }
   Widget buildCategories(BuildContext context) {
    return SizedBox(
      height: Sizer.getW(context) * 0.3,
      child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.all(AppPadding.p12),
              margin: EdgeInsets.only(left: index==0?0:AppMargin.m12),
              width: Sizer.getW(context) / 1.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s14),
                image: DecorationImage(
       fit: BoxFit.fill,
       image: AssetImage("assets/1.png")
                )
              ),
               )),
    );
  }

 Widget buildLearnMore(BuildContext context) {
    return Expanded(
      flex: 2,
      child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.all(AppPadding.p12),
              margin: EdgeInsets.only(left: index==0?0:AppMargin.m12),
              width: Sizer.getW(context) / 1.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s14),
                image: DecorationImage(
       fit: BoxFit.fill,
       image: AssetImage("assets/1.png")
                )
              ),
               )),
    );
  }

  Widget buildDiscover(BuildContext context) {
    return Expanded(
      flex: 3,
      child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) => GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (ctx)=>
                DetailsDiscoverScreen()));
              },
              child: Container(
                padding: const EdgeInsets.all(AppPadding.p12),
                margin: EdgeInsets.only(left: index==0?0:AppMargin.m12),
                width: Sizer.getW(context) / 1.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s14),
                  image: DecorationImage(
                   fit: BoxFit.fill,
                   image: AssetImage("assets/1.png")
                  )
                ),
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
                  ]),
              ),
            )),
    );
  }

  Row buildAppBarHome(BuildContext context) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: (){
                Scaffold.of(context).openDrawer();
              }, icon: Icon(Icons.menu)),
              Container(
                width: Sizer.getW(context) * 0.125,
                height: Sizer.getW(context) * 0.125,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s4),
                  color: ColorManager.lightGray
                ),
              )
            ],
          );
  }
}