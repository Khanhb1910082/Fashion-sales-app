import 'package:blackrose/admin/service/order_service.dart';
import 'package:blackrose/admin/service/user_service.dart';
import 'package:blackrose/models/order.dart';
import 'package:blackrose/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';

import 'app_drawer.dart';

class OrderAdmin extends StatefulWidget {
  const OrderAdmin({super.key});

  @override
  State<OrderAdmin> createState() => _OrderAdminState();
}

class _OrderAdminState extends State<OrderAdmin> {
  var user = UserServiceAdmin.readUser();
  @override
  void initState() {
    user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Quản lý đơn hàng"),
        ),
        drawer: const AppDrawer(),
        body: StreamBuilder(
          stream: user,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              final use = snapshot.data!;
              return ListView(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: use.map(_buildUser).toList(),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  Widget _buildUser(Users user) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('orders')
          .doc(user.email)
          .collection(user.email)
          .orderBy('time', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final order = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tên: ${user.name}'
                  '\nEmail: ${user.email}'
                  '\nPhone: ${user.phone}',
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
                DataTable(
                  headingTextStyle:
                      const TextStyle(color: Colors.black, fontSize: 18),
                  dataTextStyle: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  dataRowHeight: 100,
                  border: TableBorder.all(color: Colors.black),
                  headingRowColor:
                      const MaterialStatePropertyAll(Colors.amberAccent),
                  columns: const [
                    DataColumn(label: Text('STT'), numeric: true),
                    DataColumn(label: Text('Sản phẩm')),
                    DataColumn(label: Text('Hình thức thanh toán')),
                    DataColumn(label: Text('Giá')),
                    DataColumn(label: Text('Trạng thái đơn hàng')),
                    DataColumn(label: Text('Trạng thái giao hàng')),
                    DataColumn(label: Text('Đơn hủy')),
                  ],
                  rows: [
                    for (int i = 0; i < order.docs.length; i++)
                      DataRow(cells: [
                        const DataCell(Text("1")),
                        DataCell(
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    order.docs[i].get("productName"),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  const Text("Size: "),
                                  Text(order.docs[i].get("size")),
                                  const SizedBox(width: 10),
                                  const Text("Màu: "),
                                  Text(order.docs[i].get("color")),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  const Text("Số lượng: "),
                                  Text(
                                      order.docs[i].get("quantity").toString()),
                                  const SizedBox(width: 10),
                                  const Text("Giá: "),
                                  Text(
                                      '${MoneyFormatter(amount: order.docs[i].get("newPrice").toDouble()).output.withoutFractionDigits}đ'),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  Text(
                                      "Thời gian: ${order.docs[i].get("time").toDate().hour}:${order.docs[i].get("time").toDate().minute} ${order.docs[i].get("time").toDate().day}/${order.docs[i].get("time").toDate().month}/${order.docs[i].get("time").toDate().year}"),
                                ],
                              ),
                            ],
                          ),
                        ),
                        DataCell(Text(order.docs[i].get("payment").toString())),
                        DataCell(
                          Text(
                              '${MoneyFormatter(amount: order.docs[i].get("quantity") * order.docs[i].get("newPrice").toDouble()).output.withoutFractionDigits}đ'),
                        ),
                        DataCell(Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(order.docs[i].get("status") == 0
                                ? "Chờ xác nhận"
                                : "Đã xác nhận"),
                            order.docs[i].get("status") == 0
                                ? TextButton(
                                    onPressed: () async {
                                      var snap = FirebaseFirestore.instance
                                          .collection('orders')
                                          .doc(user.email)
                                          .collection(user.email);
                                      var snapshot = await snap.get();

                                      for (var doc in snapshot.docs) {
                                        print(order.docs[i]
                                            .get("time")
                                            .toDate()
                                            .toString());
                                        if (doc.get("time") ==
                                            order.docs[i].get("time")) {
                                          doc.reference.update({
                                            "status":
                                                order.docs[i].get("status") + 1
                                          });
                                        }
                                      }
                                    },
                                    child: Text(order.docs[i].get("status") == 0
                                        ? "Xác nhận"
                                        : ""))
                                : const Text(""),
                          ],
                        )),
                        DataCell(Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(order.docs[i].get("status") <= 1
                                ? "Chờ vận chuyển"
                                : "Đang giao"),
                            order.docs[i].get("status") == 1
                                ? TextButton(
                                    onPressed: () async {
                                      var snap = FirebaseFirestore.instance
                                          .collection('orders')
                                          .doc(user.email)
                                          .collection(user.email);
                                      var snapshot = await snap.get();

                                      for (var doc in snapshot.docs) {
                                        print(order.docs[i]
                                            .get("time")
                                            .toDate()
                                            .toString());
                                        if (doc.get("time") ==
                                            order.docs[i].get("time")) {
                                          doc.reference.update({
                                            "status":
                                                order.docs[i].get("status") + 1
                                          });
                                        }
                                      }
                                    },
                                    child: Text(order.docs[i].get("status") == 1
                                        ? "Xác nhận"
                                        : ""))
                                : const Text(""),
                          ],
                        )),
                        DataCell(Text(order.docs[i].get("status") == 4
                            ? "Đơn hàng đã hủy"
                            : "")),
                      ])
                  ],
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  int index = 0;
  // DataRow _buildOrder(Orders order) {
  //   return DataRow(
  //     cells: [
  //       const DataCell(Text("1")),
  //       DataCell(
  //         Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Row(
  //               children: [
  //                 Text(
  //                   order.productName,
  //                   overflow: TextOverflow.ellipsis,
  //                   maxLines: 1,
  //                 ),
  //               ],
  //             ),
  //             const SizedBox(height: 2),
  //             Row(
  //               children: [
  //                 const Text("Size: "),
  //                 Text(order.size),
  //                 const SizedBox(width: 10),
  //                 const Text("Màu: "),
  //                 Text(order.color),
  //               ],
  //             ),
  //             const SizedBox(height: 2),
  //             Row(
  //               children: [
  //                 const Text("Số lượng: "),
  //                 Text(order.quantity.toString()),
  //                 const SizedBox(width: 10),
  //                 const Text("Giá: "),
  //                 Text(
  //                     '${MoneyFormatter(amount: order.newPrice.toDouble()).output.withoutFractionDigits}đ'),
  //               ],
  //             ),
  //             const SizedBox(height: 2),
  //             Row(
  //               children: [
  //                 Text(
  //                     "Thời gian: ${order.time.toDate().hour}:${order.time.toDate().minute} ${order.time.toDate().day}/${order.time.toDate().month}/${order.time.toDate().year}"),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //       DataCell(Text(order.payment)),
  //       DataCell(
  //         Text(
  //             '${MoneyFormatter(amount: order.quantity * order.newPrice.toDouble()).output.withoutFractionDigits}đ'),
  //       ),
  //       DataCell(Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Text(order.status == 0 ? "Chờ xác nhận" : "Đã xác nhận"),
  //           order.status == 0
  //               ? TextButton(
  //                   onPressed: () {
  //                     setState(() {
  //                       index++;
  //                     });
  //                     print(index);
  //                   },
  //                   child: Text(order.status == 0 ? "Xác nhận" : ""))
  //               : const Text(""),
  //         ],
  //       )),
  //       DataCell(Column(
  //         children: [
  //           Text(order.status <= 1 ? "Chờ vận chuyển" : "Đang giao"),
  //           TextButton(
  //               onPressed: () {},
  //               child: Text(order.status == 1 ? "Xác nhận" : "")),
  //         ],
  //       )),
  //       DataCell(Text(order.status == 4 ? "Đơn hàng đã hủy" : "")),
  //     ],
  //   );
  // }
}
