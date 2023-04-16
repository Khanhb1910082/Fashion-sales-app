import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/product.dart';

class ProductService {
  static Stream<List<Product>> readProduct() => FirebaseFirestore.instance
      .collection('products')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Product.fromMap(doc.data())).toList());
  static Stream<List<Product>> readProductFavorite() =>
      FirebaseFirestore.instance
          .collection('favoritelist')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection(FirebaseAuth.instance.currentUser!.email.toString())
          .snapshots()
          .map((snapshot) =>
              snapshot.docs.map((doc) => Product.fromMap(doc.data())).toList());
  static updateTotal(String id, int quantity) async {
    CollectionReference total =
        FirebaseFirestore.instance.collection('products');
    var snapshot = await total.get();
    for (final doc in snapshot.docs) {
      if (doc.get('id') == id) {
        doc.reference.update({'view': doc.get('view') + quantity});
      }
    }
  }
}
