import 'package:flutter/material.dart';

class ImageIconWidget extends StatelessWidget {
  const ImageIconWidget(this.imageUrl, this.imageLabel, {super.key});
  final String imageUrl;
  final String imageLabel;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(100),
            ),
            child: SizedBox(
              height: 45,
              width: 45,
              child: Center(child: Image.asset(imageUrl, width: 30)),
            ),
          ),
        ),
        Text(
          imageLabel,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
