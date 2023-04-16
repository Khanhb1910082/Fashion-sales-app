import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/cart.dart';

class CartService {
  static Stream<List<Cart>> readCartItem() => FirebaseFirestore.instance
      .collection('cart')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection(FirebaseAuth.instance.currentUser!.email.toString())
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Cart.fromMap(doc.data())).toList());

  static void addCart(Cart cart) async {
    CollectionReference addCart = FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection(FirebaseAuth.instance.currentUser!.email.toString());
    int checkItem = -1;
    var snapshot = await addCart.get();
    for (final doc in snapshot.docs) {
      if (doc.reference.id == cart.id + cart.color + cart.size) {
        checkItem = doc.get('quantity');
        break;
      }
    }
    if (checkItem != -1) {
      addCart
          .doc(cart.id + cart.color + cart.size)
          .update({'quantity': checkItem + cart.quantity});
    } else {
      await addCart.doc(cart.id + cart.color + cart.size).set(cart.toMap());
    }
  }

  static void deleteCart(String id) {
    CollectionReference deleteCart = FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection(FirebaseAuth.instance.currentUser!.email.toString());
    deleteCart.doc(id).delete();
  }
}
