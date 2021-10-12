import 'package:ecommerce/util/request_conversor.dart';

import 'generic.dart';
import 'package:ecommerce/models/category.dart';

class ProductImage extends Generic {
  late String idProduct;
  late String image;

  ProductImage({required this.idProduct, required this.image});

  ProductImage.fromJson(dynamic json) {
    idProduct = json['id_product'];
    image = json['image'];
  }
}

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

  Map<String, dynamic> toDict() {
    return {
      'name': this.name,
      'idCategory': this.idCategory,
      'description': this.description,
      'cost': this.cost
    };
  }
}

class ProductResponse extends Generic {
  late final String id;
  late final String name;
  late final int amount;
  late final CategoryResponse category;
  late final String description;
  late final int cost;

  late final String mainImage;
  late final List<ProductImage> images;

  ProductResponse({
    required this.id,
    required this.name,
    required this.amount,
    required this.category,
    required this.description,
    required this.cost,
    required this.mainImage,
    required this.images,
  });
  ProductResponse.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    amount = json['amount'];
    category = CategoryResponse.fromJson(json['category']);
    description = json['description'];
    cost = json['cost'];
    mainImage = json['mainImage'];
    images = fromJsonListProductImage(json['images']);
  }
}
