import 'package:blackrose/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  static Stream<List<Users>> readUser() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => Users.fromMap(doc.data()))
          .where(
              (user) => user.email == FirebaseAuth.instance.currentUser!.email)
          .toList());
  static updateUser(Users updateUser) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(updateUser.email)
        .update(updateUser.toMap());
  }
}
