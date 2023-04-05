import 'package:flutter/foundation.dart';
import 'package:turtle_k/models/product.dart';
import 'package:turtle_k/service/product_service.dart';

class ProductManager with ChangeNotifier {
  List<Product> _items = [];

  int get itemcount {
    return _items.length;
  }

  List<Product> get items {
    return [..._items];
  }
}
