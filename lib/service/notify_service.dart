import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/order.dart';

class NotifyService {
  static Stream<List<Orders>> readOrders() => FirebaseFirestore.instance
      .collection('orders')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection(FirebaseAuth.instance.currentUser!.email.toString())
      .orderBy('time', descending: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Orders.fromMap(doc.data())).toList());
}
