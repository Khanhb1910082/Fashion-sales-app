import 'package:badges/badges.dart';
import 'package:blackrose/ui/cart/car_manager.dart';
import 'package:blackrose/ui/product/product_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import '../../models/product.dart';
import '../../service/product_service.dart';
import '../screens.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartManager>(context);
    return DefaultTabController(
      //animationDuration: Duration.zero,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
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
              hintText: 'Thời trang công sở',
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
                child: Icon(Icons.chat_outlined)),
          ],
          shadowColor: Theme.of(context).shadowColor,
          bottom: TabBar(
              unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.normal, fontSize: 14.5),
              splashBorderRadius: BorderRadius.circular(30),
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white,
              ),
              tabs: const [
                Tab(
                  text: "Nam",
                ),
                Tab(
                  text: "Nữ",
                ),
                Tab(
                  text: "Phụ kiện",
                ),
              ]),
        ),
        body: StreamBuilder<List<Product>>(
            stream: ProductService.readProduct(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.hasError.toString());
              } else if (snapshot.hasData) {
                final product = snapshot.data!;
                return TabBarView(children: [
                  GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 5,
                              childAspectRatio: 2 / 3.6),
                      children: product
                          .where((item) => item.sex == 'men')
                          .map(buildProduct)
                          .toList()),
                  GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 2 / 3.6),
                      children: product
                          .where((item) => item.sex == 'women')
                          .map(buildProduct)
                          .toList()),
                  GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 2 / 3.6),
                      children: product
                          .where((item) => item.sex == 'null')
                          .map(buildProduct)
                          .toList()),
                ]);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }

  Widget buildProduct(Product product) {
    double height = MediaQuery.of(context).size.height;
    final isfavorite = Provider.of<ProductManager>(context);
    return SizedBox(
      height: 370,
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetail(product)));
                  },
                  child: SizedBox(
                    height: height / 2.9,
                    child:
                        Image.network(product.productUrl[0], fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          // isFavorite ? "Yêu thích" :
                          'Hot',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('favoritelist')
                              .doc(FirebaseAuth.instance.currentUser!.email)
                              .collection(FirebaseAuth
                                  .instance.currentUser!.email
                                  .toString())
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text("Error: ${snapshot.error}");
                            } else if (snapshot.hasData) {
                              bool isFavorite = false;
                              for (int index = 0;
                                  index < snapshot.data!.docs.length;
                                  index++) {
                                if (product.id ==
                                    snapshot.data!.docs[index].get("id")) {
                                  isFavorite = true;
                                  break;
                                }
                              }
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    isfavorite.setFavorite(product);
                                  });
                                },
                                child: Icon(
                                  isFavorite
                                      ? Icons.favorite_sharp
                                      : Icons.favorite_border_outlined,
                                  color: Colors.deepOrange,
                                  size: 28,
                                ),
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                product.productName.toString(),
                textAlign: TextAlign.justify,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            const Expanded(
              child: SizedBox(
                height: 0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${MoneyFormatter(amount: product.newPrice.toDouble()).output.withoutFractionDigits}đ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    'Đã bán ${product.view}',
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
