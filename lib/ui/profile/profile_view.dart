import 'package:blackrose/service/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/user.dart';
import '../login/login_view.dart';
import 'profile_detail.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
          bottom: PreferredSize(
              preferredSize: Size(width, width / 5),
              child: StreamBuilder<List<Users>>(
                stream: UserService.readUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text("Lỗi người dùng"));
                  } else if (snapshot.hasData) {
                    final user = snapshot.data!;
                    return Column(
                      children: user.map(_buidAvataField).toList(),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ))),
      body: StreamBuilder(
          stream: UserService.readUser(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text("Lỗi người dùng"));
            } else if (snapshot.hasData) {
              final user = snapshot.data!;
              return Column(
                children: user.map(_buidUserService).toList(),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  // final productsRef = FirebaseFirestore.instance.collection('users');
  // Future getProduct(String productId) async {
  //   final productDoc = await productsRef.doc(productId).get();
  //   final productData = productDoc.data();

  //   final user1 = Users(
  //       email: productData!['email'],
  //       name: productData['name'],
  //       phone: productData['phone'],
  //       address: productData['address']);
  //   return user1;
  // }

  Widget _buidAvataField(Users user) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Column(
          children: [
            Container(
              margin: const EdgeInsets.all(8),
              width: width / 5,
              height: width / 5,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(width),
              ),
              child: const Center(
                  child: Text(
                "Sửa",
                style: TextStyle(fontWeight: FontWeight.w700),
              )),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Row(
                  children: const [
                    Text(
                      "Thành viên",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black,
                      size: 11,
                    ),
                  ],
                )),
            const Text(
              "Yêu thích",
              style: TextStyle(color: Colors.white),
            ),
          ],
        )
      ],
    );
  }

  Widget _buidUserService(Users user) {
    return Column(
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
                        child: SvgPicture.asset("assets/icons/profile/go.svg")),
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
                        child:
                            SvgPicture.asset("assets/icons/profile/star.svg")),
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
        InkWell(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ProfileDetail(user)));
          },
          child: Container(
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
                            Icons.person_sharp,
                            color: Colors.cyan,
                            size: 30,
                          )),
                    ),
                    Text("Thông tin cá nhân"),
                  ],
                ),
              ],
            ),
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
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: SizedBox(
                        height: 30,
                        width: 30,
                        child:
                            SvgPicture.asset("assets/icons/profile/medal.svg")),
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
        InkWell(
          onTap: () {
            FirebaseAuth.instance.signOut().then((value) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginView()),
                  (route) => false);
            });
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(color: Colors.white70),
            child: const Center(
              child: Text(
                "Đăng xuất",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.black87),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
