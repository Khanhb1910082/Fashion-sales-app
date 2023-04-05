class Product {
  String id;
  final String productName;
  List<String> productUrl;
  final String describe;
  final int newPrice;
  final int oldPrice;
  var quantity;
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

  Map<String, dynamic> toJson() => {
        'id': id,
        'product_name': productName,
        'product_url': List.from(['product_url']),
        'describe': describe,
        'newprice': newPrice,
        'oldprice': oldPrice,
        'quantity': quantity,
        'type': type,
        'sale': sale,
        'sex': sex,
        'view': view,
      };

  static Product fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        productName: json['product_name'],
        productUrl: List<String>.from((json['product_url'])),
        describe: json['describe'],
        newPrice: json['newprice'],
        oldPrice: json['oldprice'],
        quantity: json['quantity'],
        type: json['type'],
        sale: json['sale'],
        sex: json['sex'],
        view: json['view'],
      );
}
