import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderManager extends ChangeNotifier {
  int confirmCount = 0;
  int waitCount = 0;
  int transportCount = 0;
  int evaluateCount = 0;
  setOrderCount(int confirm, int wait, int transport, int evaluate) {
    confirmCount = confirm;
    waitCount = wait;
    transportCount = transport;
    evaluateCount = evaluate;
    notifyListeners();
  }

  setTotalOrder() async {
    int confirm = 0;
    int wait = 0;
    int transport = 0;
    int evaluate = 0;
    final collection = FirebaseFirestore.instance
        .collection('orders')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection(FirebaseAuth.instance.currentUser!.email.toString());
    final snapshot = await collection.get();
    for (final orderProduct in snapshot.docs) {
      if (orderProduct.get("status") == 0) {
        confirm += 1;
      } else if (orderProduct.get("status") == 1) {
        wait += 1;
      } else if (orderProduct.get("status") == 2) {
        transport += 1;
      } else if (orderProduct.get("status") == 3) {
        evaluate += 1;
      }
    }
    setOrderCount(confirm, wait, transport, evaluate);
  }

  void addToConfirm() {
    confirmCount += 1;
    notifyListeners();
  }

  void deleteToConfirm() {
    confirmCount -= 1;
    notifyListeners();
  }

  void addToWait() {
    waitCount += 1;
    notifyListeners();
  }

  void deleteToWait() {
    waitCount -= 1;
    notifyListeners();
  }

  void addToTransport() {
    transportCount += 1;
    notifyListeners();
  }

  void deleteToTransport() {
    transportCount -= 1;
    notifyListeners();
  }

  void addToEvauate() {
    evaluateCount += 1;
    notifyListeners();
  }

  void deleteToEvaluate() {
    evaluateCount -= 1;
    notifyListeners();
  }

  void clearOrder() {
    confirmCount = 0;
    waitCount = 0;
    transportCount = 0;
    evaluateCount = 0;
    notifyListeners();
  }
}
