import 'package:flutter/material.dart';

import '../product/product_category.dart';

class ImageIconWidget extends StatelessWidget {
  const ImageIconWidget(this.imageUrl, this.imageLabel, this.type, this.sex,
      {super.key});
  final String imageUrl;
  final String imageLabel;
  final String type;
  final String sex;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ProductCategoryView(imageLabel, type, sex)));
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(100),
            ),
            child: SizedBox(
              height: 50,
              width: 50,
              child: Center(child: Image.asset(imageUrl, width: 35)),
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
