import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../shared/image_icon.dart';
import 'flash_sale.dart';
import 'list_items.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        backgroundColor: const Color.fromARGB(1, 0, 0, 0),
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          height: 35,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const TextField(
            decoration: InputDecoration(
              icon: Icon(
                Icons.search_outlined,
                size: 25,
                color: Colors.pink,
              ),
              hintText: 'Nước hoa nữ',
              border: InputBorder.none,
            ),
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(
              Icons.shopping_cart_outlined,
              size: 28,
            ),
          ),
          Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(Icons.chat_outlined)),
        ],
        elevation: 0,
      ),
      body: ListView(padding: const EdgeInsets.all(0), children: [
        Column(
          children: [
            const Image(
              image: AssetImage(
                'assets/images/banner/banner2.png',
              ),
              fit: BoxFit.cover,
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
                            ImageIconWidget(
                                'assets/icons/category/t-shirt.png', 'Polo'),
                            ImageIconWidget(
                                "assets/icons/category/shirt.png", 'Shirt'),
                            ImageIconWidget(
                                "assets/icons/category/trousers.png",
                                'Quần tây'),
                            ImageIconWidget(
                                "assets/icons/category/jean.png", 'Jean'),
                            ImageIconWidget(
                                "assets/icons/category/shorts.png", 'Shorts'),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              ImageIconWidget(
                                  "assets/icons/category/t-shirt_women.png",
                                  'Thun'),
                              ImageIconWidget(
                                  "assets/icons/category/shirt_women.png",
                                  'shirt'),
                              ImageIconWidget(
                                  "assets/icons/category/trousers_women.png",
                                  'Quần dài'),
                              ImageIconWidget(
                                  "assets/icons/category/dress.png", 'Đầm'),
                              ImageIconWidget(
                                  "assets/icons/category/skirts.png", 'váy'),
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
