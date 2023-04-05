import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:turtle_k/ui/product/product_detail.dart';

class FlashSaleWidget extends StatelessWidget {
  const FlashSaleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('accessory').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0; i < snapshot.data!.docs.length; i++)
                  SizedBox(
                    height: 250,
                    width: 180,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => ProductDetail(
                              //             snapshot: snapshot.data!.docs[i])));
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              constraints: const BoxConstraints.expand(
                                width: 180,
                                height: 180,
                              ),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(snapshot
                                      .data!.docs[i]['product_url'][0]
                                      .toString()),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.deepOrange,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Text(
                                        "- 10%",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const Icon(Icons.favorite_border,
                                        color: Colors.red),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              snapshot.data!.docs[i]['product_name'].toString(),
                              textAlign: TextAlign.justify,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${MoneyFormatter(amount: snapshot.data!.docs[i]['newprice'].toDouble()).output.withoutFractionDigits}đ',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                                Text(
                                  'Đã bán ${snapshot.data!.docs[i]['view']}',
                                  style: const TextStyle(
                                    fontSize: 12,
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
          );
        } else {
          return const Center(
            child: Text("Sản phẩm hiện chưa trưng bày"),
          );
        }
      },
    );
  }
}
