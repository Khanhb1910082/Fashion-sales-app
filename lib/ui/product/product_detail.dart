import 'package:blackrose/ui/product/product_bottom.dart';
import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';

import '../../models/product.dart';
import '../home/flash_sale.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail(this.product, {super.key});
  final Product product;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    int tapItem = 0;
    return Scaffold(
      backgroundColor: const Color.fromARGB(209, 255, 255, 255),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black12,
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: NetworkImage(widget.product.productUrl[0]),
              fit: BoxFit.fitWidth,
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      itemCount: widget.product.productUrl.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 8),
                          // decoration: BoxDecoration(
                          //     border: Border.all(
                          //         color: Colors.black12,
                          //         style: BorderStyle.solid)),
                          child: InkWell(
                            onTap: () {
                              setState(
                                () {
                                  tapItem = index;
                                },
                              );
                            },
                            child: Expanded(
                              child: Image(
                                image: NetworkImage(
                                    widget.product.productUrl[index]),
                                width: 100,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      widget.product.productName,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${MoneyFormatter(amount: widget.product.oldPrice.toDouble()).output.withoutFractionDigits}đ',
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${MoneyFormatter(amount: widget.product.newPrice.toDouble()).output.withoutFractionDigits}đ',
                        style: const TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: const BoxDecoration(),
                    child: const Text(
                      'Mô tả:',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Text(
                    widget.product.describe.toString(),
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Sản phẩm liên quan',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                          fontSize: 18),
                    ),
                  ),
                  FlashSaleWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const ProductBottom(),
    );
  }
}
