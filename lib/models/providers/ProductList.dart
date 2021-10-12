import 'package:ecommerce/models/product.dart';
import 'package:flutter/foundation.dart';

class ProductCart with ChangeNotifier, DiagnosticableTreeMixin {
  List<ProductAtCart> _products = [];

  List<ProductAtCart> get products => _products;

  void addProduct(ProductResponse product) {}

  void removeProduct(ProductResponse product) {
    if (_products.remove(product)) {
      notifyListeners();
    }
  }

  void clearProducts() {
    _products.clear();
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<ProductAtCart>('products', products));
  }
}

class ProductAtCart {
  ProductResponse _product;
  int _amount;

  ProductAtCart({required ProductResponse product, required int amount})
      : _product = product,
        _amount = amount;
  ProductResponse get product => _product;
  int get amount => _amount;
  set product(product) => _product = product;
  set amount(amount) => _amount = amount;
}
