import 'generic.dart';
import 'package:ecommerce/models/category.dart';

class ProductRequest {
  final String name;
  final String idCategory;
  final String description;
  final int cost;

  ProductRequest({
    required this.name,
    required this.idCategory,
    required this.description,
    required this.cost,
  });
}

class ProductResponse extends Generic {
  late final String id;
  late final String name;
  late final CategoryResponse category;
  late final String description;
  late final int cost;

  ProductResponse({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.cost,
  });
  ProductResponse.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    category = CategoryResponse.fromJson(json['category']);
    description = json['description'];
    cost = json['cost'];
  }
}
