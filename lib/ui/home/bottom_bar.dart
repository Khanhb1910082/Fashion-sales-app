import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../screens.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;

  static final List _pages = [
    const HomeView(),
    const ProductView(),
    const NotifitionView(),
    const ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.pink,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Gợi ý hôm nay',
            activeIcon: Icon(Icons.spa),
            tooltip: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_mall_outlined),
            label: 'Cửa hàng',
            activeIcon: Icon(Icons.local_mall),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.bell),
            label: 'Thông báo',
            activeIcon: FaIcon(FontAwesomeIcons.solidBell),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Tài khoản',
            activeIcon: Icon(Icons.account_circle),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
