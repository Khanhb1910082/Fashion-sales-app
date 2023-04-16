import 'package:blackrose/models/cart.dart';
import 'package:blackrose/service/cart_service.dart';
import 'package:blackrose/service/user_service.dart';
import 'package:blackrose/ui/order/order_now.dart';
import 'package:blackrose/ui/shared/snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../cart/car_manager.dart';
import '../home/bottom_bar.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet(this.product, this.nameSubmit, {super.key});
  final Product product;
  final String nameSubmit;
  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  int _selectSize = -1;
  int _selectColor = -1;
  final int _selectedIndex = 0;
  int _count = 1;
  late var cart = Cart(
    id: widget.product.id,
    productName: widget.product.productName,
    productUrl: widget.product.productUrl[0],
    color: '',
    size: '',
    payment: false,
    quantity: 0,
    newPrice: widget.product.newPrice.toDouble(),
  );
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 10;
    final cartProvider = Provider.of<CartManager>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            height: 4,
            width: 50,
            decoration: BoxDecoration(
              color: const Color.fromARGB(225, 223, 221, 221),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              SizedBox(
                  height: width * 3.5,
                  width: width * 3.5,
                  child:
                      Image.network(widget.product.productUrl[_selectedIndex])),
              const SizedBox(width: 5),
              SizedBox(
                height: width * 3.5,
                width: width * 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width * 10,
                      child: Text(
                        widget.product.productName,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 17),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${MoneyFormatter(amount: widget.product.oldPrice.toDouble()).output.withoutFractionDigits}đ',
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 15,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${MoneyFormatter(amount: widget.product.newPrice.toDouble()).output.withoutFractionDigits}đ',
                          style: const TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Text(
                        "Sẵn có: ${widget.product.quantity - widget.product.view}"),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const Text(
                "Màu:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 20),
              for (int i = 0; i < widget.product.color.length; i++)
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectColor = i;
                      cart = cart.copyWith(color: widget.product.color[i]);
                    });
                  },
                  child: Container(
                    height: 35,
                    width: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _selectColor == i
                          ? Colors.pinkAccent
                          : const Color(0xFFF7F8FA),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        widget.product.color[i],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color:
                                _selectColor == i ? Colors.white : Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text(
                "size:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 30),
              for (int i = 0; i < widget.product.size.length; i++)
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectSize = i;
                      cart = cart.copyWith(size: widget.product.size[i]);
                    });
                  },
                  child: Center(
                    child: Container(
                      height: 33,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _selectSize == i
                            ? Colors.pinkAccent
                            : const Color(0xFFF7F8FA),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        widget.product.size[i],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color:
                                _selectSize == i ? Colors.white : Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Text(
                'Số lượng:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 20),
              InkWell(
                onTap: () {
                  setState(() {
                    if (_count > 1) {
                      _count--;
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F8FA),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    CupertinoIcons.minus,
                    size: 18,
                    color: Colors.redAccent,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 20,
                child: Text(
                  '$_count',
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  setState(() {
                    if (_count <
                        widget.product.quantity - widget.product.view) {
                      _count++;
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F8FA),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    CupertinoIcons.add,
                    size: 18,
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Thanh toán:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${MoneyFormatter(amount: _count * widget.product.newPrice.toDouble()).output.withoutFractionDigits}đ',
                style: const TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              cart = cart.copyWith(quantity: _count);

              if (cart.color != '' &&
                  cart.size != '' &&
                  widget.product.quantity != widget.product.view) {
                if (widget.nameSubmit == "Thêm vào giỏ") {
                  cartProvider.addToCart(cart.quantity);
                  Navigator.of(context).pop();
                  CartService.addCart(cart);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: CustomSnackBar("!! Chúc mừng !!",
                        "Sản phẩm đã thêm vào giỏ hàng thành công!", "green"),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ));
                } else {
                  UserService.checkUser().then((value) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => OrderNow(cart)));
                  }).onError((error, stackTrace) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Thông tin chưa chính xác"),
                            content: const Text(
                              "Cần cập nhật thông tin trước khi đặt hàng",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w400),
                            ),
                            actions: [
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle:
                                      Theme.of(context).textTheme.labelLarge,
                                ),
                                child: const Text(
                                  'Ok',
                                  style: TextStyle(fontSize: 17),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (_) => const BottomBar(3)),
                                    (route) => false,
                                  );
                                },
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle:
                                      Theme.of(context).textTheme.labelLarge,
                                ),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(fontSize: 17),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                  });
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
                            "Sản phẩm chưa được chọn",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                        ],
                      ),
                      shadowColor: Colors.white70,
                      content: Stack(
                        children: [
                          Text(
                              "Bạn vui lòng chọn màu và kích thước trước khi ${widget.nameSubmit}")
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
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ))
                      ],
                    );
                  },
                );
              }
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.nameSubmit,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
