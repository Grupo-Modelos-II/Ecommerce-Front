import 'package:ecommerce/models/product.dart';
import 'package:flutter/foundation.dart';

class ProductCart with ChangeNotifier, DiagnosticableTreeMixin {
  List<ProductResponse> _products = [];

  List<ProductResponse> get products => _products;

  void addProduct(ProductResponse product) {
    _products.add(product);
    notifyListeners();
  }

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
    properties.add(IterableProperty<ProductResponse>('products', products));
  }
}
