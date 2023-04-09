import 'package:blackrose/ui/cart/cart_view.dart';
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
  int tapItem = 0;
  @override
  void initState() {
    widget.product.productUrl;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(5, 0, 0, 0),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const CartView()));
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(
                Icons.shopping_cart_outlined,
                size: 28,
              ),
            ),
          ),
          const Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(Icons.chat_outlined)),
        ],
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          SizedBox(
            width: width,
            child: Image(
              image: NetworkImage(widget.product.productUrl[tapItem]),
              fit: BoxFit.contain,
            ),
          ),
          Center(
            child: SizedBox(
              height: 120,
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ListView.builder(
                        itemCount: widget.product.productUrl.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                tapItem = index;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: tapItem == index
                                      ? Colors.pink
                                      : Colors.black12,
                                  width: 3,
                                ),
                              ),
                              child: Image(
                                image: NetworkImage(
                                    widget.product.productUrl[index]),
                                height: 100,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width * 8 / 10,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        widget.product.productName,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const Icon(
                      Icons.favorite_border_outlined,
                      color: Colors.deepOrange,
                      size: 32,
                    ),
                  ],
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
      bottomNavigationBar: ProductBottom(widget.product),
    );
  }
}
