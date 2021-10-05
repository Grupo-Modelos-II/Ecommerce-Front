import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' show Response;

import 'package:ecommerce/util/http_client.dart';

import 'package:ecommerce/util/request_conversor.dart';
import 'package:ecommerce/models/product.dart';

class ProductHandler {
  HttpClient _httpClient = HttpClient();
  Future<List<ProductResponse>>? getAllProducts() async {
    final Response response = await _httpClient.get('/product');
    final List<dynamic> productList = json.decode(response.body);
    return fromJsonListProduct(productList);
  }

  Future<ProductResponse>? getProduct(String id) async {
    final Response response = await _httpClient.get('/product/$id');
    final dynamic product = json.decode(response.body);
    return fromJsonProduct(product);
  }
}
