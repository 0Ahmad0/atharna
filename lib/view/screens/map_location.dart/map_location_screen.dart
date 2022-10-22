import 'package:atharna/controller/profile_provider.dart';
import 'package:atharna/model/sizer.dart';
import 'package:atharna/view/resources/color_manager.dart';
import 'package:atharna/view/resources/style_manager.dart';
import 'package:atharna/view/resources/values_manager.dart';
import 'package:atharna/view/widgets/custome_textfiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:provider/provider.dart';

import '../../../controller/heritage_provider.dart';
import '../../../model/const.dart';

class MapLocation extends StatelessWidget {
  final double latitude ;
  final double longitude ;
  final comment = TextEditingController();
  late HeritageProvider heritageProvider;
  late ProfileProvider profileProvider;
   MapLocation({super.key, required this.latitude, required this.longitude});
  @override
  Widget build(BuildContext context) {
    heritageProvider = Provider.of<HeritageProvider>(context);
    profileProvider = Provider.of<ProfileProvider>(context);
    MapController controller = MapController(
      initMapWithUserPosition: false,
      initPosition: GeoPoint(
          latitude:latitude,
          longitude: longitude
      ),
    );
    return Scaffold(
      bottomSheet: GestureDetector(
        onTap:() async {
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
           
       context: context,
       builder: (context){
       return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.2,
      maxChildSize: .9,
       builder: ((context, scrollController) =>Container(
        decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.s20))
        ),
         padding: const EdgeInsets.all(AppPadding.p12),
         child: Column(
          children: [
           Row(
             children: [
               Expanded(
                 child: CustomTextFiled(controller: comment,
                  validator: (String? val){
                    if(val!.trim().isEmpty){
                      return "type any thing";
                    }
                  }, onChange: null,
                  maxLength: null,
                   prefixIcon: Icons.comment,
                    hintText: "type here.."),
               ),
               const SizedBox(width:  AppSize.s10,),
               InkWell(
                onTap: (){
                  heritageProvider.addComment(context, profileProvider.user.id, comment.text);
                  comment.clear();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle
                  ),
                  padding: const EdgeInsets.all(AppPadding.p14),
                  child: Icon(Icons.send,color: ColorManager.white,size: Sizer.getW(context)*0.05,),
                ))
             ],
           )
         ,Expanded(
           child: ListView.builder(
            controller: scrollController,
            itemCount: heritageProvider.heritage.listUserComment.keys.length,
            itemBuilder: ((context, index)
            {
             return buildComment(context, index);
            }
            ),
           ),
         )
          ],
         ),
       )
      ),  );
  },
);
        },
        child: Container(
          alignment: Alignment.center,
          height: Sizer.getW(context) * 0.2,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor
          ),
          child: Text("Add Comment",style: getRegularStyle(color: ColorManager.white,fontSize: Sizer.getW(context)/22),),
        ),
      ),
      body: SafeArea(
        child: OSMFlutter(
          showZoomController:true,
          controller: controller,
          trackMyPosition: true,
          initZoom: 12,
          minZoomLevel: 8,
          maxZoomLevel: 19,
          stepZoom: 1.0,
          showContributorBadgeForOSM: true,          
          showDefaultInfoWindow: true,
          userLocationMarker: UserLocationMaker(
              personMarker: MarkerIcon(
                icon: Icon(Icons.location_pin,color: Colors.red,size: 48,),
              ),
            directionArrowMarker: MarkerIcon(
              icon: Icon(Icons.location_pin,color: Colors.red,size: 100,),
            ),
          
          ),
        ),
      ),
    );
  }

  Widget buildComment(BuildContext context,int index){
    return Column(
      children: [
        ListTile(
          leading: Transform.scale(
            scale: 1.2,
            child: CircleAvatar(),
          ),
          title: FutureBuilder(
            future: heritageProvider.fetchNameUser(context, idUser: heritageProvider.heritage.listUserComment.keys.elementAt(index)),
            builder: (
                context,
                snapshot,
                ) {
              print(snapshot.error);
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Expanded(child: Const.SHOWLOADINGINDECATOR());
                //Const.CIRCLE(context);
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  // Map<String,dynamic> data=snapshot.data as Map<String,dynamic>;
                  //homeProvider.sessions=Sessions.fromJson(data['body']);
                 /// return const Text('ok');
                  return Text(
                    '${snapshot.data}'
                    /*"My Name ${index+1}"*/,style: getRegularStyle(color: ColorManager.black,fontSize: Sizer.getW(context)/24),);
                } else {
                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            },
          ),
          subtitle: Text('${heritageProvider.heritage.listUserComment[heritageProvider.heritage.listUserComment.keys.elementAt(index)]}'/*"This is Comment ${index+1}"*/,style: getRegularStyle(color: ColorManager.lightGray,fontSize: Sizer.getW(context)/30)),
        ),
        Divider(
          height: 0,
          thickness: .5,
        )
      ],
    );
  }
}