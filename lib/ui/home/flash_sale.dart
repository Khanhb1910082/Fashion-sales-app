import 'package:blackrose/models/product.dart';
import 'package:blackrose/service/product_service.dart';
import 'package:blackrose/ui/product/product_detail.dart';
import 'package:blackrose/ui/product/product_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:provider/provider.dart';

class FlashSaleWidget extends StatefulWidget {
  const FlashSaleWidget({super.key});

  @override
  State<FlashSaleWidget> createState() => _FlashSaleWidgetState();
}

class _FlashSaleWidgetState extends State<FlashSaleWidget> {
  late Stream<List<Product>> _product;
  @override
  void initState() {
    super.initState();
    _product = ProductService.readProduct();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>>(
      stream: _product,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final product = snapshot.data!;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: product
                  .where((item) => item.type == 'accessory')
                  .map(_buildFlashSale)
                  .toList(),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildFlashSale(Product product) {
    final isfavorite = Provider.of<ProductManager>(context);
    return SizedBox(
      height: 250,
      width: 180,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ProductDetail(product)));
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 5),
                constraints: const BoxConstraints.expand(
                  width: 180,
                  height: 180,
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(product.productUrl[0].toString()),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
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
                          "Sale",
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
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
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
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
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
                    'Đã bán ${product.view.toString()}',
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
