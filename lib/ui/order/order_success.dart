import 'package:badges/badges.dart';
import 'package:blackrose/ui/order/confirm_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import '../cart/car_manager.dart';
import '../screens.dart';

class OrderSuccessView extends StatelessWidget {
  const OrderSuccessView(this.status, {super.key});
  final int status;
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartManager>(context);
    return DefaultTabController(
      length: 6,
      initialIndex: status,
      child: Scaffold(
        //backgroundColor: Colors.black12,
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: const Text(
            "Đơn mua",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CartView()));
              },
              child: badges.Badge(
                position: badges.BadgePosition.topEnd(top: -12, end: -12),
                showBadge: true,
                ignorePointer: false,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CartView()));
                },
                badgeContent: Text('${cartProvider.cartCount}'),
                badgeAnimation: const BadgeAnimation.scale(
                  animationDuration: Duration(seconds: 1),
                  colorChangeAnimationDuration: Duration(seconds: 1),
                  loopAnimation: false,
                  curve: Curves.fastOutSlowIn,
                  colorChangeAnimationCurve: Curves.easeInCubic,
                ),
                badgeStyle: badges.BadgeStyle(
                  badgeColor: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(4),
                  elevation: 0,
                ),
                child: const Icon(
                  Icons.shopping_cart_outlined,
                  size: 28,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(Icons.chat_outlined),
            ),
          ],
          shadowColor: Theme.of(context).shadowColor,
          bottom: TabBar(
              isScrollable: true,
              unselectedLabelStyle:
                  const TextStyle(fontWeight: FontWeight.normal),
              splashBorderRadius: BorderRadius.circular(30),
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white,
              ),
              tabs: const [
                Tab(
                  text: "Chờ xác nhận",
                ),
                Tab(
                  text: "Chờ lấy hàng",
                ),
                Tab(
                  text: "Đang giao",
                ),
                Tab(
                  text: "Đã giao",
                ),
                Tab(
                  text: "Đã hủy",
                ),
                Tab(
                  text: "Trả hàng",
                ),
              ]),
        ),
        body: TabBarView(children: [
          ConfirmWidget(0),
          ConfirmWidget(1),
          ConfirmWidget(2),
          ConfirmWidget(3),
          ConfirmWidget(4),
          ConfirmWidget(5),
        ]),
      ),
    );
  }
}
