import 'package:blackrose/ui/product/product_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../product/product_detail.dart';

class ProductFilterView extends StatefulWidget {
  const ProductFilterView(this.product, {super.key});
  final Product product;
  @override
  State<ProductFilterView> createState() => _ProductFilterViewState();
}

class _ProductFilterViewState extends State<ProductFilterView> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return StreamBuilder<List<Product>>(
        stream: FirebaseFirestore.instance
            .collection('products')
            .snapshots()
            .map((snapshot) => snapshot.docs
                .where((item) =>
                    item.get("type") == widget.product.type &&
                    item.get('id') != widget.product.id &&
                    item.get("sex") == widget.product.sex)
                .map((doc) => Product.fromMap(doc.data()))
                .toList()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Có lỗi xảy ra!");
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final product = snapshot.data!;
            return GridView(
              padding: const EdgeInsets.only(top: 3),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3.6,
              ),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: product.map(buidProduct).toList(),
            );
          } else {
            return SizedBox(
              height: width / 1.5,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                        image: const AssetImage("assets/images/no_item.png"),
                        height: width / 3,
                        width: width / 3),
                    const Text("Không tìm thấy sản phẩm phù hợp.")
                  ],
                ),
              ),
            );
          }
        });
  }

  Widget buidProduct(Product product) {
    final isfavorite = Provider.of<ProductManager>(context);
    double height = MediaQuery.of(context).size.height;
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
                  child: SizedBox(
                    height: height / 3,
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
              padding: const EdgeInsets.all(10),
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
