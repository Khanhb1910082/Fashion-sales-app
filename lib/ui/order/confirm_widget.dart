import 'package:blackrose/models/order.dart';
import 'package:blackrose/service/order_service.dart';
import 'package:blackrose/ui/order/order_detail.dart';
import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';

class ConfirmWidget extends StatefulWidget {
  const ConfirmWidget(this.status, {super.key});
  final int status;
  @override
  State<ConfirmWidget> createState() => _ConfirmWidgetState();
}

class _ConfirmWidgetState extends State<ConfirmWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return StreamBuilder(
      stream: OrderService.readOrders(widget.status),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Error: ${snapshot.error}"),
          );
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final order = snapshot.data!;
          return ListView(
            children: order.map(_buildOrders).toList(),
          );
        } else {
          return SizedBox(
            height: width / 1.5,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                      image: const AssetImage("assets/images/no_item.png"),
                      height: width / 3,
                      width: width / 3),
                  const Text("Chưa có đơn hàng")
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildOrders(Orders order) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
          color: Colors.white,
          border:
              Border.symmetric(horizontal: BorderSide(color: Colors.black26))),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width / 3.5,
                width: MediaQuery.of(context).size.width / 3.5,
                child: Column(
                  children: [
                    Image.network(
                      order.productUrl,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.width / 3.5,
                      width: MediaQuery.of(context).size.width / 3.5,
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.width / 3.5,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.7,
                      child: Text(
                        order.productName,
                        maxLines: 1,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Text('Số lượng: ${order.quantity.toString()}'),
                    Text(
                      '${MoneyFormatter(amount: order.newPrice.toDouble()).output.withoutFractionDigits}đ',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => OrderDetailView(order)));
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                  border: Border.symmetric(
                      horizontal: BorderSide(
                color: Colors.black12,
              ))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Chờ xác nhận",
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.black26,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: const Text(
                    "Nếu bạn có bất cứ thắc mắc gì xin vui lòng chat trực tiếp với chúng tôi.",
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        //status = "Đã hủy đơn";
                      });
                    },
                    child: const Text("Hủy đơn hàng"))
              ],
            ),
          )
        ],
      ),
    );
  }
}
