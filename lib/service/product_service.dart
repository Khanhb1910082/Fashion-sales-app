import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductService {
  static Stream<List<Product>> readProduct() => FirebaseFirestore.instance
      .collection('products')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Product.fromJson(doc.data())).toList());
}
