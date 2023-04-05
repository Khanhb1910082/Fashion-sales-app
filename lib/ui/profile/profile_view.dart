import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turtle_k/ui/login/login_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: Colors.pink,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(
              Icons.shopping_cart_outlined,
              size: 28,
            ),
          ),
          Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(Icons.chat_outlined)),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                color: Colors.white,
                border:
                    Border(bottom: BorderSide(color: Colors.black, width: 2))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                        height: 30,
                        width: 30,
                        child:
                            SvgPicture.asset("assets/icons/profile/order.svg")),
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text("Đơn mua"),
                    ),
                  ],
                ),
                const Text("Lịch sử mua hàng"),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      SizedBox(
                          height: 30,
                          width: 30,
                          child: SvgPicture.asset(
                              "assets/icons/profile/confirm.svg")),
                      Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: const Text(
                            "Chờ xác nhận",
                            style: TextStyle(fontSize: 11),
                          )),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      SizedBox(
                          height: 30,
                          width: 30,
                          child: SvgPicture.asset(
                              "assets/icons/profile/package.svg")),
                      Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: const Text(
                            "Chờ lấy hàng",
                            style: TextStyle(fontSize: 11),
                          )),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      SizedBox(
                          height: 30,
                          width: 30,
                          child:
                              SvgPicture.asset("assets/icons/profile/go.svg")),
                      Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: const Text(
                            "Đang giao",
                            style: TextStyle(fontSize: 11),
                          )),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      SizedBox(
                          height: 30,
                          width: 30,
                          child: SvgPicture.asset(
                              "assets/icons/profile/star.svg")),
                      Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: const Text(
                            "Đánh giá",
                            style: TextStyle(fontSize: 11),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Sản phẩm đã mua"),
                  Text("Xem tất cả"),
                ],
              )),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: SizedBox(
                          height: 30,
                          width: 30,
                          child: SvgPicture.asset(
                              "assets/icons/profile/medal.svg")),
                    ),
                    const Text("Khách hàng thân thiết"),
                  ],
                ),
                const Text("Thành viên"),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: SizedBox(
                          height: 30,
                          width: 30,
                          child: Icon(
                            Icons.favorite,
                            color: Colors.pink,
                            size: 30,
                          )),
                    ),
                    Text("Yêu thích"),
                  ],
                ),
                const Text("0"),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(color: Colors.white70),
            child: Center(
              child: GestureDetector(
                child: const Text(
                  "Đăng xuất",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginView(),
                      ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
