import 'package:ecommerce/models/category.dart';
import 'package:ecommerce/models/client.dart';
import 'package:ecommerce/models/identifier_type.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/models/purchased.dart';
import 'package:ecommerce/models/transaction.dart';

List<CategoryResponse> fromJsonListCategory(List<dynamic> json) {
  return List.from(json.map((element) => fromJsonCategory(element)));
}

CategoryResponse fromJsonCategory(json) {
  return CategoryResponse.fromJson(json);
}

List<ClientResponse> fromJsonListClient(List<dynamic> json) {
  return List.from(json.map((element) => fromJsonClient(element)));
}

ClientResponse fromJsonClient(json) {
  return ClientResponse.fromJson(json);
}

List<IdentifierTypeResponse> fromJsonListIdentifierType(List<dynamic> json) {
  return List.from(json.map((element) => fromJsonIdentifierType(element)));
}

IdentifierTypeResponse fromJsonIdentifierType(json) {
  return IdentifierTypeResponse.fromJson(json);
}

List<ProductResponse> fromJsonListProduct(List<dynamic> json) {
  return List.from(json.map((element) => fromJsonProduct(element)));
}

ProductResponse fromJsonProduct(json) {
  return ProductResponse.fromJson(json);
}

List<ProductImage> fromJsonListProductImage(List<dynamic> json) {
  return List.from(json.map((element) => fromJsonProductImage(element)));
}

ProductImage fromJsonProductImage(json) {
  return ProductImage.fromJson(json);
}

List<PurchasedResponse> fromJsonListPurchased(List<dynamic> json) {
  return List.from(json.map((element) => fromJsonPurchased(element)));
}

PurchasedResponse fromJsonPurchased(json) {
  return PurchasedResponse.fromJson(json);
}

List<TransactionResponse> fromJsonListTransaction(List<dynamic> json) {
  return List.from(json.map((element) => fromJsonTransaction(element)));
}

TransactionResponse fromJsonTransaction(json) {
  return TransactionResponse.fromJson(json);
}
