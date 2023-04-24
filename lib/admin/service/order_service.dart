import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/order.dart';

class OrderServiceAdmin {
  static read() async {
    final user = FirebaseFirestore.instance.collection('users');
    final total = await user.get();
    for (var doc in total.docs) {
      return readOrders(doc.get("email"));
    }
  }

  static Stream<List<Orders>> readOrders(String email) => FirebaseFirestore
      .instance
      .collection('orders')
      .doc(email)
      .collection(email)
      .orderBy('time', descending: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Orders.fromMap(doc.data())).toList());

  static int confirm = 0;
  static int wait = 0;
  static int go = 0;
  static int eva = 0;
  static int cancel = 0;

  static void setOrderAdmin() async {
    int confirm1 = 0;
    int wait1 = 0;
    int go1 = 0;
    int cancel1 = 0;
    int eva1 = 0;
    final user = FirebaseFirestore.instance.collection('users');
    final total = await user.get();
    for (var doc in total.docs) {
      CollectionReference order = FirebaseFirestore.instance
          .collection('orders')
          .doc(doc.get("email"))
          .collection(doc.get("email"));
      var snapshot = await order.get();
      for (final item in snapshot.docs) {
        if (item.get("status") == 0) {
          confirm1 += 1;
        } else if (item.get("status") == 1) {
          wait1 += 1;
        } else if (item.get("status") == 2) {
          go1 += 1;
        } else if (item.get("status") == 3) {
          eva1 += 1;
        } else if (item.get("status") == 4) {
          cancel1 += 1;
        }
      }
      setTotal(confirm1, wait1, go1, eva1, cancel1);
    }
  }

  static setTotal(int confirm1, int wait1, int go1, int eva1, int cancel1) {
    confirm = confirm1;
    wait = wait1;
    go = go1;
    eva = eva1;
    cancel = cancel1;
  }
}
