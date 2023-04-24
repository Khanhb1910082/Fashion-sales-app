// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:money_formatter/money_formatter.dart';
// import 'package:turtle_k/ui/product/product_detail.dart';
// import 'package:turtle_k/ui/product/productdetaildemo.dart';

// import '../models/product.dart';
// import '../models/user.dart';
// import '../service/product_service.dart';

// class FireBase extends StatefulWidget {
//   const FireBase({Key? key}) : super(key: key);

//   @override
//   State<FireBase> createState() => _FireBaseState();
// }

// class _FireBaseState extends State<FireBase> {
//   final controller = TextEditingController();
//   final controllerName = TextEditingController();
//   final controllerAge = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('add User'),
//       ),

//       // FutureBuilder<User?>(
//       //   future: readUser('TbRXGADuyULBSIcNbHDc'),
//       //   builder: (context, snapshot) {
//       //     if (snapshot.hasData) {
//       //       final user = snapshot.data;

//       //       return user == null
//       //           ? Center(child: Text("No user"))
//       //           : buildUser(user);
//       //     } else {
//       //       return Center(
//       //         child: CircularProgressIndicator(),
//       //       );
//       //     }
//       //   },
//       // )
//       body: StreamBuilder<List<Product>>(
//         stream: ProductService.readProduct(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Text(snapshot.hasError.toString());
//           } else if (snapshot.hasData) {
//             final product = snapshot.data!;

//             return GridView(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2, childAspectRatio: 2 / 3.6),
//                 children: product
//                     .where((element) => element.sex == 'men')
//                     .map(buildProduct)
//                     .toList());
//           } else {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//         // child: ListView(
//         //   padding: const EdgeInsets.all(16),
//         //   children: [
//         //     TextFormField(
//         //       controller: controllerName,
//         //       decoration: InputDecoration(labelText: 'Name'),
//         //       autofocus: true,
//         //       validator: (value) {
//         //         if (value!.isEmpty) {
//         //           return 'Vui lòng nhập tên.';
//         //         }
//         //         return null;
//         //       },
//         //     ),
//         //     const SizedBox(height: 20),
//         //     TextFormField(
//         //       controller: controllerAge,
//         //       decoration: InputDecoration(labelText: 'Age'),
//         //       keyboardType: TextInputType.number,
//         //       validator: (value) {
//         //         if (value!.isEmpty) {
//         //           return 'Vui lòng nhập tuổi.';
//         //         }
//         //         return null;
//         //       },
//         //     ),
//         //     const SizedBox(height: 20),
//         //     ElevatedButton(
//         //         onPressed: () {
//         //           final user = User(
//         //               name: controllerName.text,
//         //               age: int.parse(controllerAge.text));
//         //           createUser(user);
//         //         },
//         //         child: Text('Create'))
//         //   ],
//         // ),
//       ),
//     );
//   }

//   Stream<List<User>> readUsers() => FirebaseFirestore.instance
//       .collection('users')
//       .snapshots()
//       .map((snapshot) =>
//           snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
//   Stream<List<Product>> readProduct() => FirebaseFirestore.instance
//       .collection('products')
//       .snapshots()
//       .map((snapshot) =>
//           snapshot.docs.map((doc) => Product.fromJson(doc.data())).toList());
//   Future createUser(User user) async {
//     final docUser = FirebaseFirestore.instance.collection('users').doc('my-id');
//     user.id = docUser.id;
//     final json = user.toJson();
//     await docUser.set(json);
//   }

//   Widget buildProduct(Product product) {
//     return SizedBox(
//       height: 370,
//       child: Container(
//         margin: const EdgeInsets.all(4),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(4),
//         ),
//         child: Column(
//           children: [
//             InkWell(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ProductDetail(product)));
//               },
//               child: Container(
//                 margin: const EdgeInsets.only(bottom: 5),
//                 constraints: const BoxConstraints.expand(
//                   width: 250,
//                   height: 290,
//                 ),
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: NetworkImage(product.productUrl[0]),
//                     fit: BoxFit.cover,
//                   ),
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(5),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           color: Colors.deepOrange,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: const Text(
//                           "- 10%",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       const Icon(Icons.favorite_border, color: Colors.red),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 6),
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 product.productName.toString(),
//                 textAlign: TextAlign.justify,
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 2,
//                 style: const TextStyle(
//                   fontSize: 14,
//                 ),
//               ),
//             ),
//             const Expanded(
//               child: SizedBox(
//                 height: 0,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text(
//                     '${MoneyFormatter(amount: product.newPrice.toDouble()).output.withoutFractionDigits}đ',
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.red,
//                     ),
//                   ),
//                   Text(
//                     'Đã bán ${product.view}',
//                     style: const TextStyle(
//                       fontSize: 12,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildUser(User user) => ListTile(
//         leading: CircleAvatar(
//           child: Text('${user.age}'),
//         ),
//         title: Text(user.name),
//         subtitle: Text(user.id),
//       );

//   Future<User?> readUser(String? id) async {
//     final docUser = FirebaseFirestore.instance.collection('users').doc();
//     final snapshot = await docUser.get();

//     if (snapshot.exists) {
//       return User.fromJson(snapshot.data()!);
//     }
//     return null;
//   }
// }
