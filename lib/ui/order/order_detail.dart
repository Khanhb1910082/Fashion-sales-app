import 'package:blackrose/models/order.dart';
import 'package:blackrose/ui/notify/notify_manager.dart';
import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';

import '../../models/user.dart';
import '../../service/user_service.dart';

class OrderDetailView extends StatefulWidget {
  const OrderDetailView(this.order, {super.key});
  final Orders order;
  @override
  State<OrderDetailView> createState() => _OrderDetailViewState();
}

class _OrderDetailViewState extends State<OrderDetailView> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(246, 255, 255, 255),
      appBar: AppBar(
        title: const Text("Chi tiết đơn hàng"),
      ),
      body: ListView(children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
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
                              child: Text(snapshot.hasError.toString()));
                        } else if (snapshot.hasData) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                snapshot.data!.map(_buildUserDetail).toList(),
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
          margin: const EdgeInsets.only(top: 5),
          padding: const EdgeInsets.only(bottom: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Icon(
                      Icons.cached_sharp,
                      size: 30,
                      color: Colors.deepOrange,
                    ),
                  ),
                  Text(
                    "Trạng thái đơn hàng",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      NotiManager.notiList[widget.order.status],
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.deepPurple),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                color: Colors.green,
                border: Border(top: BorderSide(color: Colors.pink, width: 3))),
            child: const Center(
                child: Text(
              "Sản phẩm thanh toán",
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
            child: Container(
              height: 120,
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Container(
                    height: width / 3.5,
                    width: width / 3.5,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.network(
                      widget.order.productUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: width - width / 2,
                          child: Text(
                            widget.order.productName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              widget.order.color,
                              style: TextStyle(
                                fontSize: 14.5,
                                color: Colors.black.withOpacity(0.8),
                              ),
                            ),
                            Text(', ${widget.order.size}')
                          ],
                        ),
                        Text(
                          '${MoneyFormatter(amount: widget.order.quantity * widget.order.newPrice.toDouble()).output.withoutFractionDigits}đ',
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
                    padding: const EdgeInsets.symmetric(vertical: 5),
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
                                  'x${MoneyFormatter(amount: widget.order.quantity.toDouble()).output.withoutFractionDigits}',
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
            ),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Icon(
                        Icons.payment,
                        size: 30,
                        color: Colors.deepOrange,
                      ),
                    ),
                    Text(
                      "Chi tiết thanh toán",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Tổng giá trị đơn hàng",
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              MoneyFormatter(
                                      amount: widget.order.quantity *
                                          widget.order.newPrice.toDouble())
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
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Tổng thanh toán",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                            Text(
                              '${MoneyFormatter(amount: widget.order.quantity * widget.order.newPrice.toDouble()).output.withoutFractionDigits}đ',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
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
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Icon(
                      Icons.payments_sharp,
                      size: 30,
                      color: Colors.deepOrange,
                    ),
                  ),
                  Text(
                    "Phương thức thanh toán ",
                    style:
                        TextStyle(fontSize: 17.5, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Column(mainAxisSize: MainAxisSize.min, children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        widget.order.payment,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.deepPurple),
                      ),
                    ),
                  ],
                )
              ]),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
      ]),
    );
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
