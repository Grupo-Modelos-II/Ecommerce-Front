import 'package:ecommerce/models/purchased.dart';
import 'dart:convert' show json;
import 'package:ecommerce/util/http_client.dart';
import 'package:ecommerce/util/request_conversor';

class PurchaseHandler{
  HttpClient purchaseClient = HttpClient();

  Future<bool> createPurchase(PurchasedRequest request)async{
    var response = await purchaseClient.post('/purchase',body:json.encode(requst.toDict()));
    var bodyResponse = json.decode(response.body);
    PurchasedResponse parseResponseData = fromJsonPurchased(bodyResponse);
    return parseResponseData == null;
  }


}