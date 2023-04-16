import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';

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
