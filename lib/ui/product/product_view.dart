import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';

import '../../models/product.dart';
import '../../service/product_service.dart';
import 'product_detail.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      //animationDuration: Duration.zero,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
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
                ),
                hintText: 'Thời trang công sở',
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
                              crossAxisCount: 2, childAspectRatio: 2 / 3.6),
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
    return SizedBox(
      height: 370,
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductDetail(product)));
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 5),
                constraints: const BoxConstraints.expand(
                  width: 250,
                  height: 290,
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(product.productUrl[0]),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Padding(
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
                          "- 10%",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Icon(Icons.favorite_border, color: Colors.red),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              alignment: Alignment.centerLeft,
              child: Text(
                product.productName.toString(),
                textAlign: TextAlign.justify,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
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
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
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
