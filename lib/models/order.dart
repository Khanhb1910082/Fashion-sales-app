import 'package:cloud_firestore/cloud_firestore.dart';

class Orders {
  final String id;
  final String productName;
  final String productUrl;
  final String color;
  final String size;
  final String payment;
  final int status;
  final int quantity;
  final double newPrice;
  final Timestamp time;
  Orders({
    required this.id,
    required this.productName,
    required this.productUrl,
    required this.color,
    required this.size,
    required this.payment,
    required this.status,
    required this.quantity,
    required this.newPrice,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productName': productName,
      'productUrl': productUrl,
      'color': color,
      'size': size,
      'payment': payment,
      'status': status,
      'quantity': quantity,
      'newPrice': newPrice,
      'time': time,
    };
  }

  static Orders fromMap(Map<String, dynamic> map) {
    return Orders(
      id: map['id'] as String,
      productName: map['productName'] as String,
      productUrl: map['productUrl'],
      color: map['color'],
      size: map['size'],
      payment: map['payment'],
      status: map['status'],
      quantity: map['quantity'] as int,
      newPrice: map['newPrice'] as double,
      time: map['time'],
    );
  }

  Orders copyWith({
    String? id,
    String? productName,
    String? productUrl,
    String? color,
    String? size,
    String? payment,
    int? status,
    int? quantity,
    double? newPrice,
    Timestamp? time,
  }) {
    return Orders(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      productUrl: productUrl ?? this.productUrl,
      color: color ?? this.color,
      size: size ?? this.size,
      payment: payment ?? this.payment,
      status: status ?? this.status,
      quantity: quantity ?? this.quantity,
      newPrice: newPrice ?? this.newPrice,
      time: time ?? this.time,
    );
  }
}
