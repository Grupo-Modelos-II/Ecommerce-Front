import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' show Response;

import 'package:ecommerce/util/http_client.dart';

import 'package:ecommerce/util/request_conversor.dart';
import 'package:ecommerce/models/transaction.dart';

class TransactionHandler {
  HttpClient _httpClient = HttpClient();
  Future<List<TransactionResponse>> getAllTransactions() async {
    final Response response = await _httpClient.get('/Transaction');
    final List<dynamic> transactionList = json.decode(response.body);
    return fromJsonListTransaction(transactionList);
  }

  Future<TransactionResponse> getTransaction(String id) async {
    final Response response = await _httpClient.get('/Transaction/$id');
    final dynamic transaction = json.decode(response.body);
    return fromJsonTransaction(transaction);
  }
}