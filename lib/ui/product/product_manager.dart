import 'package:flutter/foundation.dart';

import '../../models/product.dart';

class ProductManager with ChangeNotifier {
  List<Product> _items = [];

  int get itemcount {
    return _items.length;
  }

  List<Product> get items {
    return [..._items];
  }
}
