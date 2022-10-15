import 'package:atharna/controller/nav_bar_provider.dart';
import 'package:atharna/view/resources/color_manager.dart';
import 'package:atharna/view/screens/add_ruins/add_ruin_screen.dart';
import 'package:atharna/view/screens/auth/login_screen.dart';
import 'package:atharna/view/screens/favorite/favorite_screen.dart';
import 'package:atharna/view/screens/home/home_screen.dart';
import 'package:atharna/view/screens/profile/profile_screen.dart';
import 'package:atharna/view/screens/search/search_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../controller/dprofile_provider.dart';
import '../../../model/const.dart';
import '../../../model/sizer.dart';
import '../../resources/style_manager.dart';
import '../../resources/values_manager.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  int currentIndex = 0;
  List<Map<String,dynamic>> _screens = [];

  @override
  void initState() {
    _screens = [
      {
        "name": "Home",
        "content": HomeScreen()
      },
         {
        "name": "Search",
        "content": SearchScreen()
      },
         {
        "name": "Add Ruins",
        "content": AddRuinScreen()
      },
         {
        "name": "Favorite",
        "content": FavoriteScreen()
      },
         {
        "name": "Profile",
        "content": ProfileScreen()
      },
    ];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final currentPage = Provider.of<NavBarProvider>(context);
    return Scaffold(
        drawer: Drawer(
              child: Column(
                children: [
                    UserAccountsDrawerHeader(
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor
                              ),
                              margin: EdgeInsets.zero,
                              accountName: Text(
                               "Ahmad",
                                style: getRegularStyle(
                                    color: ColorManager.white,
                                    fontSize: Sizer.getW(context) / 24),
                              ),
                              accountEmail: Text(
                               "Ahmad@gmail.com",
                                style: getLightStyle(
                                    color: ColorManager.white,
                                    fontSize: Sizer.getW(context) / 28),
                              ),
                              currentAccountPicture: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                    shape: BoxShape.circle,
                                ),
                                child:ClipOval(
                                  child: CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    width: Sizer.getW(context) * 0.12,
                                    height: Sizer.getW(context) * 0.12,
                                    imageUrl:"https://static.remove.bg/remove-bg-web/c05ac62d076574fad1fbc81404cd6083e9a4152b/assets/start_remove-c851bdf8d3127a24e2d137a55b1b427378cd17385b01aec6e59d5d4b5f39d2ec.png",
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).primaryColor,
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                              //    colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                            ),
                                          ),
                                        ),
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                )
                              ),
                            ),
                     
                  _buildListTile(
                    text: "Item1",
                    icon: Icons.settings,
                    onTap: (){
                      Navigator.pop(context);
                      // Navigator.push(context, MaterialPageRoute(builder: (ctx)=>SettingView()));
                    },
                  ),
               
                  Divider(
                    thickness: AppSize.s1_5,
                    height: 0.0,
                  ),
                  _buildListTile(
                    text: "Log out",
                    icon: Icons.logout,
                    onTap: () async {
                      Const.SHOWLOADINGINDECATOR();
                      // await profileProvider.logout(context);
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>LoginScreen()));
                    },

                  ),
                ],
              ),
            ),
            
      body: _screens[currentPage.currentIndex]['content'],
      bottomNavigationBar: Container(                                             
  decoration: BoxDecoration(                                                   
    borderRadius: BorderRadius.only(                                           
      topRight: Radius.circular(30), topLeft: Radius.circular(30)),            
    boxShadow: [                                                               
      BoxShadow(color: Colors.black38.withOpacity(.1), spreadRadius: 0, blurRadius: 10),       
    ],                                                                         
  ),                                                                           
  child: ClipRRect(                                                            
    borderRadius: BorderRadius.only(                                           
    topLeft: Radius.circular(30.0),                                            
    topRight: Radius.circular(30.0),                                           
    ),                                                                         
    child: Consumer<NavBarProvider>(
      builder: (context, selectIndex, child) => BottomNavigationBar(    
      currentIndex: selectIndex.currentIndex,
      onTap: (index)=>selectIndex.changeIndex(index),    
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: ColorManager.lightGray,                                        
      items: const <BottomNavigationBarItem>[                                        
        BottomNavigationBarItem(                                               
          icon: Icon(Icons.home), label: 'Home'),               
        BottomNavigationBarItem(                                               
          icon: Icon(Icons.search), label: 'search'),   
            BottomNavigationBarItem(                                               
          icon: Icon(Icons.add_a_photo), label: 'Add'),   
            BottomNavigationBarItem(                                               
          icon: Icon(Icons.favorite), label: 'Favorite'),   
            BottomNavigationBarItem(                                               
          icon: Icon(Icons.person), label: 'Profile'),                
      ],                                                                       
    ) ,
    ))
    )                                                                            

    );
  }
   Widget _buildListTile({text, icon, onTap}) {
    return ListTile(
      minVerticalPadding: AppPadding.p18,
      title: Text(
        text,
        style: getRegularStyle(
            color: Theme.of(context).textTheme.bodyText1!.color,
            fontSize: Sizer.getW(context) / 26),
      ),
      onTap: onTap,
      leading: Icon(icon),
    );
  }
}