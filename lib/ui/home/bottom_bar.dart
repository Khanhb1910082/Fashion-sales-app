import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../cart/car_manager.dart';
import '../order/order_manager.dart';
import '../product/product_manager.dart';
import '../screens.dart';

class BottomBar extends StatefulWidget {
  const BottomBar(this.page, {super.key});
  final int page;
  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  late int _selectedIndex = widget.page;
  void _setProvider() async {
    final cartProvider = Provider.of<CartManager>(context, listen: false);
    final orderProvider = Provider.of<OrderManager>(context, listen: false);
    final favoriteCount = Provider.of<ProductManager>(context, listen: false);
    await cartProvider.setTotalCart();
    await orderProvider.setTotalOrder();
    await favoriteCount.setTotalFavorite();
  }

  @override
  void initState() {
    super.initState();
    _setProvider();
    ChangeNotifier;
  }

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
    final orderProvider = Provider.of<OrderManager>(context);
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.pink,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Gợi ý hôm nay',
            activeIcon: Icon(Icons.spa),
            tooltip: "Home",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.local_mall_outlined),
            label: 'Cửa hàng',
            activeIcon: Icon(Icons.local_mall),
          ),
          BottomNavigationBarItem(
            icon: Badge(
                isLabelVisible: orderProvider.badgeNoti(),
                child: const FaIcon(FontAwesomeIcons.bell)),
            label: 'Thông báo',
            activeIcon: const FaIcon(FontAwesomeIcons.solidBell),
          ),
          const BottomNavigationBarItem(
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
