import 'package:blackrose/ui/product/product_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../../service/product_service.dart';
import '../product/product_detail.dart';

class ListItemsWidget extends StatefulWidget {
  const ListItemsWidget({super.key});

  @override
  State<ListItemsWidget> createState() => _ListItemsWidgetState();
}

class _ListItemsWidgetState extends State<ListItemsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: StreamBuilder<List<Product>>(
          stream: ProductService.readProduct(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Có lỗi xảy ra!");
            } else if (snapshot.hasData) {
              final product = snapshot.data!;
              return GridView(
                primary: false,
                padding: const EdgeInsets.only(top: 3),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 2,
                  childAspectRatio: 2 / 3.6,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: product
                    .where((item) => item.type != 'accessory')
                    .map(buidProduct)
                    .toList(),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Widget buidProduct(Product product) {
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
                  child: Image.network(
                    product.productUrl[0],
                    height: 285,
                    fit: BoxFit.cover,
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
              padding: const EdgeInsets.symmetric(horizontal: 6),
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
