import 'generic.dart';
import 'product.dart';

class PurchasedRequest {
  String idTransaction;
  String idProduct;
  int amount;
  int cost;
  PurchasedRequest({
    required this.idTransaction,
    required this.idProduct,
    required this.amount,
    required this.cost,
  });
}

class PurchasedResponse extends Generic {
  late String id;
  late ProductResponse product;
  late int amount;
  late int cost;
  PurchasedResponse({
    required this.id,
    required this.product,
    required this.amount,
    required this.cost,
  });
  PurchasedResponse.fromJson(dynamic json) {
    id = json['id'];
    product = ProductResponse.fromJson(json['product']);
    amount = json['amount'];
    cost = json['cost'];
  }
}
