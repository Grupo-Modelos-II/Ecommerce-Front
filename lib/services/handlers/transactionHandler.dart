import 'dart:async';
import 'dart:convert';

import 'package:ecommerce/services/handlers/authHandler.dart';
import 'package:http/http.dart' show Response;

import 'package:ecommerce/util/http_client.dart';

import 'package:ecommerce/util/request_conversor.dart';
import 'package:ecommerce/models/transaction.dart';

class TransactionHandler {
  HttpClient _httpClient = HttpClient();
  AuthHandler _authHandler = AuthHandler();
  Future<List<TransactionResponse>> getAllTransactions() async {
    final Response response = await _httpClient.get('/transaction');
    final List<dynamic> transactionList = json.decode(response.body);
    return fromJsonListTransaction(transactionList);
  }

  Future<List<TransactionResponse>> getTransactionsByClient() async {
    final Map<String, dynamic> claims = await _authHandler.getTokenClaims();
    final Response response =
        await _httpClient.get("/transaction/client/${claims['id_client']}");
    final List<dynamic> transactionList = json.decode(response.body);
    return fromJsonListTransaction(transactionList);
  }

  Future<TransactionResponse> getTransaction(String id) async {
    final Response response = await _httpClient.get('/transaction/$id');
    final dynamic transaction = json.decode(response.body);
    return fromJsonTransaction(transaction);
  }

  Future<TransactionResponse> createTransaction(
      TransactionRequest request) async {
    _httpClient.addHeader(
        "Authorization", "Bearer ${await _authHandler.getToken()}");
    final Response response = await _httpClient.post('/transaction',
        body: json.encode(request.toDict()));
    final dynamic transaction = json.decode(response.body);
    return fromJsonTransaction(transaction);
  }
}
