
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iti_final_project/core/resources/app_images.dart';

import '../../core/resources/app_color.dart';
import 'account/view.dart';
import 'cart/view.dart';
import 'explore/view.dart';
import 'home/view.dart';

class HomeNav extends StatefulWidget {
  const HomeNav({super.key});

  @override
  State<HomeNav> createState() => _HomeNav();
}

class _HomeNav extends State<HomeNav> {
  int _selectedIndex = 0;
  List<Widget> screens = [
    HomeSrceen(),
    SearchScreen(),
    CartScreen(),
    AccountScreen()

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: screens.elementAt(_selectedIndex)),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border.all(color:Color(0xffE9E9E9),width: 1),
          borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
        ),

        child: ClipRRect(
          borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
          child: BottomNavigationBar(
            backgroundColor:Colors.white,
            currentIndex: _selectedIndex,
            selectedItemColor: const Color(0xff6055D8),
            selectedFontSize: 16,
            unselectedItemColor: const Color(0xff9E9E9E),
            unselectedFontSize: 14,
            type:BottomNavigationBarType.fixed,
            elevation: 0,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: SvgPicture.asset(AppImages.homeIcon, colorFilter: ColorFilter.mode( _selectedIndex ==0? const Color(0xff6055D8):const Color(0xff9E9E9E), BlendMode.srcIn)), label: 'Home'),
              BottomNavigationBarItem(icon: SvgPicture.asset(AppImages.searchIcon,
                  colorFilter: ColorFilter.mode( _selectedIndex ==1? const Color(0xff6055D8):const  Color(0xff9E9E9E),
                      BlendMode.srcIn))
                  , label: 'Explore'),
              BottomNavigationBarItem(icon: SvgPicture.asset(AppImages.cartIcon,
                  colorFilter: ColorFilter.mode( _selectedIndex == 2 ? const Color(0xff6055D8):const Color(0xff9E9E9E),
                      BlendMode.srcIn)), label: 'Cart'),
              BottomNavigationBarItem(icon: SvgPicture.asset(AppImages.personIcon,
                  colorFilter: ColorFilter.mode( _selectedIndex == 3 ? const Color(0xff6055D8):const Color(0xff9E9E9E),
                      BlendMode.srcIn)), label: 'Account'),

            ],


            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}