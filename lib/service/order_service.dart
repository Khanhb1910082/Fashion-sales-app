import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/order.dart';

class OrderService {
  static Stream<List<Orders>> readOrders(int status) =>
      FirebaseFirestore.instance
          .collection('orders')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection(FirebaseAuth.instance.currentUser!.email.toString())
          .orderBy('time', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .where((product) => product.get("status") == status)
              .map((doc) => Orders.fromMap(doc.data()))
              .toList());

  static void addOrder(Orders order) async {
    CollectionReference addOrder = FirebaseFirestore.instance
        .collection('orders')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection(FirebaseAuth.instance.currentUser!.email.toString());

    await addOrder.doc(DateTime.now().toIso8601String()).set(order.toMap());
  }

  static void cancelOrders(Orders item) async {
    CollectionReference order = FirebaseFirestore.instance
        .collection('orders')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection(FirebaseAuth.instance.currentUser!.email.toString());
    var snapshot = await order.get();
    for (final doc in snapshot.docs) {
      if (doc.get('time') == item.time && doc.get('id') == item.id) {
        doc.reference.update({"status": 4});
        break;
      }
    }
  }
}
