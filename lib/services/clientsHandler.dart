import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' show Response;

import 'package:ecommerce/util/http_client.dart';

import 'package:ecommerce/util/request_conversor.dart';
import 'package:ecommerce/models/client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientHandler {
  HttpClient _httpClient = HttpClient();
  Future<ClientResponse> getClient(String id) async {
    _httpClient.addHeader("Authorization",
        "Bearer ${(await SharedPreferences.getInstance()).getString("token")}");
    final Response response = await _httpClient.get('/client/$id');
    final dynamic client = json.decode(response.body);
    return fromJsonClient(client);
  }

  Future<void> register(){

  }
}
