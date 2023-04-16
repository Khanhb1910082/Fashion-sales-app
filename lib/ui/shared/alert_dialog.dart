import 'package:flutter/material.dart';

class AlertDialogView extends StatelessWidget {
  const AlertDialogView({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      //contentPadding: EdgeInsets.zero,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            "!!! Đặt hàng thành công !!!",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
        ],
      ),
      shadowColor: Colors.white70,
      content: Stack(
        children: const [
          Text(
            "Cảm ơn bạn đã tin tưởng đặt hàng với Black Rose. Chúng tôi sẽ cập nhật thông tin đơn hàng đến bạn đến khi giao hàng thành công.",
            textAlign: TextAlign.justify,
          )
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "OK",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ))
      ],
    );
  }
}
