class Product {
  String id;
  final String productName;
  List<String> productUrl;
  final String describe;
  final int newPrice;
  final int oldPrice;
  final int quantity;
  final String type;
  final bool sale;
  final String sex;
  final int view;

  Product({
    this.id = '',
    required this.productName,
    required this.productUrl,
    required this.describe,
    required this.newPrice,
    required this.oldPrice,
    required this.quantity,
    required this.type,
    required this.sale,
    required this.sex,
    required this.view,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'product_name': productName,
        'product_url': productUrl,
        'describe': describe,
        'newprice': newPrice,
        'oldprice': oldPrice,
        'quantity': quantity,
        'type': type,
        'sale': sale,
        'sex': sex,
        'view': view,
      };

  static Product fromMap(Map<String, dynamic> map) => Product(
        id: map['id'],
        productName: map['product_name'],
        productUrl: List<String>.from((map['product_url'])),
        describe: map['describe'],
        newPrice: map['newprice'],
        oldPrice: map['oldprice'],
        quantity: map['quantity'],
        type: map['type'],
        sale: map['sale'],
        sex: map['sex'],
        view: map['view'],
      );
}
