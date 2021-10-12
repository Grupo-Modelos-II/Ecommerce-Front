import 'package:ecommerce/models/product.dart';
import 'package:flutter/foundation.dart';

class ProductCart with ChangeNotifier, DiagnosticableTreeMixin {
  List<ProductAtCart> _products = [];

  List<ProductAtCart> get products => _products;

  void addProduct(ProductResponse product) {
    bool exists = false;
    int i;
    for (i = 0; i < _products.length; ++i) {
      if (_products.elementAt(i).product.id == product.id) {
        exists = true;
        break;
      }
    }
    if (exists) {
      _products[i].amount++;
    } else {
      _products.add(ProductAtCart(product: product, amount: 1));
    }
  }

  void removeProduct(ProductAtCart product) {
    if (_products.remove(product)) {
      notifyListeners();
    }
  }

  void clearProducts() {
    _products.clear();
    notifyListeners();
  }

  int getCostCart() {
    int cost = 0;
    for (ProductAtCart product in _products) {
      cost += product.amount * product.product.cost;
    }
    return cost;
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
