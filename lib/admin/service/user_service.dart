import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user.dart';

class UserServiceAdmin {
  static Stream<List<Users>> readUser() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Users.fromMap(doc.data())).toList());
}
