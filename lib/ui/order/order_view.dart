import 'package:blackrose/service/cart_service.dart';
import 'package:blackrose/service/order_service.dart';
import 'package:blackrose/service/product_service.dart';
import 'package:blackrose/ui/order/order_manager.dart';
import 'package:blackrose/ui/shared/alert_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:provider/provider.dart';

import '../../models/order.dart';
import '../../models/user.dart';
import '../../service/user_service.dart';
import '../cart/car_manager.dart';
import '../screens.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  String selectedValue = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: const Text("Thanh toán"),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('cart')
              .doc(FirebaseAuth.instance.currentUser!.email)
              .collection(FirebaseAuth.instance.currentUser!.email.toString())
              .where("payment", isEqualTo: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.hasError.toString());
            } else if (snapshot.hasData) {
              final cart = snapshot.data!;
              double sum = 0;
              for (int index = 0; index < snapshot.data!.docs.length; index++) {
                sum = sum +
                    snapshot.data!.docs[index].get("newPrice") *
                        snapshot.data!.docs[index].get("quantity");
              }
              return ListView(children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          bottom: BorderSide(
                        color: Colors.pink,
                        width: 3,
                      ))),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.fmd_good_sharp,
                                size: 30,
                                color: Colors.deepOrange,
                              )),
                          StreamBuilder(
                              stream: UserService.readUser(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                      child:
                                          Text(snapshot.hasError.toString()));
                                } else if (snapshot.hasData) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: snapshot.data!
                                        .map(_buildUserDetail)
                                        .toList(),
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              }),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Colors.green,
                    ),
                    child: const Center(
                        child: Text(
                      "Danh sách sản phẩm thanh toán",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ))),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white10,
                    border: Border.symmetric(
                        horizontal: BorderSide(color: Colors.pink, width: 3)),
                    //borderRadius: BorderRadius.circular(10),
                  ),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        itemCount: cart.docs.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 122,
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Image.network(
                                    cart.docs[index].get("productUrl"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        child: Text(
                                          cart.docs[index].get("productName"),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Colors.black.withOpacity(0.7),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        cart.docs[index].get("color"),
                                        style: TextStyle(
                                          fontSize: 14.5,
                                          color: Colors.black.withOpacity(0.8),
                                        ),
                                      ),
                                      Text(
                                        '${MoneyFormatter(amount: cart.docs[index].get("quantity") * cart.docs[index].get("newPrice").toDouble()).output.withoutFractionDigits}đ',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.deepOrange),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          const SizedBox(width: 8),
                                          SizedBox(
                                            width: 25,
                                            child: Center(
                                              child: Text(
                                                'x${MoneyFormatter(amount: cart.docs[index].get("quantity").toDouble()).output.withoutFractionDigits}',
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Icon(
                                Icons.payment,
                                size: 30,
                                color: Colors.deepOrange,
                              ),
                            ),
                            Text(
                              "Chi tiết thanh toán",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Tổng giá trị đơn hàng",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      MoneyFormatter(amount: sum.toDouble())
                                          .output
                                          .withoutFractionDigits,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      "Phí vận chuyển",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      "0đ",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Tổng thanh toán",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      '${MoneyFormatter(amount: sum.toDouble()).output.withoutFractionDigits}đ',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Icon(
                              Icons.payments_sharp,
                              size: 30,
                              color: Colors.deepOrange,
                            ),
                          ),
                          Text(
                            "Phương thức thanh toán ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          "Thanh toán khi nhận hàng",
                          "Thẻ ATM nội địa",
                          "BlackRose Pay"
                        ]
                            .map(
                              (value) => RadioListTile(
                                title: Text(value),
                                value: value,
                                groupValue: selectedValue,
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedValue = newValue!;
                                  });
                                },
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
                //Text('Selected value: $selectedValue'),
                const SizedBox(height: 5),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: const Text(
                    "Nhấn \"Đặt hàng\" đồng nghĩa với việc bạn đồng ý tuân theo Điều khoản Turtle-K",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ]);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  _buildBottomBar() {
    double widthDevice = MediaQuery.of(context).size.width;
    final cartProvider = Provider.of<CartManager>(context);
    final orderProvider = Provider.of<OrderManager>(context);
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('cart')
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection(FirebaseAuth.instance.currentUser!.email.toString())
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.hasError.toString()));
          } else if (snapshot.hasData) {
            double sum = 0;
            for (int index = 0; index < snapshot.data!.docs.length; index++) {
              if (snapshot.data!.docs[index].get("payment") == true) {
                sum = sum +
                    snapshot.data!.docs[index].get("newPrice") *
                        snapshot.data!.docs[index].get("quantity");
              }
            }
            return BottomAppBar(
              child: SizedBox(
                height: widthDevice / 7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: widthDevice / 7,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                width: widthDevice / 3,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Tổng: ",
                                      style: TextStyle(
                                          color: Colors.deepOrange,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: widthDevice / 7,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                width: widthDevice / 3,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${MoneyFormatter(amount: sum).output.withoutFractionDigits}đ',
                                      style: const TextStyle(
                                          color: Colors.deepOrange,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            if (snapshot.data!.size != 0 &&
                                selectedValue != '') {
                              final cart = snapshot.data!;
                              for (int index = 0;
                                  index < cart.docs.length;
                                  index++) {
                                if (cart.docs[index].get("payment") == true) {
                                  var order = Orders(
                                      id: cart.docs[index].get("id"),
                                      productName:
                                          cart.docs[index].get("productName"),
                                      productUrl:
                                          cart.docs[index].get("productUrl"),
                                      color: cart.docs[index].get("color"),
                                      size: cart.docs[index].get("size"),
                                      payment: selectedValue,
                                      status: 0,
                                      quantity:
                                          cart.docs[index].get("quantity"),
                                      newPrice:
                                          cart.docs[index].get("newPrice"),
                                      time: Timestamp.now());
                                  ProductService.updateTotal(
                                      cart.docs[index].get('id'),
                                      cart.docs[index].get('quantity'));
                                  OrderService.addOrder(order);
                                  CartService.deleteCart(
                                      cart.docs[index].get("id") +
                                          cart.docs[index].get("color") +
                                          cart.docs[index].get("size"));
                                  cartProvider.deleteToCart(
                                      cart.docs[index].get("quantity"));
                                  orderProvider.addToConfirm();
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const BottomBar(0)),
                                    (route) => false,
                                  );
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const AlertDialogView();
                                    },
                                  );
                                }
                              }
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    //contentPadding: EdgeInsets.zero,
                                    title: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Text(
                                          "!!! Mách nhỏ !!!",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    shadowColor: Colors.white70,
                                    content: Stack(
                                      children: const [
                                        Text(
                                            "Vui lòng chọn phương thức thanh toán!")
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text(
                                            "OK",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ))
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: Container(
                            height: widthDevice / 7,
                            decoration:
                                const BoxDecoration(color: Colors.pinkAccent),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: widthDevice / 3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        "Đặt hàng",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.5,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _buildUserDetail(Users user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Địa chỉ nhận hàng",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              Text(user.email,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500)),
              const SizedBox(width: 10),
              Text('Phone: ${user.phone}',
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        Text(
          'Địa chỉ: ${user.address}',
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
