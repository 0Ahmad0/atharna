import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class NavBarView extends StatelessWidget {
  const NavBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
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
    child: BottomNavigationBar(                                                
      items: const <BottomNavigationBarItem>[                                        
        BottomNavigationBarItem(                                               
          icon: Icon(Icons.favorite), label: 'Favourite'),               
        BottomNavigationBarItem(                                               
          icon: Icon(Icons.favorite), label: 'Favourite')                
      ],                                                                       
    ),                                                                         
  )                                                                            
),
    );
  }
}