import 'package:ecommerce/util/http_client.dart';
import 'package:ecommerce/models/identifier_type.dart';
import 'package:ecommerce/util/request_conversor.dart';
import 'dart:convert' show json; 

class IdentifierTypeHandler{

  HttpClient identifierTypeClient = HttpClient();

  Future<List<IdentifierTypeResponse>> getAllTypes() async {
    var response = await identifierTypeClient.get('/identifier-type');
    var bodyResponse = json.decode(response.body);
    return fromJsonListIdentifierType(bodyResponse);
  } 

}