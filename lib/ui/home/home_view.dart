import 'dart:async';

import 'package:badges/badges.dart' as badges;
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'package:blackrose/ui/cart/cart_view.dart';

import '../cart/car_manager.dart';
import '../shared/image_icon.dart';
import 'flash_sale.dart';
import 'list_items.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final PageController _pageController = PageController(initialPage: 0);
  final int _numPages = 5;
  int _currentPage = 0;
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < _numPages - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartManager>(context);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black12,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        backgroundColor: const Color.fromARGB(1, 0, 0, 0),
        title: TextField(
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: const Icon(
              Icons.search_outlined,
              size: 25,
              color: Colors.black54,
            ),
            hintMaxLines: 1,
            hintText: 'Nước hoa nữ',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35),
                borderSide: BorderSide.none),
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CartView()));
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
              child: Icon(Icons.chat_outlined)),
        ],
        elevation: 0,
      ),
      body: ListView(padding: const EdgeInsets.all(0), children: [
        Column(
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: width / 1.8,
                      child: PageView(
                        controller: _pageController,
                        children: const [
                          Image(
                            image: AssetImage(
                              'assets/images/banner/banner1.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                          Image(
                            image: AssetImage(
                              'assets/images/banner/banner2.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                          Image(
                            image: AssetImage(
                              'assets/images/banner/banner3.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                          Image(
                            image: AssetImage(
                              'assets/images/banner/banner4.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                          Image(
                            image: AssetImage(
                              'assets/images/banner/banner5.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ],
                        onPageChanged: (value) {
                          setState(() {
                            _currentPage = value;
                          });
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 15,
                      left: width / 2.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            5,
                            (index) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                        color: index == _currentPage
                                            ? Colors.pinkAccent
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(4)),
                                  ),
                                )),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const Text(
                    'Danh mục sản phẩm',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            ImageIconWidget('assets/icons/category/t-shirt.png',
                                'Polo', 't-shirt', 'men'),
                            ImageIconWidget("assets/icons/category/shirt.png",
                                'Shirt', 'shirt', 'men'),
                            ImageIconWidget(
                                "assets/icons/category/trousers.png",
                                'Quần tây',
                                'trousers',
                                'men'),
                            ImageIconWidget("assets/icons/category/jean.png",
                                'Jean', 'jean', 'men'),
                            ImageIconWidget("assets/icons/category/shorts.png",
                                'Shorts', 'shorts', 'men'),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              ImageIconWidget(
                                  "assets/icons/category/t-shirt_women.png",
                                  'Thun',
                                  't-shirt',
                                  'women'),
                              ImageIconWidget(
                                  "assets/icons/category/shirt_women.png",
                                  'shirt',
                                  'shirt',
                                  'women'),
                              ImageIconWidget(
                                  "assets/icons/category/trousers_women.png",
                                  'Quần dài',
                                  'trousers',
                                  'women'),
                              ImageIconWidget("assets/icons/category/dress.png",
                                  'Đầm', 'dress', 'women'),
                              ImageIconWidget(
                                  "assets/icons/category/skirts.png",
                                  'váy',
                                  'skirts',
                                  'women'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: BorderSide(
                    color: Colors.pinkAccent,
                    width: 5,
                  ))),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'FLASH SALE',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Row(
                          children: [
                            const Text(
                              'Xem tất cả',
                              style: TextStyle(fontSize: 15),
                            ),
                            SvgPicture.asset(
                              "assets/icons/angle-right.svg",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const FlashSaleWidget(),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: BorderSide(color: Colors.pinkAccent, width: 5))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Gợi ý hôm nay",
                      style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const ListItemsWidget(),
          ],
        ),
      ]),
    );
  }
}
