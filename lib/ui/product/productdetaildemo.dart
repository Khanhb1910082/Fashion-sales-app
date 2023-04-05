import 'package:flutter/material.dart';

import '../../models/product.dart';

class ProductDemo extends StatelessWidget {
  const ProductDemo(this.product, {super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(product.productName),
          Text(product.productUrl[0]),
        ],
      ),
    );
  }
}
