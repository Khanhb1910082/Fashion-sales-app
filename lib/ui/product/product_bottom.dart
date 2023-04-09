import 'package:blackrose/models/product.dart';
import 'package:flutter/material.dart';

import 'custom_bottom_sheet.dart';

class ProductBottom extends StatefulWidget {
  const ProductBottom(this.product, {super.key});
  final Product product;

  @override
  State<ProductBottom> createState() => _ProductBottomState();
}

class _ProductBottomState extends State<ProductBottom> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        height: 50,
        decoration: const BoxDecoration(color: Colors.deepOrange),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              decoration: const BoxDecoration(
                  color: Colors.green,
                  border: Border(right: BorderSide(color: Colors.deepOrange))),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.only(right: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.chat_outlined),
                        Text("Liên hệ"),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) {
                            return CustomBottomSheet(
                                widget.product, "Thêm vào giỏ");
                          });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.shopping_cart_checkout_outlined),
                          Text("Thêm vào giỏ"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return CustomBottomSheet(widget.product, "Đặt hàng");
                    });
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: const [
                    SizedBox(
                      width: 80,
                    ),
                    Text(
                      "Đặt hàng",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
