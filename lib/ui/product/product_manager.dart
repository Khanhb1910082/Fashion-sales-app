import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../models/product.dart';

class ProductManager with ChangeNotifier {
  int favoriteCount = 0;
  bool isFavorite = false;
  setFavoriteCount(int totalItem) {
    favoriteCount = totalItem;
    notifyListeners();
  }

  setIsFavorite(String id) async {
    final collection = FirebaseFirestore.instance
        .collection('favoritelist')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection(FirebaseAuth.instance.currentUser!.email.toString());
    final snapshot = await collection.get();
    for (final doc in snapshot.docs) {
      if (doc.get("id") == id) {
        isFavorite = true;
        notifyListeners();
        break;
      } else {
        isFavorite = false;
        notifyListeners();
      }
    }
  }

  setTotalFavorite() async {
    final collection = FirebaseFirestore.instance
        .collection('favoritelist')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection(FirebaseAuth.instance.currentUser!.email.toString());
    final snapshot = await collection.get();

    setFavoriteCount(snapshot.docs.length);
  }

  void addToFavorite(Product product) {
    favoriteCount += 1;
    notifyListeners();
    final collection = FirebaseFirestore.instance
        .collection('favoritelist')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection(FirebaseAuth.instance.currentUser!.email.toString());

    collection.add(product.toMap());
  }

  void deleteToFavorite(Product product) async {
    favoriteCount -= 1;
    notifyListeners();
    final collection = FirebaseFirestore.instance
        .collection('favoritelist')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection(FirebaseAuth.instance.currentUser!.email.toString());
    final snapshot = await collection.get();
    for (final doc in snapshot.docs) {
      if (doc.get("id") == product.id) {
        doc.reference.delete();
      }
    }
  }

  void clearFavorite() {
    favoriteCount = 0;
    notifyListeners();
  }

  setFavorite(Product product) async {
    bool exits = false;
    final collection = FirebaseFirestore.instance
        .collection('favoritelist')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection(FirebaseAuth.instance.currentUser!.email.toString());
    final snapshot = await collection.get();
    for (final doc in snapshot.docs) {
      if (doc.get("id") == product.id) {
        exits = true;
        break;
      }
    }
    if (exits) {
      deleteToFavorite(product);
    } else {
      addToFavorite(product);
    }
    notifyListeners();
  }
}
