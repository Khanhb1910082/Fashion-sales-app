class Cart {
  final String id;
  final String productName;
  final String productUrl;
  final String color;
  final String size;
  final bool payment;
  final int quantity;
  final double newPrice;
  Cart({
    required this.id,
    required this.productName,
    required this.productUrl,
    required this.color,
    required this.size,
    required this.payment,
    required this.quantity,
    required this.newPrice,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productName': productName,
      'productUrl': productUrl,
      'color': color,
      'size': size,
      'payment': payment,
      'quantity': quantity,
      'newPrice': newPrice,
    };
  }

  static Cart fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id'] as String,
      productName: map['productName'] as String,
      productUrl: map['productUrl'],
      color: map['color'],
      size: map['size'],
      payment: map['payment'],
      quantity: map['quantity'] as int,
      newPrice: map['newPrice'] as double,
    );
  }

  Cart copyWith({
    String? id,
    String? productName,
    String? productUrl,
    String? color,
    String? size,
    bool? payment,
    int? quantity,
    double? newPrice,
  }) {
    return Cart(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      productUrl: productUrl ?? this.productUrl,
      color: color ?? this.color,
      size: size ?? this.size,
      payment: payment ?? this.payment,
      quantity: quantity ?? this.quantity,
      newPrice: newPrice ?? this.newPrice,
    );
  }
}
