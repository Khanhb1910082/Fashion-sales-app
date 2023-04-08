import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/product.dart';
import 'productdetaildemo.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> product = [];
  @override
  void initState() {
    fetchProduct();
    super.initState();
  }

  void fetchProduct() async {
    var item = await FirebaseFirestore.instance.collection("products").get();
    mapItems(item);
  }

  void mapItems(QuerySnapshot<Map<String, dynamic>> item) {
    var list = item.docs.map((doc) => Product.fromJson(doc.data())).toList();
    setState(() {
      product = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("San pham"),
      ),
      body: GridView.builder(
        itemCount: product.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductDemo(product[index])));
              },
              child: Text(product[index].productName));
        },
      ),
    );
  }
}
