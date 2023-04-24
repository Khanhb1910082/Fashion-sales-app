import 'package:blackrose/admin/service/order_service.dart';
import 'package:blackrose/service/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'app_drawer.dart';

class StatisticalView extends StatefulWidget {
  const StatisticalView({super.key});

  @override
  State<StatisticalView> createState() => _StatisticalViewState();
}

class _StatisticalViewState extends State<StatisticalView> {
  @override
  void initState() {
    OrderServiceAdmin.setOrderAdmin();
    UserService.countUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thống kê"),
      ),
      drawer: const AppDrawer(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.hasData) {
            final product = snapshot.data!;
            int sum = 0;
            for (int index = 0; index < product.docs.length; index++) {
              sum += product.docs[index].get("view") as int;
            }

            return GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              children: [
                Card(
                  color: Colors.amber,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        product.docs.length.toString(),
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Sản phẩm",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Card(
                  color: Colors.deepOrange,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        sum.toString(),
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Đã bán",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Card(
                  color: Colors.deepPurple,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        UserService.totalUser.toString(),
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Khách hàng thành viên",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                _buildCart(OrderServiceAdmin.confirm, "Đơn chờ xác nhận"),
                _buildCart(OrderServiceAdmin.wait, "Đơn chưa gói hàng"),
                _buildCart(OrderServiceAdmin.go, "Đang vận chuyển"),
                _buildCart(OrderServiceAdmin.eva, "Số đánh giá"),
                _buildCart(OrderServiceAdmin.cancel, "Số đơn hủy"),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildCart(int total, String name) {
    return Card(
      color: Colors.green,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            total.toString(),
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 5),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
