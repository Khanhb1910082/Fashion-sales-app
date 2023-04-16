import 'package:badges/badges.dart';
import 'package:blackrose/models/order.dart';
import 'package:blackrose/service/order_service.dart';
import 'package:blackrose/ui/order/confirm_widget.dart';
import 'package:blackrose/ui/order/order_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import '../cart/car_manager.dart';
import '../screens.dart';

class NotifitionView extends StatefulWidget {
  const NotifitionView({super.key});

  @override
  State<NotifitionView> createState() => _NotifitionViewState();
}

class _NotifitionViewState extends State<NotifitionView> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartManager>(context);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text(
          "Thông báo",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CartView()));
            },
            child: badges.Badge(
              position: badges.BadgePosition.topEnd(top: -12, end: -12),
              showBadge: true,
              ignorePointer: false,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CartView()));
              },
              badgeContent: Text('${cartProvider.cartCount}'),
              badgeAnimation: const BadgeAnimation.scale(
                animationDuration: Duration(seconds: 1),
                colorChangeAnimationDuration: Duration(seconds: 1),
                loopAnimation: false,
                curve: Curves.fastOutSlowIn,
                colorChangeAnimationCurve: Curves.easeInCubic,
              ),
              badgeStyle: badges.BadgeStyle(
                badgeColor: Colors.deepOrange,
                borderRadius: BorderRadius.circular(4),
                elevation: 0,
              ),
              child: const Icon(
                Icons.shopping_cart_outlined,
                size: 28,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.chat_outlined),
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                          width: 30,
                          height: 30,
                          child:
                              SvgPicture.asset("assets/icons/notify/sale.svg")),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Khuyến mãi",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: const Text(
                            "Rất nhiều Voucher miễn phí đang chờ bạn.",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/angle-right.svg",
                    ),
                  ],
                ),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                          width: 30,
                          height: 30,
                          child: SvgPicture.asset(
                              "assets/icons/notify/update.svg")),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Cập nhật ứng dụng",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.yellow,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: const Text(
                            "Bạn đang sử dụng phiên bản mới nhất!",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/angle-right.svg",
                    ),
                  ],
                ),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                          width: 30,
                          height: 30,
                          child:
                              SvgPicture.asset("assets/icons/notify/news.svg")),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Tin tức thời trang",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.orange,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: const Text(
                            "Các sản phẩm đang đồng loạt giảm giá mạnh ...",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/angle-right.svg",
                    ),
                  ],
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
                Text(
                  "Tình trạng đơn hàng",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text("Đọc tất cả"),
              ],
            ),
          ),
          const SizedBox(height: 5),
          StreamBuilder(
            stream: OrderService.readOrders(0),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error: ${snapshot.error}"),
                );
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                final notify = snapshot.data!;
                return Column(
                  children: notify.map(_buildNotify).toList(),
                );
              } else {
                return SizedBox(
                  height: width / 1.5,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                            image:
                                const AssetImage("assets/images/no_item.png"),
                            height: width / 3,
                            width: width / 3),
                        const Text("Chưa có đơn hàng")
                      ],
                    ),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }

  Widget _buildNotify(Orders notify) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderSuccessView(notify.status)));
      },
      child: Container(
        height: MediaQuery.of(context).size.width / 3.5,
        margin: const EdgeInsets.only(bottom: 1),
        decoration: BoxDecoration(color: Colors.pink[50]),
        child: Row(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width / 3.5,
              width: MediaQuery.of(context).size.width / 3.5,
              child: Column(
                children: [
                  Image.network(
                    notify.productUrl,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.width / 3.5,
                    width: MediaQuery.of(context).size.width / 3.5,
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.width / 3.5,
              width: MediaQuery.of(context).size.width -
                  10 -
                  MediaQuery.of(context).size.width / 3.5,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: Row(
                      children: const [
                        Text(
                          "Đặt hàng thành công",
                          maxLines: 1,
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.deepOrange),
                        ),
                        // Icon(
                        //   Icons.done,
                        //   color: Colors.green,
                        //   size: 20,
                        // ),
                      ],
                    ),
                  ),
                  const Text(
                    'Mã đơn hàng: .\nĐơn hàng của bạn sẽ sớm giao cho đơn vị vận chuyển nhanh.',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 14.5),
                  ),
                  Text(
                    '${MoneyFormatter(amount: notify.newPrice.toDouble()).output.withoutFractionDigits}đ',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ),
            // Column(
            //   children: const [
            //     InkWell(
            //         child: Text(
            //       "Chưa đọc",
            //       style: TextStyle(fontSize: 10),
            //     )),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
