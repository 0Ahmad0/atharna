import 'package:atharna/controller/nav_bar_provider.dart';
import 'package:atharna/view/resources/color_manager.dart';
import 'package:atharna/view/screens/add_ruins/add_ruin_screen.dart';
import 'package:atharna/view/screens/favorite/favorite_screen.dart';
import 'package:atharna/view/screens/home/home_screen.dart';
import 'package:atharna/view/screens/profile/profile_screen.dart';
import 'package:atharna/view/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

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
}