import 'package:flutter/material.dart';
import 'package:latuni/main_screens/category_page.dart';
import 'package:latuni/main_screens/profile_page.dart';
import 'package:latuni/main_screens/store_page.dart';

import '../my_widgets/decorated_container.dart';
import 'cart_page.dart';
import 'home.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  int _selectedIndex = 0;

  List<Widget> pages = [
    const HomePage(),
    const CategoryPage(),
    const StoresPage(),
    const CartPage(),
    const ProfilePage(),
  ];
  void onBottomNavigationTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    var width = size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(child: pages[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        selectedIconTheme: IconThemeData(size: width * .09),
        unselectedItemColor: Colors.grey.shade900,
        iconSize: width * .065,
        selectedItemColor: Colors.red.shade600,
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: onBottomNavigationTap,
        items: <BottomNavigationBarItem>[
          myBottomNavigationBarItem(myIcon: Icons.home, myLabel: 'Home'),
          myBottomNavigationBarItem(myIcon: Icons.search, myLabel: 'search'),
          myBottomNavigationBarItem(
              myIcon: Icons.shop_2_outlined, myLabel: 'store'),
          myBottomNavigationBarItem(
              myIcon: Icons.shopping_cart_outlined, myLabel: 'cart'),
          myBottomNavigationBarItem(myIcon: Icons.person, myLabel: 'profile'),
        ],
      ),
    );
  }

  BottomNavigationBarItem myBottomNavigationBarItem(
      {required IconData myIcon, required String myLabel}) {
    return BottomNavigationBarItem(
      icon: DecoratedContainer(
        backgroundColor: Colors.grey.shade100,
        shadowRightColor: Colors.grey.shade300,
        myChild: Icon(myIcon),
      ),
      label: myLabel,
    );
  }
}
