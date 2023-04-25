import 'package:blackrose/ui/product/product_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../../service/product_service.dart';
import '../screens.dart';

class ProductCategoryView extends StatefulWidget {
  const ProductCategoryView(this.title, this.type, this.sex, {super.key});
  final String type;
  final String sex;
  final String title;
  @override
  State<ProductCategoryView> createState() => _ProductCategoryViewState();
}

class _ProductCategoryViewState extends State<ProductCategoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<List<Product>>(
          stream: ProductService.readProduct(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Có lỗi xảy ra!");
            } else if (snapshot.hasData) {
              final product = snapshot.data!;
              return GridView(
                padding: const EdgeInsets.only(top: 3),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3.6,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: product
                    .where((item) =>
                        item.type == widget.type && item.sex == widget.sex)
                    .map(buidProduct)
                    .toList(),
              );
            } else {
              return const Center(
                child: Text("Sản phẩm hiện chưa được trưng bày"),
              );
            }
          }),
    );
  }

  Widget buidProduct(Product product) {
    final isfavorite = Provider.of<ProductManager>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
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
                  height: height / 3,
                  width: width,
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
                            .collection(FirebaseAuth.instance.currentUser!.email
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
            padding: const EdgeInsets.all(10),
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
    );
  }
}
