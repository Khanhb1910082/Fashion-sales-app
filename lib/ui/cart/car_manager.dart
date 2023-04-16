import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartManager extends ChangeNotifier {
  int cartCount = 0;
  setCartCount(int totalItem) {
    cartCount = totalItem;
    notifyListeners();
  }

  get getItemCount => cartCount;
  setTotalCart() async {
    int sum = 0;
    final collection = FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection(FirebaseAuth.instance.currentUser!.email.toString());
    final snapshot = await collection.get();
    for (final cartProduct in snapshot.docs) {
      sum += cartProduct.get("quantity") as int;
    }
    setCartCount(sum);
  }

  void addToCart(int quantity) {
    cartCount += quantity;
    notifyListeners();
  }

  void deleteToCart(int quantity) {
    cartCount -= quantity;
    notifyListeners();
  }

  void clearCart() {
    cartCount = 0;
    notifyListeners();
  }
}
