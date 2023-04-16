import 'package:badges/badges.dart';
import 'package:blackrose/service/user_service.dart';
import 'package:blackrose/ui/cart/car_manager.dart';
import 'package:blackrose/ui/order/order_manager.dart';
import 'package:blackrose/ui/order/order_success.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import '../../models/user.dart';
import '../login/login_view.dart';
import '../product/product_manager.dart';
import '../screens.dart';
import 'favorite_list.dart';
import 'profile_detail.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final cartProvider = Provider.of<CartManager>(context);

    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
          backgroundColor: Colors.pink,
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
                padding: EdgeInsets.only(right: 12, top: 16),
                child: Icon(Icons.chat_outlined)),
          ],
          bottom: PreferredSize(
              preferredSize: Size(width, width / 5),
              child: StreamBuilder<List<Users>>(
                stream: UserService.readUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text("Lỗi người dùng"));
                  } else if (snapshot.hasData) {
                    final user = snapshot.data!;
                    return Column(
                      children: user.map(_buidAvataField).toList(),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ))),
      body: StreamBuilder(
          stream: UserService.readUser(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text("Lỗi người dùng"));
            } else if (snapshot.hasData) {
              final user = snapshot.data!;
              return Column(
                children: user.map(_buidUserService).toList(),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Widget _buidAvataField(Users user) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Column(
          children: [
            Container(
              margin: const EdgeInsets.all(8),
              width: width / 5,
              height: width / 5,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(width),
                  image: const DecorationImage(
                      image: AssetImage("assets/images/profile.jpg"),
                      fit: BoxFit.cover)),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Row(
                  children: const [
                    Text(
                      "Thành viên",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black,
                      size: 11,
                    ),
                  ],
                )),
            Row(
              children: const [
                Text(
                  "BlackRose Pay",
                  style: TextStyle(color: Colors.white),
                ),
                Padding(
                  padding: EdgeInsets.all(2),
                  child: Icon(
                    Icons.done,
                    size: 20,
                    color: Colors.green,
                  ),
                )
              ],
            ),
          ],
        )
      ],
    );
  }

  Widget _buidUserService(Users user) {
    final cartProvider = Provider.of<CartManager>(context);
    final orderProvider = Provider.of<OrderManager>(context);
    final favoriteCount = Provider.of<ProductManager>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              color: Colors.white,
              border:
                  Border(bottom: BorderSide(color: Colors.black, width: 2))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                      height: 30,
                      width: 30,
                      child:
                          SvgPicture.asset("assets/icons/profile/order.svg")),
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text("Đơn mua"),
                  ),
                ],
              ),
              const Text("Lịch sử mua hàng"),
            ],
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const OrderSuccessView(0)));
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      badges.Badge(
                        position:
                            badges.BadgePosition.topEnd(top: -12, end: -12),
                        showBadge:
                            orderProvider.confirmCount == 0 ? false : true,
                        ignorePointer: false,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const OrderSuccessView(0)));
                        },
                        badgeContent: Text(
                          '${orderProvider.confirmCount}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        badgeAnimation: const BadgeAnimation.scale(
                          animationDuration: Duration(seconds: 1),
                          colorChangeAnimationDuration: Duration(seconds: 1),
                          loopAnimation: false,
                          curve: Curves.fastOutSlowIn,
                          colorChangeAnimationCurve: Curves.easeInCubic,
                        ),
                        badgeStyle: badges.BadgeStyle(
                          badgeColor: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                          elevation: 0,
                        ),
                        child: Container(
                            margin: const EdgeInsets.only(left: 12),
                            height: 30,
                            width: 30,
                            child: SvgPicture.asset(
                                "assets/icons/profile/confirm.svg")),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: const Text(
                            "Chờ xác nhận",
                            style: TextStyle(
                                fontSize: 11, fontWeight: FontWeight.w500),
                          )),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const OrderSuccessView(1)));
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      badges.Badge(
                        position:
                            badges.BadgePosition.topEnd(top: -12, end: -12),
                        showBadge: orderProvider.waitCount == 0 ? false : true,
                        ignorePointer: false,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const OrderSuccessView(1)));
                        },
                        badgeContent: Text(
                          '${orderProvider.waitCount}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        badgeAnimation: const BadgeAnimation.scale(
                          animationDuration: Duration(seconds: 1),
                          colorChangeAnimationDuration: Duration(seconds: 1),
                          loopAnimation: false,
                          curve: Curves.fastOutSlowIn,
                          colorChangeAnimationCurve: Curves.easeInCubic,
                        ),
                        badgeStyle: badges.BadgeStyle(
                          badgeColor: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                          elevation: 0,
                        ),
                        child: Container(
                            margin: const EdgeInsets.only(left: 12),
                            height: 30,
                            width: 30,
                            child: SvgPicture.asset(
                                "assets/icons/profile/package.svg")),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: const Text(
                            "Chờ lấy hàng",
                            style: TextStyle(
                                fontSize: 11, fontWeight: FontWeight.w500),
                          )),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const OrderSuccessView(2)));
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      badges.Badge(
                        position:
                            badges.BadgePosition.topEnd(top: -12, end: -12),
                        showBadge:
                            orderProvider.transportCount == 0 ? false : true,
                        ignorePointer: false,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const OrderSuccessView(2)));
                        },
                        badgeContent: Text(
                          '${orderProvider.transportCount}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        badgeAnimation: const BadgeAnimation.scale(
                          animationDuration: Duration(seconds: 1),
                          colorChangeAnimationDuration: Duration(seconds: 1),
                          loopAnimation: false,
                          curve: Curves.fastOutSlowIn,
                          colorChangeAnimationCurve: Curves.easeInCubic,
                        ),
                        badgeStyle: badges.BadgeStyle(
                          badgeColor: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                          elevation: 0,
                        ),
                        child: Container(
                            margin: const EdgeInsets.only(left: 12),
                            height: 30,
                            width: 30,
                            child: SvgPicture.asset(
                                "assets/icons/profile/go.svg")),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: const Text(
                            "Đang giao",
                            style: TextStyle(
                                fontSize: 11, fontWeight: FontWeight.w500),
                          )),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const OrderSuccessView(3)));
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      badges.Badge(
                        position:
                            badges.BadgePosition.topEnd(top: -12, end: -12),
                        showBadge:
                            orderProvider.evaluateCount == 0 ? false : true,
                        ignorePointer: false,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const OrderSuccessView(3)));
                        },
                        badgeContent: Text(
                          '${orderProvider.evaluateCount}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        badgeAnimation: const BadgeAnimation.scale(
                          animationDuration: Duration(seconds: 1),
                          colorChangeAnimationDuration: Duration(seconds: 1),
                          loopAnimation: false,
                          curve: Curves.fastOutSlowIn,
                          colorChangeAnimationCurve: Curves.easeInCubic,
                        ),
                        badgeStyle: badges.BadgeStyle(
                          badgeColor: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                          elevation: 0,
                        ),
                        child: Container(
                            margin: const EdgeInsets.only(left: 12),
                            height: 30,
                            width: 30,
                            child: SvgPicture.asset(
                                "assets/icons/profile/star.svg")),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: const Text(
                            "Đánh giá",
                            style: TextStyle(
                                fontSize: 11, fontWeight: FontWeight.w500),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Sản phẩm đã mua"),
                Text("Xem tất cả"),
              ],
            )),
        const SizedBox(height: 10),
        InkWell(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ProfileDetail(user)));
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: SizedBox(
                          height: 30,
                          width: 30,
                          child: Icon(
                            Icons.person_sharp,
                            color: Colors.cyan,
                            size: 30,
                          )),
                    ),
                    Text("Thông tin cá nhân"),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
              color: Colors.white,
              border: Border.symmetric(
                  horizontal: BorderSide(color: Colors.black12))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: SizedBox(
                        height: 30,
                        width: 30,
                        child:
                            SvgPicture.asset("assets/icons/profile/medal.svg")),
                  ),
                  const Text("Khách hàng thân thiết"),
                ],
              ),
              const Text("Thành viên"),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const FavoriteListView()));
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: SizedBox(
                          height: 30,
                          width: 30,
                          child: Icon(
                            Icons.favorite,
                            color: Colors.pink,
                            size: 30,
                          )),
                    ),
                    Text("Yêu thích"),
                  ],
                ),
                Text('${favoriteCount.favoriteCount}'),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            FirebaseAuth.instance.signOut().then((value) {
              favoriteCount.clearFavorite();
              cartProvider.clearCart();
              orderProvider.clearOrder();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginView()),
                  (route) => false);
            });
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(color: Colors.white70),
            child: const Center(
              child: Text(
                "Đăng xuất",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.black87),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
